package kr.or.mes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.mes.dao.Quality.QualityDAO;
import kr.or.mes.dto.Inventory2DTO;
import kr.or.mes.dto.Quality2DTO;
import kr.or.mes.service.Inventory2.Inventory2Service;

/**
 * 재고관리 Controller
 * 재고관리 기능을 담당
 */
@Controller
@RequestMapping("/inventory")
public class Inventory2Controller {

    @Autowired
    private Inventory2Service inventory2Service;
    
    @Autowired
    private QualityDAO qualityDAO;

    /**
     * 재고관리 메인 페이지 (탭 기반)
     * @param model Model 객체
     * @param search 검색 키워드
     * @param filter 필터 조건
     * @return 재고관리 페이지
     */
    @GetMapping({"", "/"})
    public String inventoryManagement(Model model, 
                                     @RequestParam(value = "search", required = false) String search,
                                     @RequestParam(value = "filter", required = false) String filter) {
        // 전체재고현황 조회
        Inventory2DTO inventoryDto = new Inventory2DTO();
        if (search != null && !search.trim().isEmpty()) {
            inventoryDto.setProductName(search);
        }
        if (filter != null && !filter.trim().isEmpty()) {
            inventoryDto.setItemCode(filter);
        }
        
        List<Inventory2DTO> inventoryList = inventory2Service.selectAllInventory(inventoryDto);
        model.addAttribute("inventoryList", inventoryList);
        
        // 등록 전 항목 조회 (location이 null 또는 'PENDING')
        Quality2DTO pendingDto = new Quality2DTO();
        pendingDto.setStatus("PASS");
        pendingDto.setLocation(null);  // 등록 전 상태
        List<Quality2DTO> pendingList = qualityDAO.selectQualityByLocation(pendingDto);
        model.addAttribute("pendingList", pendingList);
        
        // 등록 후 항목 조회 (location이 'REGISTERED')
        Quality2DTO registeredDto = new Quality2DTO();
        registeredDto.setStatus("PASS");
        registeredDto.setLocation("REGISTERED");  // 등록 후 상태
        List<Quality2DTO> registeredList = qualityDAO.selectQualityByLocation(registeredDto);
        model.addAttribute("registeredList", registeredList);
        
        model.addAttribute("search", search);
        model.addAttribute("filter", filter);
        
        return "inventory/inventoryList";
    }

    /**
     * 재고 상세보기
     * @param inventoryId 재고 ID
     * @param model Model 객체
     * @return 상세보기 페이지
     */
    @GetMapping("/detail")
    public String inventoryDetail(@RequestParam(value = "inventoryId") int inventoryId, Model model) {
        Inventory2DTO inventory = inventory2Service.selectInventoryById(inventoryId);
        model.addAttribute("inventory", inventory);
        return "inventory/inventoryDetail";
    }

    /**
     * 개별 재고 등록 (품질검사 → 재고)
     * @param inspectionNo 검사번호
     * @return 재고관리 페이지로 리다이렉트
     */
    @PostMapping("/register")
    public String registerInventory(@RequestParam(value = "inspectionNo") String inspectionNo) {
        inventory2Service.registerFromQuality(inspectionNo);
        return "redirect:/inventory";
    }

    /**
     * 일괄 재고 등록
     * @param inspectionNos 검사번호 목록
     * @return 재고관리 페이지로 리다이렉트
     */
    @PostMapping("/batchRegister")
    public String batchRegisterInventory(@RequestParam(value = "inspectionNos") List<String> inspectionNos) {
        inventory2Service.batchRegisterFromQuality(inspectionNos);
        return "redirect:/inventory";
    }

    /**
     * 검색 기능
     * @param searchCategory 검색 카테고리
     * @param searchKeyword 검색 키워드
     * @param model Model 객체
     * @return 검색 결과 페이지
     */
    @GetMapping("/search")
    public String searchInventory(@RequestParam(value = "searchCategory") String searchCategory,
                                 @RequestParam(value = "searchKeyword") String searchKeyword,
                                 Model model) {
        Inventory2DTO searchDto = new Inventory2DTO();
        
        if ("productName".equals(searchCategory)) {
            searchDto.setProductName(searchKeyword);
        } else if ("itemCode".equals(searchCategory)) {
            searchDto.setItemCode(searchKeyword);
        } else if ("lotNumber".equals(searchCategory)) {
            searchDto.setLotNumber(searchKeyword);
        }
        
        List<Inventory2DTO> searchResults = inventory2Service.selectInventoryByCondition(searchDto);
        model.addAttribute("inventoryList", searchResults);
        model.addAttribute("searchCategory", searchCategory);
        model.addAttribute("searchKeyword", searchKeyword);
        
        return "inventory/inventoryList";
    }
    @PostMapping("/delete")
    public String deleteInventory(@RequestParam(value = "inventoryId") int inventoryId, Model moedel) {
    	 inventory2Service.deleteInventory(inventoryId);
    	return "redirect:/inventory";
    }
}