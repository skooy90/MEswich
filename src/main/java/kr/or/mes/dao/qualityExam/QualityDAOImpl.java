package kr.or.mes.dao.qualityExam;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Quality2DTO;

@Repository
public class QualityDAOImpl implements QualityDAOex {

	@Autowired
	SqlSession sqlSession; 
	
	@Override
	public List<Quality2DTO> selectAllQuality(Quality2DTO dto) {
		return sqlSession.selectList("mes.mappers.Quality.selectAllQuality", dto);
	}

}
