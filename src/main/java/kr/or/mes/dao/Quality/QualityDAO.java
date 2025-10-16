package kr.or.mes.dao.Quality;

import java.util.List;
import kr.or.mes.dto.Quality2DTO;

/**
 * 품질검사 DAO 인터페이스
 * 품질검사의 데이터 접근 기능을 정의
 */
public interface QualityDAO {

	/**
	 * 품질검사 조회 (통합)
	 * @param dto 검색 조건이 포함된 Quality2DTO
	 * @return 조건에 맞는 품질검사 목록
	 */
	List<Quality2DTO> selectAllQuality(Quality2DTO dto);
	
	/**
	 * 품질검사 등록
	 * @param dto 등록할 품질검사 정보
	 * @return 등록된 행 수
	 */
	int insertQuality(Quality2DTO dto);
	
	/**
	 * 품질검사 수정
	 * @param dto 수정할 품질검사 정보
	 * @return 수정된 행 수
	 */
	int updateQuality(Quality2DTO dto);
	
	/**
	 * 품질검사 삭제
	 * @param inspectionNo 삭제할 검사번호
	 * @return 삭제된 행 수
	 */
	int deleteQuality(String inspectionNo);
}
