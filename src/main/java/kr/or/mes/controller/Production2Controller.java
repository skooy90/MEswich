package kr.or.mes.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.mes.dao.Production2DAO;
import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

/**
 * 생산관리 Controller 클래스
 * 생산 LOT 관리 기능을 담당
 */
@Controller
@RequestMapping("/production")
public class Production2Controller {

    @Autowired
    private Production2DAO productionDAO;

    /**
     * 생산관리 메인 페이지
     * @param model Model 객체
     * @return 생산관리 JSP 페이지
     */
    @GetMapping("/list")
    public String productionList(Model model) {
        try {
            List<Production2DTO> productionList = productionDAO.selectAll();
            model.addAttribute("productionList", productionList);
            return "production/productionList";
        } catch (Exception e) {
            model.addAttribute("error", "생산 LOT 목록을 불러오는 중 오류가 발생했습니다.");
            return "production/productionList";
        }
    }

    /**
     * 생산 LOT 검색
     * @param lotNumber LOT번호
     * @param productCode 제품코드
     * @param status 상태
     * @param model Model 객체
     * @return 검색 결과 페이지
     */
    @GetMapping("/search")
    public String searchProduction(
            @RequestParam(required = false) String lotNumber,
            @RequestParam(required = false) String productCode,
            @RequestParam(required = false) String status,
            Model model) {
        try {
            Map<String, Object> searchParams = new HashMap<String, Object>();
            if (lotNumber != null && !lotNumber.trim().isEmpty()) {
                searchParams.put("lotNumber", lotNumber.trim());
            }
            if (productCode != null && !productCode.trim().isEmpty()) {
                searchParams.put("productCode", productCode.trim());
            }
            if (status != null && !status.trim().isEmpty()) {
                searchParams.put("status", status.trim());
            }

            List<Production2DTO> productionList = productionDAO.selectByCondition(searchParams);
            model.addAttribute("productionList", productionList);
            model.addAttribute("searchParams", searchParams);
            return "production/productionList";
        } catch (Exception e) {
            model.addAttribute("error", "검색 중 오류가 발생했습니다.");
            return "production/productionList";
        }
    }

    /**
     * 생산계획 추가 페이지
     * @param model Model 객체
     * @return 생산계획 추가 JSP 페이지
     */
    @GetMapping("/create")
    public String createProductionForm(Model model) {
        try {
            // 완제품 목록 조회
            List<Standard2DTO> productList = productionDAO.selectFinishedGoods();
            model.addAttribute("productList", productList);
            return "production/productionCreate";
        } catch (Exception e) {
            model.addAttribute("error", "페이지를 불러오는 중 오류가 발생했습니다.");
            return "production/productionCreate";
        }
    }

    /**
     * 생산계획 등록 처리
     * @param productCode 제품코드
     * @param plannedQty 계획수량
     * @param plannedStartDate 계획시작일
     * @param plannedEndDate 계획종료일
     * @param status 상태 (기본값: PLANNED)
     * @param model Model 객체
     * @return 리다이렉트 또는 결과 페이지
     */
    @PostMapping("/create")
    public String createProduction(
            @RequestParam String productCode,
            @RequestParam int plannedQty,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") java.util.Date plannedStartDate,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") java.util.Date plannedEndDate,
            @RequestParam(defaultValue = "PLANNED") String status,
            Model model) {
        try {
            // Production2DTO 객체 생성 (setter 방식)
            Production2DTO production = new Production2DTO();
            production.setProductCode(productCode);
            production.setPlannedQty(plannedQty);
            production.setPlannedStartDate(plannedStartDate);
            production.setPlannedEndDate(plannedEndDate);
            production.setStatus(status);
            
            int result = productionDAO.insert(production);
            if (result > 0) {
                return "redirect:/production/list";
            } else {
                model.addAttribute("error", "생산 LOT 등록에 실패했습니다.");
                // 등록 실패 시 완제품 목록 다시 조회
                List<Standard2DTO> productList = productionDAO.selectFinishedGoods();
                model.addAttribute("productList", productList);
                return "production/productionCreate";
            }
        } catch (Exception e) {
            e.printStackTrace(); // 디버깅용 로그
            model.addAttribute("error", "생산 LOT 등록 중 오류가 발생했습니다: " + e.getMessage());
            // 오류 발생 시 완제품 목록 다시 조회
            try {
                List<Standard2DTO> productList = productionDAO.selectFinishedGoods();
                model.addAttribute("productList", productList);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return "production/productionCreate";
        }
    }

}
