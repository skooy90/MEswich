package kr.or.mes.service.QualityExam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.qualityExam.QualityDAOex;
import kr.or.mes.dto.Quality2DTO;

@Service
public class QualityServiceImplex implements QualityServiceex {

	@Autowired
	private QualityDAOex qualityDAO;


	@Override
	public List<Quality2DTO> selectAllQuality(Quality2DTO dto, String status) {
		if (status != null && !status.trim().isEmpty()) {
	        dto.setStatus(status.toUpperCase());
	    }
	    
	    return qualityDAO.selectAllQuality(dto);
	}

}
