package kr.or.mes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.mes.dto.WorkOrders2DTO;
import kr.or.mes.service.WorkOrders.WorkOrdersService;

/**
 * 작업지시서 Controller
 * 탭 기반 작업관리 시스템 (작업전/진행중/완료)
 */
@Controller
@RequestMapping("/work")
public class WorkOrdersController {
    
    @Autowired
    private WorkOrdersService workOrdersService;
    
    /**
     * 작업관리 메인 페이지 (탭 기반)
     * 전체 작업지시서 조회하여 JSP에서 상태별 필터링
     * @param model 뷰에 전달할 데이터
     * @return 작업관리 페이지
     */
    @GetMapping("")
    public String workManagement(Model model) {
        // 전체 작업지시서 조회 (JSP에서 상태별로 필터링)
        List<WorkOrders2DTO> allWorkOrdersList = workOrdersService.selectAllWorkOrders();
        model.addAttribute("allWorkOrdersList", allWorkOrdersList);
        
        return "workorders/workOrdersList";
    }
    
    /**
     * 작업지시서 상세보기
     * @param workOrderNo 작업지시번호
     * @param model 뷰에 전달할 데이터
     * @return 상세보기 페이지
     */
    @GetMapping("/detail")
    public String workOrderDetail(@RequestParam String workOrderNo, Model model) {
        WorkOrders2DTO workOrder = workOrdersService.selectWorkOrderByNo(workOrderNo);
        model.addAttribute("workOrder", workOrder);
        return "workorders/workOrdersDetail";
    }
    
    /**
     * 작업 시작 (READY → IN_PROGRESS)
     * @param workOrderNo 작업지시번호
     * @return 작업관리 페이지로 리다이렉트
     */
    @PostMapping("/startWork")
    public String startWork(@RequestParam String workOrderNo) {
        workOrdersService.startWork(workOrderNo);
        return "redirect:/mes/work";
    }
    
    /**
     * 생산량 업데이트
     * @param workOrderNo 작업지시번호
     * @param actualQty 실제 생산량
     * @return 작업관리 페이지로 리다이렉트
     */
    @PostMapping("/updateProduction")
    public String updateProduction(@RequestParam String workOrderNo, @RequestParam int actualQty) {
        workOrdersService.updateProductionQuantity(workOrderNo, actualQty);
        return "redirect:/mes/work";
    }
    
    /**
     * 작업 완료 (IN_PROGRESS → DONE)
     * @param workOrderNo 작업지시번호
     * @return 작업관리 페이지로 리다이렉트
     */
    @PostMapping("/completeWork")
    public String completeWork(@RequestParam String workOrderNo) {
        workOrdersService.completeWork(workOrderNo);
        return "redirect:/mes/work";
    }
    
    /**
     * 검색 기능
     * @param searchCategory 검색 카테고리
     * @param searchKeyword 검색 키워드
     * @param model 뷰에 전달할 데이터
     * @return 검색 결과 페이지
     */
    @GetMapping("/search")
    public String searchWorkOrders(@RequestParam String searchCategory, 
                                   @RequestParam String searchKeyword, 
                                   Model model) {
        // 검색 조건을 DTO에 설정
        WorkOrders2DTO searchDto = new WorkOrders2DTO();
        
        if ("productName".equals(searchCategory)) {
            searchDto.setProductName(searchKeyword);
        } else if ("lotNumber".equals(searchCategory)) {
            searchDto.setLotNumber(searchKeyword);
        } else if ("worker".equals(searchCategory)) {
            searchDto.setWorkerId(searchKeyword);
        } else if ("workOrderId".equals(searchCategory)) {
            searchDto.setWorkOrderNo(searchKeyword);
        }
        
        // 검색 결과 조회
        List<WorkOrders2DTO> searchResults = workOrdersService.selectWorkOrdersByCondition(searchDto);
        model.addAttribute("allWorkOrdersList", searchResults);
        model.addAttribute("searchCategory", searchCategory);
        model.addAttribute("searchKeyword", searchKeyword);
        
        return "workorders/workOrdersList";
    }
}
