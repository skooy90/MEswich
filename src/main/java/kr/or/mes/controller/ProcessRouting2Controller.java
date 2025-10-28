package kr.or.mes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.mes.dto.ProcessRouting2DTO;
import kr.or.mes.service.ProcessRouting2Service;

@Controller
@RequestMapping("/processRouting2")
public class ProcessRouting2Controller {

    @Autowired
    private ProcessRouting2Service service;

    // 공정 목록 조회
    @GetMapping("/list")
    public String list(Model model) {
        // productCode 단위로 묶여서 보여줄 것이므로, productCode만 distinct 조회
        List<ProcessRouting2DTO> routingSummary = service.getDistinctProductList();
        model.addAttribute("routingSummary", routingSummary);
        return "routing2/ProcessRouting2_list";
    }

    // 등록 폼
    @GetMapping("/insertForm")
    public String insertForm(Model model) {
        model.addAttribute("processRouting", new ProcessRouting2DTO());
        return "routing2/ProcessRouting2_insert";
    }

    // 등록 처리
    @PostMapping("/insert")
    public String insert(@ModelAttribute ProcessRouting2DTO dto) {
        service.insertRouting(dto);
        return "redirect:/processRouting2/list";
    }

 // 수정 폼
    @GetMapping("/updateForm/{routingId}")
    public String updateForm(@PathVariable("routingId") int routingId, Model model) {
        ProcessRouting2DTO dto = service.getRoutingById(routingId);
        model.addAttribute("processRouting", dto);
        return "routing2/ProcessRouting2_update";
    }

 // 수정 처리
    @PostMapping("/update")
    public String update(@ModelAttribute ProcessRouting2DTO dto) {
        service.updateRouting(dto);
        return "redirect:/processRouting2/detail/" + dto.getProductCode();
    }

    // 삭제 처리
    @GetMapping("/delete/{routingId}")
    public String delete(@PathVariable("routingId") int routingId) {
        service.deleteRouting(routingId);
        return "redirect:/processRouting2/list";
    }
    
 // 상세 페이지
    @GetMapping("/detail/{productCode}")
    public String detail(@PathVariable("productCode") String productCode, Model model) {
        List<ProcessRouting2DTO> routingList = service.getRoutingsByProductCode(productCode);
        model.addAttribute("routingList", routingList);
        return "routing2/ProcessRouting2_detail";
    }
}
