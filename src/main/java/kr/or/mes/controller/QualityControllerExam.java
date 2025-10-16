package kr.or.mes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.mes.dto.Quality2DTO;
import kr.or.mes.service.QualityExam.QualityServiceex;

@Controller
@RequestMapping("quality2")
public class QualityControllerExam {

	@Autowired
    private QualityServiceex qualityservice;
	
	@GetMapping({"", "/"})
    public String quality(Model model, Quality2DTO dto, String status) {
		// 서비스에서 비즈니스 로직 처리
				List<Quality2DTO> list = qualityservice.selectAllQuality(dto, status);
				
				model.addAttribute("list", list);
				model.addAttribute("selectedStatus", status); // 현재 선택된 상태값
				return "quality/qualitylist";
	}
	
}
