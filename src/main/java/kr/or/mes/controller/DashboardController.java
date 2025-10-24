package kr.or.mes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Dashboard.ProductionStatsDTO;
import kr.or.mes.dto.Dashboard.DefectStatsDTO;
import kr.or.mes.dto.Dashboard.DefectCauseStatsDTO;
import kr.or.mes.dto.Dashboard.WorkStatusStatsDTO;
import kr.or.mes.service.Dashboard.DashboardService;

/**
 * 대시보드 Controller
 * 6개 위젯을 포함한 대시보드 (1번 위젯: 전체 생산량 - 항목 선택 기능)
 */
@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    /**
     * 대시보드 메인 페이지 - 6개 위젯 구조
     * @param model Model 객체
     * @param selectedLot 선택된 LOT 번호 (선택사항)
     * @return 대시보드 페이지
     */
    @GetMapping({"", "/"})
    public String dashboard(Model model, 
                           @RequestParam(value = "selectedLot", required = false) String selectedLot) {
        
        // 서비스에서 대시보드 데이터 조회
        kr.or.mes.dto.Dashboard.DashboardDataDTO dashboardData = dashboardService.getDashboardData(selectedLot);
        
        // 모델에 데이터 추가
        model.addAttribute("allProductions", dashboardData.getAllProductions());
        model.addAttribute("productionStats", dashboardData.getProductionStats());
        model.addAttribute("selectedProduction", dashboardData.getSelectedProduction());
        model.addAttribute("selectedLot", selectedLot);
        
        // 2번 위젯: 불량 통계 데이터
        DefectStatsDTO defectStats = dashboardService.getDefectStats();
        model.addAttribute("defectStats", defectStats);
        
        // 3번 위젯: 불량 원인별 통계 데이터
        DefectCauseStatsDTO defectCauseStats = dashboardService.getDefectCauseStats();
        model.addAttribute("defectCauseStats", defectCauseStats);
        
        // 4번 위젯: 작업현황 통계 데이터
        WorkStatusStatsDTO workStatusStats = dashboardService.getWorkStatusStats();
        model.addAttribute("workStatusStats", workStatusStats);
        
        // 5-6번 위젯은 아직 구현되지 않음
        model.addAttribute("qualityStatus", null);
        model.addAttribute("lotTracking", null);
        
        return "dashboard/main";
    }

    /**
     * 1번 위젯: 전체 생산량 통계 데이터 API (AJAX용)
     * @return JSON 형태의 통계 데이터
     */
    @GetMapping("/api/production-stats")
    @ResponseBody
    public ProductionStatsDTO getProductionStats() {
        return dashboardService.getTotalProductionStats();
    }
    
    /**
     * 선택된 생산 항목의 상세 정보 API (AJAX용)
     * @param lotNumber LOT 번호
     * @return 선택된 생산 항목 정보
     */
    @GetMapping("/api/production-detail")
    @ResponseBody
    public Production2DTO getProductionDetail(@RequestParam String lotNumber) {
        return dashboardService.getProductionByLot(lotNumber);
    }
    
    /**
     * 2번 위젯: 불량 통계 데이터 API (AJAX용)
     * @return JSON 형태의 불량 통계 데이터
     */
    @GetMapping("/api/defect-stats")
    @ResponseBody
    public DefectStatsDTO getDefectStats() {
        return dashboardService.getDefectStats();
    }
    
    /**
     * 3번 위젯: 불량 원인별 통계 데이터 API (AJAX용)
     * @return JSON 형태의 불량 원인별 통계 데이터
     */
    @GetMapping("/api/defect-cause-stats")
    @ResponseBody
    public DefectCauseStatsDTO getDefectCauseStats() {
        return dashboardService.getDefectCauseStats();
    }
    
    /**
     * 4번 위젯: 작업현황 통계 데이터 API (AJAX용)
     * @return JSON 형태의 작업현황 통계 데이터
     */
    @GetMapping("/api/work-status-stats")
    @ResponseBody
    public WorkStatusStatsDTO getWorkStatusStats() {
        return dashboardService.getWorkStatusStats();
    }
}