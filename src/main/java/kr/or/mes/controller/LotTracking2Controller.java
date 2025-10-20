package kr.or.mes.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.mes.dto.LotTracking2DTO;
import kr.or.mes.service.LotTracking2Service;

@Controller
@RequestMapping("/lotTracking2")
public class LotTracking2Controller {

    @Autowired
    private LotTracking2Service service;

    // 📘 LOT 추적 이력 조회 페이지
    @GetMapping("/list")
    public String listForm() {
        return "lotTracking2/LotTracking2_list"; // JSP 파일명
    }

    // 📗 LOT 번호로 조회
    @GetMapping("/search")
    public String search(@RequestParam("lotNumber") String lotNumber, Model model) {
        List<LotTracking2DTO> trackingList = service.getTrackingByLot(lotNumber);
        model.addAttribute("trackingList", trackingList);
        model.addAttribute("lotNumber", lotNumber);
        return "lotTracking2/LotTracking2_list";
    }

    // 📘 수동으로 이력 추가 (테스트용)
    @PostMapping("/insert")
    public String insert(LotTracking2DTO dto) {
        service.recordTracking(dto);
        return "redirect:/lotTracking2/list";
    }
}
