package kr.or.mes.dao.Quality;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Quality2DTO;

/**
 * 품질검사 DAO 구현체
 * MyBatis SqlSession을 사용하여 QualityManagementMapper.xml의 쿼리 실행
 */
@Repository
public class QualityDAOImplex implements QualityDAO {

	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 품질검사 조회 (통합)
	 * @param dto 검색 조건이 포함된 Quality2DTO
	 * @return 조건에 맞는 품질검사 목록
	 */
	@Override
	public List<Quality2DTO> selectAllQuality(Quality2DTO dto) {
		return sqlSession.selectList("mes.mappers.QualityManagementMapper.selectAllQuality", dto);
	}
	
	/**
	 * 품질검사 등록
	 * @param dto 등록할 품질검사 정보
	 * @return 등록된 행 수
	 */
	@Override
	public int insertQuality(Quality2DTO dto) {
		return sqlSession.insert("mes.mappers.QualityManagementMapper.insertQuality", dto);
	}
	
	/**
	 * 품질검사 수정
	 * @param dto 수정할 품질검사 정보
	 * @return 수정된 행 수
	 */
	@Override
	public int updateQuality(Quality2DTO dto) {
		return sqlSession.update("mes.mappers.QualityManagementMapper.updateQuality", dto);
	}
	
	/**
	 * 품질검사 삭제
	 * @param inspectionNo 삭제할 검사번호
	 * @return 삭제된 행 수
	 */
	@Override
	public int deleteQuality(String inspectionNo) {
		return sqlSession.delete("mes.mappers.QualityManagementMapper.deleteQuality", inspectionNo);
	}
	
	/**
	 * 검사 완료 처리 (HOLD → PASS)
	 * @param dto 검사 완료 정보
	 * @return 업데이트된 행 수
	 */
	@Override
	public int updateQualityToPass(Quality2DTO dto) {
		return sqlSession.update("mes.mappers.QualityManagementMapper.updateQualityToPass", dto);
	}
	
	/**
	 * 불량 레코드 생성
	 * @param dto 불량 정보
	 * @return 등록된 행 수
	 */
	@Override
	public int insertDefectRecord(Quality2DTO dto) {
		return sqlSession.insert("mes.mappers.QualityManagementMapper.insertDefectRecord", dto);
	}
	
	/**
	 * 검사번호로 단건 조회
	 * @param inspectionNo 검사번호
	 * @return 품질검사 정보
	 */
	@Override
	public Quality2DTO selectQualityByInspectionNo(String inspectionNo) {
		return sqlSession.selectOne("mes.mappers.QualityManagementMapper.selectQualityByInspectionNo", inspectionNo);
	}
	
	/**
	 * location 기준으로 품질검사 조회 (등록 전/후 구분)
	 * @param dto location 조건이 포함된 Quality2DTO
	 * @return 조건에 맞는 품질검사 목록
	 */
	@Override
	public List<Quality2DTO> selectQualityByLocation(Quality2DTO dto) {
		return sqlSession.selectList("mes.mappers.QualityManagementMapper.selectQualityByLocation", dto);
	}
	
	/**
	 * 품질검사 location 업데이트
	 * @param dto location과 inspectionNo가 포함된 Quality2DTO
	 * @return 업데이트된 행 수
	 */
	@Override
	public int updateQualityLocation(Quality2DTO dto) {
		return sqlSession.update("mes.mappers.QualityManagementMapper.updateQualityLocation", dto);
	}
}
