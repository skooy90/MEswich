package kr.or.mes.service.QualityExam;

import java.util.List;

import kr.or.mes.dto.Quality2DTO;

public interface QualityServiceex {

	List<Quality2DTO> selectAllQuality(Quality2DTO dto ,String status);
}
