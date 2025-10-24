package kr.or.mes.service.Production;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.production.Production2DAO;
import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;
import kr.or.mes.service.WorkOrders.WorkOrdersService;

/**
 * 생산관리 Service 구현체
 * 생산 LOT 관리 비즈니스 로직을 구현
 */
@Service
public class Production2ServiceImpl implements Production2Service {

	@Autowired
	private Production2DAO productionDAO;
	@Autowired
    private WorkOrdersService workOrdersService;
	
	// 사용되지 않는 메서드들 제거됨 - 실제로는 selectAllProductionPlans() 사용
	
	/**
	 * 조건에 따른 생산 LOT 검색
	 * @param dto 검색 조건이 담긴 DTO
	 * @return 검색된 생산 LOT 목록
	 */
	@Override
	public List<Production2DTO> selectByCondition(Production2DTO dto) {
		return productionDAO.selectByCondition(dto);
	}
	
	/**
	 * LOT번호로 생산 LOT 단건 조회
	 * @param lotNumber LOT번호
	 * @return 생산 LOT 정보
	 */
	@Override
	public Production2DTO selectByLotNumber(String lotNumber) {
		return productionDAO.selectByLotNumber(lotNumber);
	}
	
	// insert() 메서드 제거됨 - 실제로는 createAllProduction() 사용
	
	/**
	 * 생산 LOT 등록 처리 (비즈니스 로직 포함)
	 * @param production 등록할 생산 LOT 정보
	 * @return 등록 결과 메시지
	 */
	@Override
	public String createProduction(Production2DTO production) {
		// 비즈니스 로직: 상태 기본값 설정
		if (production.getStatus() == null || production.getStatus().trim().isEmpty()) {
			production.setStatus("PLANNED");
		}
		
		// 비즈니스 로직: 필수 필드 유효성 검사
		if (production.getProductCode() == null || production.getProductCode().trim().isEmpty()) {
			return "제품코드를 선택해주세요.";
		}
		
		if (production.getPlannedQty() <= 0) {
			return "계획수량은 1 이상이어야 합니다.";
		}
		
		if (production.getPlannedStartDate() == null) {
			return "계획시작일을 입력해주세요.";
		}
		
		if (production.getPlannedEndDate() == null) {
			return "계획종료일을 입력해주세요.";
		}
		
		
		
		// 등록 실행
		int result = productionDAO.insertAllProduction(production);
		if (result > 0) {
			return "SUCCESS";
		} else {
			return "생산 LOT 등록에 실패했습니다.";
		}
		
		
	}
	
	/**
	 * 생산 LOT 정보 수정
	 * @param production 수정할 생산 LOT 정보
	 * @return 수정 결과 (1: 성공, 0: 실패)
	 */
	@Override
	public int update(Production2DTO production) {
		return productionDAO.update(production);
	}
	
	/**
	 * 생산 LOT 수정 처리 (비즈니스 로직 포함)
	 * @param production 수정할 생산 LOT 정보
	 * @return 수정 결과 메시지
	 */
	@Override
	public String updateProduction(Production2DTO production) {
		// 비즈니스 로직: 계획수량 유효성 검사
		if (production.getPlannedQty() <= 0) {
			return "계획수량은 1 이상이어야 합니다.";
		}
		
		// 비즈니스 로직: 기존 생산 LOT 존재 여부 확인
		Production2DTO existingProduction = productionDAO.selectByLotNumber(production.getLotNumber());
		if (existingProduction == null) {
			return "해당 생산 LOT를 찾을 수 없습니다.";
		}
		
		// 비즈니스 로직: 계획수량만 업데이트
		existingProduction.setPlannedQty(production.getPlannedQty());
		
		// 수정 실행
		int result = productionDAO.update(existingProduction);
		if (result > 0) {
			return "SUCCESS"; // 성공 시 특별한 메시지
		} else {
			return "생산 LOT 수정에 실패했습니다.";
		}
	}
	
	/**
	 * 생산 LOT 삭제
	 * @param lotNumber 삭제할 LOT번호
	 * @return 삭제 결과 메시지
	 */
	@Override
	public String deleteProduction(String lotNumber) {
		// 비즈니스 로직: 삭제 전 유효성 검사
		if (lotNumber == null || lotNumber.trim().isEmpty()) {
			return "LOT번호가 올바르지 않습니다.";
		}
		
		// 기존 생산 LOT 존재 여부 확인
		Production2DTO existingProduction = productionDAO.selectByLotNumber(lotNumber);
		if (existingProduction == null) {
			return "삭제할 생산 LOT를 찾을 수 없습니다.";
		}
		
		// 삭제 실행
		int deleteResult = productionDAO.delete(lotNumber);
		if (deleteResult > 0) {
			return "생산 LOT가 성공적으로 삭제되었습니다.";
		} else {
			return "삭제 중 오류가 발생했습니다.";
		}
	}
	
	/**
	 * 생산 LOT 상태 업데이트
	 * @param production 상태 업데이트할 생산 LOT 정보
	 * @return 업데이트 결과 (1: 성공, 0: 실패)
	 */
	@Override
	public int updateStatus(Production2DTO production) {
		return productionDAO.updateStatus(production);
	}
	
	/**
	 * 생산 LOT 실제 수량 업데이트
	 * @param production 실제 수량 업데이트할 생산 LOT 정보
	 * @return 업데이트 결과 (1: 성공, 0: 실패)
	 */
	@Override
	public int updateActualQuantity(Production2DTO production) {
		return productionDAO.updateActualQuantity(production);
	}
	
	/**
	 * 완제품 목록 조회 (생산계획 등록용)
	 * @return 완제품 목록
	 */
	@Override
	public List<Standard2DTO> selectFinishedGoods() {
		return productionDAO.selectFinishedGoods();
	}
	
	/**
	 * 상태별 생산 LOT 조회
	 * @param status 조회할 상태
	 * @return 해당 상태의 생산 LOT 목록
	 */
	@Override
	public List<Production2DTO> selectByStatus(String status) {
		return productionDAO.selectByStatus(status);
	}
	
	/**
	 * 생산 LOT 상세 조회 (비즈니스 로직 포함)
	 * @param lotNumber LOT번호
	 * @return 생산 LOT 정보 또는 null
	 */
	@Override
	public Production2DTO getProductionDetail(String lotNumber) {
		// 비즈니스 로직: LOT번호 유효성 검사
		if (lotNumber == null || lotNumber.trim().isEmpty()) {
			return null;
		}
		
		return productionDAO.selectByLotNumber(lotNumber);
	}
	
	/**
	 * 생산 LOT 수정 폼 데이터 조회 (비즈니스 로직 포함)
	 * @param lotNumber LOT번호
	 * @return 생산 LOT 정보 또는 null
	 */
	@Override
	public Production2DTO getProductionForEdit(String lotNumber) {
		// 비즈니스 로직: LOT번호 유효성 검사
		if (lotNumber == null || lotNumber.trim().isEmpty()) {
			return null;
		}
		
		return productionDAO.selectByLotNumber(lotNumber);
	}
	
	// ==================== 전체 생산계획 관련 메서드 ====================
	
	/**
	 * 전체 생산계획 조회
	 * @return 전체 생산계획 목록
	 */
	@Override
	public List<Production2DTO> selectAllProductionPlans() {
		return productionDAO.selectAllProductionPlans();
	}
	
	/**
	 * 전체 생산계획 등록
	 * @param production 등록할 전체 생산계획 정보
	 * @return 등록 결과 메시지
	 */
	@Override
	public String createAllProduction(Production2DTO production) {
		// 비즈니스 로직: 상태 기본값 설정
		if (production.getStatus() == null || production.getStatus().trim().isEmpty()) {
			production.setStatus("PLANNED");
		}
		
		// 비즈니스 로직: 필수 필드 유효성 검사
		if (production.getProductCode() == null || production.getProductCode().trim().isEmpty()) {
			return "제품코드를 선택해주세요.";
		}
		
		if (production.getPlannedQty() <= 0) {
			return "계획수량은 1 이상이어야 합니다.";
		}
		
		if (production.getPlannedStartDate() == null) {
			return "계획시작일을 입력해주세요.";
		}
		
		if (production.getPlannedEndDate() == null) {
			return "계획종료일을 입력해주세요.";
		}
		
		// 등록 실행
		int result = productionDAO.insertAllProduction(production);
		if (result > 0) {
			return "SUCCESS";
		} else {
			return "전체 생산계획 등록에 실패했습니다.";
		}
	}
	
	// ==================== 금일 생산계획 관련 메서드 ====================
	
	// 금일 생산계획 관련 메서드들은 DailyProduction2Service에서 처리됨
	
	/**
	 * 전체 생산계획에서 금일 생산계획 생성용 데이터 조회
	 * @param lotNumber LOT번호
	 * @return 전체 생산계획 정보
	 */
	@Override
	public Production2DTO selectProductionForDailySchedule(String lotNumber) {
		// 비즈니스 로직: LOT번호 유효성 검사
		if (lotNumber == null || lotNumber.trim().isEmpty()) {
			return null;
		}
		
		return productionDAO.selectProductionForDailySchedule(lotNumber);
	}
	
	/**
	 * 금일 생산계획 상태 업데이트
	 * @param production 상태 업데이트할 금일 생산계획 정보
	 * @return 업데이트 결과 (1: 성공, 0: 실패)
	 */
	@Override
	public int updateDailyProductionStatus(Production2DTO production) {
		return productionDAO.updateDailyProductionStatus(production);
	}
	
}
