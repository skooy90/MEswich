package kr.or.mes.service.Inventory2;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.Inventory2.Inventory2DAO;
import kr.or.mes.dao.Quality.QualityDAO;
import kr.or.mes.dto.DailyProduction2DTO;
import kr.or.mes.dto.Inventory2DTO;
import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Quality2DTO;
import kr.or.mes.service.DailyProduction.DailyProduction2Service;
import kr.or.mes.service.Production.Production2Service;

/**
 * 재고관리 Service 구현체 재고관리의 비즈니스 로직 처리 및 유효성 검사 담당
 */
@Service
public class Inventory2ServiceImpl implements Inventory2Service {

	@Autowired
	private Inventory2DAO inventory2DAO;

	@Autowired
	private QualityDAO qualityDAO;

	@Autowired
	private DailyProduction2Service dailyProductionService;
	@Autowired
	private Production2Service productionService;

	/**
	 * 전체재고현황 조회
	 * 
	 * @param dto 검색 조건이 포함된 Inventory2DTO
	 * @return 조건에 맞는 재고 목록
	 */
	@Override
	public List<Inventory2DTO> selectAllInventory(Inventory2DTO dto) {
		return inventory2DAO.selectAllInventory(dto);
	}

	/**
	 * 재고 상세 조회
	 * 
	 * @param inventoryId 재고 ID
	 * @return 해당 재고 정보
	 */
	@Override
	public Inventory2DTO selectInventoryById(int inventoryId) {
		if (inventoryId <= 0) {
			return null;
		}
		return inventory2DAO.selectInventoryById(inventoryId);
	}

	/**
	 * 조건별 재고 검색
	 * 
	 * @param dto 검색 조건이 포함된 Inventory2DTO
	 * @return 조건에 맞는 재고 목록
	 */
	@Override
	public List<Inventory2DTO> selectInventoryByCondition(Inventory2DTO dto) {
		return inventory2DAO.selectInventoryByCondition(dto);
	}

	/**
	 * 재고 등록
	 * 
	 * @param dto 등록할 재고 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String insertInventory(Inventory2DTO dto) {
		if (dto == null) {
			return "재고 정보가 필요합니다.";
		}

		// 필수 필드 검증
		if (dto.getItemCode() == null || dto.getItemCode().trim().isEmpty()) {
			return "품목코드가 필요합니다.";
		}

		if (dto.getLotNumber() == null || dto.getLotNumber().trim().isEmpty()) {
			return "LOT번호가 필요합니다.";
		}

		if (dto.getCurrentQty() == 0 || dto.getCurrentQty() < 0) {
			return "수량이 필요합니다.";
		}

		// 재고 중복 체크
		Inventory2DTO existingInventory = inventory2DAO.selectInventoryByLot(dto.getLotNumber());
		if (existingInventory != null) {
			return "이미 등록된 LOT번호입니다.";
		}

		int result = inventory2DAO.insertInventory(dto);
		return result > 0 ? "SUCCESS" : "재고 등록에 실패했습니다.";
	}

	/**
	 * 품질검사에서 재고 등록 (단순화된 로직)
	 * 
	 * @param inspectionNo 검사번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String registerFromQuality(String inspectionNo) {
		if (inspectionNo == null || inspectionNo.trim().isEmpty()) {
			return "검사번호가 필요합니다.";
		}

		try {
			// 1. 품질검사 정보 조회
			Quality2DTO quality = qualityDAO.selectQualityByInspectionNo(inspectionNo);
			if (quality == null) {
				return "검사 정보를 찾을 수 없습니다.";
			}

			if (!"PASS".equals(quality.getStatus())) {
				return "검사 합격 항목만 재고 등록이 가능합니다.";
			}

			if (quality.getGoodQty() == null || quality.getGoodQty() <= 0) {
				return "양품수량이 없습니다.";
			}

			// 2. 이미 등록 완료면 재진행 차단 (중복 방지)
			if ("REGISTERED".equalsIgnoreCase(quality.getLocation())) {
				return "이미 등록 완료된 항목입니다.";
			}

			// 3. LOT 중복 체크
			Inventory2DTO existingInventory = inventory2DAO.selectInventoryByLot(quality.getLotNumber());
			if (existingInventory != null) {
				System.out.println("DEBUG: 기존 재고 발견 - 현재 수량: " + existingInventory.getCurrentQty());
				System.out.println("DEBUG: 추가할 수량: " + quality.getGoodQty());

				// 기존 재고에 수량 추가
				int newQty = existingInventory.getCurrentQty() + quality.getGoodQty();
				existingInventory.setCurrentQty(newQty);
				existingInventory.setUpdatedBy("SYSTEM");

				System.out.println("DEBUG: 새로운 수량: " + newQty);

				int updateResult = inventory2DAO.updateInventory(existingInventory);
				System.out.println("DEBUG: updateInventory 결과: " + updateResult);

				if (updateResult <= 0) {
					return "재고 수량 업데이트에 실패했습니다.";
				}

				// 품질검사 상태 업데이트
				quality.setLocation("REGISTERED");
				quality.setUpdatedBy("SYSTEM");
				int qualityResult = qualityDAO.updateQualityLocation(quality);
				if (qualityResult <= 0) {
					return "품질검사 상태 업데이트에 실패했습니다.";
				}

				// 6. 금일 생산계획 상태 업데이트 + 전체 생산계획 실제 수량 증가 (통합)
				if (quality.getDailyLotNumber() != null) {
					DailyProduction2DTO dailyInfo = dailyProductionService
							.selectDailyProductionByLotNumber(quality.getDailyLotNumber());
					if (dailyInfo != null) {
						String parentLotNumber = dailyInfo.getParentLotNumber();

						// 6-1. 금일 생산계획 상태를 'inventory'로 업데이트
						DailyProduction2DTO dailyProduction = new DailyProduction2DTO();
						dailyProduction.setDailyPlanId(dailyInfo.getDailyPlanId());
						dailyProduction.setStatus("inventory");
						dailyProduction.setUpdatedBy("SYSTEM");
						dailyProductionService.updateDailyProductionStatus(dailyProduction);

						// 6-2. 전체 생산계획의 실제 생산 수량 증가
						Production2DTO parentProduction = productionService
								.selectProductionForDailySchedule(parentLotNumber);
						if (parentProduction != null) {
							int currentActualQty = (parentProduction.getActualQty() != null)
									? parentProduction.getActualQty()
									: 0;
							int newActualQty = currentActualQty + quality.getGoodQty();

							Production2DTO updateParent = new Production2DTO();
							updateParent.setLotNumber(parentLotNumber);
							updateParent.setActualQty(newActualQty);
							updateParent.setUpdatedBy("SYSTEM");

							int updateResult2 = productionService.updateActualQuantity(updateParent);
							System.out.println("DEBUG: updateActualQuantity 결과 = " + updateResult2);

							if (updateResult2 <= 0) {
								System.out.println("ERROR: actual_qty 업데이트 실패!");
								return "실제 생산 수량 업데이트에 실패했습니다.";
							}
							// 6-3. 전체 생산계획 완료 여부 확인
							if (newActualQty >= parentProduction.getPlannedQty()) {
								System.out.println("DEBUG: 전체 생산계획 완료 조건 충족 - 상태 변경 시작");
								Production2DTO completeParent = new Production2DTO();
								completeParent.setLotNumber(parentLotNumber);
								completeParent.setStatus("COMPLETED");
								completeParent.setUpdatedBy("SYSTEM");
								productionService.updateStatus(completeParent);
							}
						}
					}
				}

				return "SUCCESS";
			}

			// 4. 재고 등록
			Inventory2DTO newInventory = new Inventory2DTO();
			newInventory.setItemCode(quality.getProductCode());
			newInventory.setLotNumber(quality.getLotNumber());
			newInventory.setDailyLotNumber(quality.getDailyLotNumber()); // 금일 생산 LOT 번호 추가
			newInventory.setCurrentQty(quality.getGoodQty());
			newInventory.setLocation("REGISTERED");
			newInventory.setCreatedBy("SYSTEM");

			int inventoryResult = inventory2DAO.insertInventory(newInventory);
			if (inventoryResult <= 0) {
				return "재고 등록에 실패했습니다.";
			}

			// 5. 품질검사 상태 업데이트 (등록 완료로 표시)
			System.out.println("DEBUG: 업데이트할 inspection_no = " + quality.getInspectionNo());
			System.out.println("DEBUG: 업데이트할 location = " + quality.getLocation());
			quality.setLocation("REGISTERED");
			quality.setUpdatedBy("SYSTEM");
			int qualityResult = qualityDAO.updateQualityLocation(quality);
			if (qualityResult <= 0) {
				return "품질검사 상태 업데이트에 실패했습니다.";
			}

			// 6. 전체 생산계획 업데이트 (처음 등록 시에도 실행)
			if (quality.getDailyLotNumber() != null) {
				DailyProduction2DTO dailyInfo = dailyProductionService
						.selectDailyProductionByLotNumber(quality.getDailyLotNumber());
				if (dailyInfo != null) {
					String parentLotNumber = dailyInfo.getParentLotNumber();

					// 6-1. 금일 생산계획 상태를 'inventory'로 업데이트
					DailyProduction2DTO dailyProduction = new DailyProduction2DTO();
					dailyProduction.setDailyPlanId(dailyInfo.getDailyPlanId());
					dailyProduction.setStatus("inventory");
					dailyProduction.setUpdatedBy("SYSTEM");
					dailyProductionService.updateDailyProductionStatus(dailyProduction);

					// 6-2. 전체 생산계획의 실제 생산 수량 증가
					Production2DTO parentProduction = productionService
							.selectProductionForDailySchedule(parentLotNumber);
					if (parentProduction != null) {
						int currentActualQty = (parentProduction.getActualQty() != null)
								? parentProduction.getActualQty()
								: 0;
						int newActualQty = currentActualQty + quality.getGoodQty();

						Production2DTO updateParent = new Production2DTO();
						updateParent.setLotNumber(parentLotNumber);
						updateParent.setActualQty(newActualQty);
						updateParent.setUpdatedBy("SYSTEM");

						int updateResult2 = productionService.updateActualQuantity(updateParent);
						System.out.println("DEBUG: updateActualQuantity 결과 = " + updateResult2);

						if (updateResult2 <= 0) {
							System.out.println("ERROR: actual_qty 업데이트 실패!");
							return "실제 생산 수량 업데이트에 실패했습니다.";
						}

						// 6-3. 전체 생산계획 완료 여부 확인
						if (newActualQty >= parentProduction.getPlannedQty()) {
							System.out.println("DEBUG: 전체 생산계획 완료 조건 충족 - 상태 변경 시작");
							Production2DTO completeParent = new Production2DTO();
							completeParent.setLotNumber(parentLotNumber);
							completeParent.setStatus("COMPLETED");
							completeParent.setUpdatedBy("SYSTEM");
							productionService.updateStatus(completeParent);
						}
					}
				}
			}

			return "SUCCESS";

		} catch (Exception e) {
			return "재고 등록 처리 중 오류가 발생했습니다: " + e.getMessage();
		}
	}

	/**
	 * 일괄 재고 등록 (품질검사에서)
	 * 
	 * @param inspectionNos 검사번호 목록
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String batchRegisterFromQuality(List<String> inspectionNos) {
		if (inspectionNos == null || inspectionNos.isEmpty()) {
			return "검사번호 목록이 필요합니다.";
		}

		int successCount = 0;
		int failCount = 0;

		for (String inspectionNo : inspectionNos) {
			String result = registerFromQuality(inspectionNo);
			if ("SUCCESS".equals(result)) {
				successCount++;
			} else {
				failCount++;
			}
		}

		if (failCount == 0) {
			return "SUCCESS";
		} else {
			return "일부 등록에 실패했습니다. 성공: " + successCount + ", 실패: " + failCount;
		}
	}

	/**
	 * 재고 수정
	 * 
	 * @param dto 수정할 재고 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String updateInventory(Inventory2DTO dto) {
		if (dto == null || dto.getInventoryId() <= 0) {
			return "재고 정보가 필요합니다.";
		}

		if (dto.getCurrentQty() == 0 || dto.getCurrentQty() < 0) {
			return "수량이 필요합니다.";
		}

		int result = inventory2DAO.updateInventory(dto);
		return result > 0 ? "SUCCESS" : "재고 수정에 실패했습니다.";
	}

	/**
	 * 재고 삭제
	 * 
	 * @param inventoryId 삭제할 재고 ID
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String deleteInventory(int inventoryId) {
		if (inventoryId <= 0) {
			return "재고 ID가 필요합니다.";
		}

		int result = inventory2DAO.deleteInventory(inventoryId);
		return result > 0 ? "SUCCESS" : "재고 삭제에 실패했습니다.";
	}
}
