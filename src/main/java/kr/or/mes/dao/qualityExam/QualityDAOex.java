package kr.or.mes.dao.qualityExam;

import java.util.List;

import kr.or.mes.dto.Quality2DTO;

public interface QualityDAOex {

	List<Quality2DTO> selectAllQuality(Quality2DTO dto);
}
