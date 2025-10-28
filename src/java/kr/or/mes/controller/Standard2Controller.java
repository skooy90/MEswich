package kr.or.mes.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import kr.or.mes.dto.Standard2DTO;
import kr.or.mes.service.Standard2Service;

@Controller
@RequestMapping("/standard2")
public class Standard2Controller {

    @Autowired
    private Standard2Service service;

    // 목록
    @GetMapping("/list")
    public String list(Model model) {
        System.out.println("✅ [Standard2Controller] /standard2/list 요청 진입");
        List<Standard2DTO> list = service.getAllStandards();
        model.addAttribute("standardList", list);
        return "standard2/Standard2_list";
    }

    // 등록 폼
    @GetMapping("/insertForm")
    public String insertForm() {
        return "standard2/Standard2_insert";
    }

    // 등록 처리
    @PostMapping("/insert")
    public String insert(Model model, Standard2DTO dto) {
        dto.setCreatedBy("admin");
        service.addStandard(dto);
        model.addAttribute(dto);

        return "redirect:/standard2/list";
    }

    // 수정 폼
    @GetMapping("/updateForm/{itemCode}")
    public String updateForm(@PathVariable String itemCode, Model model) {
        model.addAttribute("standard", service.getStandardById(itemCode));
        return "standard2/Standard2_update";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(Standard2DTO dto) {
        dto.setUpdatedBy("admin");
        service.updateStandard(dto);
        return "redirect:/standard2/list";
    }

    // 삭제
    @GetMapping("/delete/{itemCode}")
    public String delete(@PathVariable String itemCode) {
        service.deleteStandard(itemCode);
        return "redirect:/standard2/list";
    }
}
