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

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;
import kr.or.mes.dto.DailyProduction2DTO;
import kr.or.mes.service.Production.Production2Service;
import kr.or.mes.service.DailyProduction.DailyProduction2Service;
import kr.or.mes.service.WorkOrders.WorkOrdersService;

@Controller
@RequestMapping("/production")
public class Production2Controller {

    @Autowired
    private Production2Service productionService;
    
    @Autowired
    private DailyProduction2Service dailyProductionService;
    
    @Autowired
    private WorkOrdersService workOrdersService;

    /**
     * 생산관리 메인 페이지 (전체 생산일정 + 금일 생산일정)
     */
    @GetMapping("/list")
    public String productionList(Model model) {
        // 전체 생산계획 조회
        List<Production2DTO> allProductionList = productionService.selectAllProductionPlans();
        model.addAttribute("productionList", allProductionList);
        
        // 금일 생산계획 조회 (Daily)
        List<DailyProduction2DTO> dailyScheduleList = dailyProductionService.selectAllDailyProductionPlans();
        model.addAttribute("dailyScheduleList", dailyScheduleList);
        
        return "production/productionList";
    }

    /**
     * 전체 생산계획 검색
     */
    @GetMapping("/search")
    public String searchProduction(@ModelAttribute Production2DTO searchCondition, Model model) {
        List<Production2DTO> productionList = productionService.selectByCondition(searchCondition);
        model.addAttribute("productionList", productionList);
        model.addAttribute("searchCondition", searchCondition);
        
        // 금일 생산계획도 함께 조회 (Daily)
        List<DailyProduction2DTO> dailyScheduleList = dailyProductionService.selectAllDailyProductionPlans();
        model.addAttribute("dailyScheduleList", dailyScheduleList);
        
        return "production/productionList";
    }

    /**
     * 전체 생산계획 추가 페이지
     */
    @GetMapping("/create")
    public String createProductionForm(Model model) {
        // 완제품 목록 조회
        List<Standard2DTO> productList = productionService.selectFinishedGoods();
        model.addAttribute("productList", productList);
        return "production/productionCreate";
    }

    /**
     * 전체 생산계획 등록 처리
     */
    @PostMapping("/create")
    public String createProduction(@ModelAttribute Production2DTO production, Model model) {
        String result = productionService.createAllProduction(production);
        if ("SUCCESS".equals(result)) {
            return "redirect:/mes/production/list";
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

    /**
     * 생산 LOT 삭제 처리
     */
    @PostMapping("/delete")
    public String deleteProduction(@RequestParam String lotNumber) {
        productionService.deleteProduction(lotNumber);
        return "redirect:/production/list";
    }

    // ==================== 금일 생산계획 관련 메서드 ====================

    /**
     * 금일 생산계획 검색 (Daily)
     */
    @GetMapping("/daily/search")
    public String searchDailyProduction(@ModelAttribute DailyProduction2DTO searchCondition, Model model) {
        List<DailyProduction2DTO> dailyScheduleList = dailyProductionService.selectDailyProductionByCondition(searchCondition);
        model.addAttribute("dailyScheduleList", dailyScheduleList);
        model.addAttribute("searchCondition", searchCondition);
        
        // 전체 생산계획도 함께 조회
        List<Production2DTO> allProductionList = productionService.selectAllProductionPlans();
        model.addAttribute("productionList", allProductionList);
        
        return "production/productionList";
    }

    /**
     * 전체 생산계획에서 금일 생산계획 생성 (AJAX) - Daily
     */
    @PostMapping("/daily/createFromAll")
    @ResponseBody
    public java.util.Map<String, Object> createDailyScheduleFromAll(
            @RequestParam String lotNumber, 
            @RequestParam int plannedQty) {
        
        java.util.Map<String, Object> result = new java.util.HashMap<String, Object>();
        
        // 전체 생산계획에서 데이터 조회
        Production2DTO sourceProduction = productionService.selectProductionForDailySchedule(lotNumber);
        if (sourceProduction == null) {
            result.put("success", false);
            result.put("message", "해당 전체 생산계획을 찾을 수 없습니다.");
            return result;
        }
        
        // 금일 생산계획 생성 (Daily)
        DailyProduction2DTO dailyProduction = new DailyProduction2DTO();
        dailyProduction.setParentLotNumber(lotNumber);
        dailyProduction.setProductCode(sourceProduction.getProductCode());
        dailyProduction.setPlannedQty(plannedQty);
        dailyProduction.setStatus("Production");
        dailyProduction.setPlannedStartDate(new java.sql.Date(System.currentTimeMillis()));
        dailyProduction.setPlannedEndDate(new java.sql.Date(System.currentTimeMillis()));
        dailyProduction.setCreatedBy("SYSTEM");
        
        String createResult = dailyProductionService.createDailyProduction(dailyProduction);
        
        if ("SUCCESS".equals(createResult)) {
            // 방금 생성된 금일 생산계획 조회 (parent LOT 기준으로 최신)
            List<DailyProduction2DTO> dailyListByParent = dailyProductionService.selectDailyProductionByParentLot(lotNumber);
            if (dailyListByParent != null && !dailyListByParent.isEmpty()) {
                DailyProduction2DTO latest = dailyListByParent.get(dailyListByParent.size() - 1);
                String dailyLotNumber = latest.getLotNumber();
                // 금일 생산계획에서 작업지시서 자동 생성
                String workOrderResult = workOrdersService.createWorkOrderFromProduction(dailyLotNumber);
                
                if ("SUCCESS".equals(workOrderResult)) {
                    result.put("success", true);
                    result.put("message", "금일 생산계획과 작업지시서가 성공적으로 생성되었습니다.");
                } else {
                    result.put("success", true);
                    result.put("message", "금일 생산계획은 생성되었지만 작업지시서 생성에 실패했습니다.");
                }
            } else {
                result.put("success", true);
                result.put("message", "금일 생산계획은 생성되었지만 LOT번호를 찾을 수 없습니다.");
            }
        } else {
            result.put("success", false);
            result.put("message", createResult);
        }
        
        return result;
    }

    /**
     * 금일 생산계획 상태 업데이트 (Daily)
     */
    @PostMapping("/daily/updateStatus")
    @ResponseBody
    public java.util.Map<String, Object> updateDailyProductionStatus(
            @RequestParam String dailyPlanId, 
            @RequestParam String status) {
        
        java.util.Map<String, Object> result = new java.util.HashMap<String, Object>();
        
        DailyProduction2DTO production = new DailyProduction2DTO();
        production.setDailyPlanId(dailyPlanId);
        production.setStatus(status);
        production.setUpdatedBy("SYSTEM");
        
        int updateResult = dailyProductionService.updateDailyProductionStatus(production);
        
        if (updateResult > 0) {
            result.put("success", true);
            result.put("message", "금일 생산계획 상태가 성공적으로 업데이트되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "금일 생산계획 상태 업데이트에 실패했습니다.");
        }
        
        return result;
    }

    /**
     * 금일 생산계획 삭제 (Daily)
     */
    @PostMapping("/daily/delete")
    public String deleteDailyProduction(@RequestParam String dailyPlanId) {
        dailyProductionService.deleteDailyProductionById(dailyPlanId);
        return "redirect:/production/list";
    }

}
