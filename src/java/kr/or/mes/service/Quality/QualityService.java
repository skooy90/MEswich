package kr.or.mes.service.Quality;

import java.util.List;
import kr.or.mes.dto.Quality2DTO;

/**
 * 품질검사 Service 인터페이스
 * 품질검사의 비즈니스 로직을 정의
 */
public interface QualityService {

	/**
	 * 품질검사 조회 (통합)
	 * @param dto 검색 조건이 포함된 Quality2DTO
	 * @return 조건에 맞는 품질검사 목록
	 */
	List<Quality2DTO> selectAllQuality(Quality2DTO dto);
	
	/**
	 * 상태별 품질검사 조회
	 * @param status 상태값 (PENDING, HOLD, PASS, FAIL)
	 * @return 해당 상태의 품질검사 목록
	 */
	List<Quality2DTO> selectQualityByStatus(String status);
	
	/**
	 * 품질검사 등록
	 * @param dto 등록할 품질검사 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	String createQuality(Quality2DTO dto);
	
	/**
	 * 품질검사 수정
	 * @param dto 수정할 품질검사 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	String updateQuality(Quality2DTO dto);
	
	/**
	 * 품질검사 삭제
	 * @param inspectionNo 삭제할 검사번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	String deleteQuality(String inspectionNo);
	
	/**
	 * 검사 시작 (검사자 배정)
	 * @param inspectionNo 검사번호
	 * @param inspectorId 검사자 ID
	 * @param inspectorName 검사자명
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	String startInspection(String inspectionNo, String inspectorId, String inspectorName);
	
	/**
	 * 검사 완료 (검사 결과 입력)
	 * @param inspectionNo 검사번호
	 * @param goodQty 양품수량
	 * @param defectQty 불량수량
	 * @param defectReason 불량사유
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	String completeInspection(String inspectionNo, Integer goodQty, Integer defectQty, String defectReason);
}
