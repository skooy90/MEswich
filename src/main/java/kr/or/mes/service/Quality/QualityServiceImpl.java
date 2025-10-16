package kr.or.mes.service.Quality;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.Quality.QualityDAO;
import kr.or.mes.dto.Quality2DTO;

/**
 * 품질검사 Service 구현체
 * 품질검사의 비즈니스 로직 처리 및 유효성 검사 담당
 */
@Service
public class QualityServiceImpl implements QualityService {

	@Autowired
	private QualityDAO qualityDAO;
	
	/**
	 * 품질검사 조회 (통합)
	 * @param dto 검색 조건이 포함된 Quality2DTO
	 * @return 조건에 맞는 품질검사 목록
	 */
	@Override
	public List<Quality2DTO> selectAllQuality(Quality2DTO dto) {
		return qualityDAO.selectAllQuality(dto);
	}
	
	/**
	 * 상태별 품질검사 조회
	 * @param status 상태값 (PENDING, HOLD, PASS, FAIL)
	 * @return 해당 상태의 품질검사 목록
	 */
	@Override
	public List<Quality2DTO> selectQualityByStatus(String status) {
		if (status == null || status.trim().isEmpty()) {
			return null;
		}
		
		Quality2DTO dto = new Quality2DTO();
		dto.setStatus(status);
		return qualityDAO.selectAllQuality(dto);
	}
	
	/**
	 * 품질검사 등록
	 * @param dto 등록할 품질검사 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String createQuality(Quality2DTO dto) {
		if (dto == null) {
			return "품질검사 정보가 필요합니다.";
		}
		
		// 필수 필드 검증
		if (dto.getWorkOrderNo() == null || dto.getWorkOrderNo().trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		if (dto.getLotNumber() == null || dto.getLotNumber().trim().isEmpty()) {
			return "LOT번호가 필요합니다.";
		}
		
		// 기본 상태 설정
		if (dto.getStatus() == null || dto.getStatus().trim().isEmpty()) {
			dto.setStatus("PENDING");
		}
		
		int result = qualityDAO.insertQuality(dto);
		return result > 0 ? "SUCCESS" : "품질검사 등록에 실패했습니다.";
	}
	
	/**
	 * 품질검사 수정
	 * @param dto 수정할 품질검사 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String updateQuality(Quality2DTO dto) {
		if (dto == null || dto.getInspectionNo() == null) {
			return "품질검사 정보가 필요합니다.";
		}
		
		int result = qualityDAO.updateQuality(dto);
		return result > 0 ? "SUCCESS" : "품질검사 수정에 실패했습니다.";
	}
	
	/**
	 * 품질검사 삭제
	 * @param inspectionNo 삭제할 검사번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String deleteQuality(String inspectionNo) {
		if (inspectionNo == null || inspectionNo.trim().isEmpty()) {
			return "검사번호가 필요합니다.";
		}
		
		int result = qualityDAO.deleteQuality(inspectionNo);
		return result > 0 ? "SUCCESS" : "품질검사 삭제에 실패했습니다.";
	}
	
	/**
	 * 검사 시작 (검사자 배정)
	 * @param inspectionNo 검사번호
	 * @param inspectorId 검사자 ID
	 * @param inspectorName 검사자명
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String startInspection(String inspectionNo, String inspectorId, String inspectorName) {
		if (inspectionNo == null || inspectionNo.trim().isEmpty()) {
			return "검사번호가 필요합니다.";
		}
		
		if (inspectorId == null || inspectorId.trim().isEmpty()) {
			return "검사자 ID가 필요합니다.";
		}
		
		if (inspectorName == null || inspectorName.trim().isEmpty()) {
			return "검사자명이 필요합니다.";
		}
		
		Quality2DTO dto = new Quality2DTO();
		dto.setInspectionNo(inspectionNo);
		dto.setInspectorId(inspectorId);
		dto.setInspectorName(inspectorName);
		dto.setStatus("HOLD"); // 검사 중 상태로 변경
		
		int result = qualityDAO.updateQuality(dto);
		return result > 0 ? "SUCCESS" : "검사 시작 처리에 실패했습니다.";
	}
	
	/**
	 * 검사 완료 (검사 결과 입력)
	 * @param inspectionNo 검사번호
	 * @param goodQty 양품수량
	 * @param defectQty 불량수량
	 * @param defectReason 불량사유
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String completeInspection(String inspectionNo, Integer goodQty, Integer defectQty, String defectReason) {
		if (inspectionNo == null || inspectionNo.trim().isEmpty()) {
			return "검사번호가 필요합니다.";
		}
		
		if (goodQty == null || defectQty == null) {
			return "양품수량과 불량수량이 필요합니다.";
		}
		
		if (goodQty < 0 || defectQty < 0) {
			return "수량은 0 이상이어야 합니다.";
		}
		
		if (goodQty + defectQty == 0) {
			return "양품수량과 불량수량의 합이 0이 될 수 없습니다.";
		}
		
		Quality2DTO dto = new Quality2DTO();
		dto.setInspectionNo(inspectionNo);
		dto.setGoodQty(goodQty);
		dto.setDefectQty(defectQty);
		dto.setDefectReason(defectReason);
		
		// 검사 결과에 따른 상태 설정
		if (defectQty == 0) {
			dto.setStatus("PASS"); // 불량이 없으면 합격
		} else {
			dto.setStatus("FAIL"); // 불량이 있으면 불합격
		}
		
		int result = qualityDAO.updateQuality(dto);
		return result > 0 ? "SUCCESS" : "검사 완료 처리에 실패했습니다.";
	}
}
