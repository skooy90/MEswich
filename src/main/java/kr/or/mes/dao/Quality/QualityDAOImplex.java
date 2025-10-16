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
}
