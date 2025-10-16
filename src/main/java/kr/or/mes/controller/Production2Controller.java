package kr.or.mes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.mes.service.Production.Production2Service;
import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

@Controller
@RequestMapping("/production")
public class Production2Controller {

    @Autowired
    private Production2Service productionService;

//      생산관리 메인 페이지
    
    @GetMapping("/list")
    public String productionList(Model model) {
        List<Production2DTO> productionList = productionService.selectAll();
        model.addAttribute("productionList", productionList);
        return "production/productionList";
    }

//     * 생산 LOT 검색
    @GetMapping("/search")
    public String searchProduction(@ModelAttribute Production2DTO searchCondition, Model model) {
        List<Production2DTO> productionList = productionService.selectByCondition(searchCondition);
        model.addAttribute("productionList", productionList);
        model.addAttribute("searchCondition", searchCondition);
        return "production/productionList";
    }

//     * 생산계획 추가 페이지
    @GetMapping("/create")
    public String createProductionForm(Model model) {
        // 완제품 목록 조회
        List<Standard2DTO> productList = productionService.selectFinishedGoods();
        model.addAttribute("productList", productList);
        return "production/productionCreate";
    }

//     * 생산계획 등록 처리
    public String createProduction(@ModelAttribute Production2DTO production, Model model) {
        String result = productionService.createProduction(production);
        if ("SUCCESS".equals(result)) {
            return "redirect:/production/list";
        } else {
            model.addAttribute("error", result);
            // 등록 실패 시 완제품 목록 다시 조회
            List<Standard2DTO> productList = productionService.selectFinishedGoods();
            model.addAttribute("productList", productList);
            return "production/productionCreate";
        }
    }

//     * 생산 LOT 상세보기
    @GetMapping("/detail")
    public String productionDetail(@RequestParam String lotNumber, Model model) {
        Production2DTO production = productionService.getProductionDetail(lotNumber);
        if (production != null) {
            model.addAttribute("production", production);
            return "production/productionDetail";
        } else {
            model.addAttribute("error", "해당 생산 LOT를 찾을 수 없습니다.");
            return "redirect:/production/list";
        }
    }

//     * 생산 LOT 수정 페이지
    @GetMapping("/edit")
    public String editProductionForm(@RequestParam String lotNumber, Model model) {
        Production2DTO production = productionService.getProductionForEdit(lotNumber);
        if (production != null) {
            model.addAttribute("production", production);
            return "production/productionEdit";
        } else {
            model.addAttribute("error", "해당 생산 LOT를 찾을 수 없습니다.");
            return "redirect:/production/list";
        }
    }

//     * 생산 LOT 수정 처리
    @PostMapping("/edit")
    public String editProduction(@ModelAttribute Production2DTO production, Model model) {
        String result = productionService.updateProduction(production);
        if ("SUCCESS".equals(result)) {
            return "redirect:/production/list";
        } else {
            model.addAttribute("error", result);
            Production2DTO existingProduction = productionService.getProductionForEdit(production.getLotNumber());
            model.addAttribute("production", existingProduction);
            return "production/productionEdit";
        }
    }

//     * 생산 LOT 삭제 처리
    @PostMapping("/delete")
    public String deleteProduction(@RequestParam String lotNumber) {
        productionService.deleteProduction(lotNumber);
        return "redirect:/production/list";
    }

}
