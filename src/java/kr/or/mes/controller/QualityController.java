package kr.or.mes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.mes.dto.Quality2DTO;
import kr.or.mes.service.Quality.QualityService;

/**
 * 품질관리 컨트롤러
 * 품질검사 관리 기능을 담당
 */
@Controller
@RequestMapping("quality")
public class QualityController {

    @Autowired
    private QualityService qualityService;

    /**
     * 품질관리 메인 페이지
     * @param model Model 객체
     * @param status 상태 필터
     * @return 품질관리 페이지
     */
    @GetMapping({"", "/"})
    public String qualityManagement(Model model, @RequestParam(required = false) String status) {
        // 전체 품질검사 조회 (JSP에서 상태별로 필터링)
        Quality2DTO dto = new Quality2DTO();
        if (status != null && !status.trim().isEmpty()) {
            dto.setStatus(status);
        }
        
        List<Quality2DTO> allQualityList = qualityService.selectAllQuality(dto);
        model.addAttribute("list", allQualityList);
        model.addAttribute("selectedStatus", status);
        
        return "quality/qualitylist";
    }

    /**
     * 검사 시작 (검사자 배정)
     * @param inspectionNo 검사번호
     * @param inspectorName 검사자명
     * @return 품질관리 페이지로 리다이렉트
     */
    @PostMapping("/startInspection")
    public String startInspection(Quality2DTO dto) {
        qualityService.startInspection(dto.getInspectionNo(), dto.getInspectorName(), dto.getInspectorName());
        return "redirect:/quality";
    }

    /**
     * 검사 완료 페이지
     * @param inspectionNo 검사번호
     * @param model Model 객체
     * @return 검사 완료 페이지
     */
    @GetMapping("/completeInspection")
    public String completeInspectionPage(@RequestParam String inspectionNo, Model model) {
        List<Quality2DTO> allList = qualityService.selectAllQuality(new Quality2DTO());
        Quality2DTO quality = null;
        
        for (Quality2DTO q : allList) {
            if (inspectionNo.equals(q.getInspectionNo())) {
                quality = q;
                break;
            }
        }
        
        model.addAttribute("quality", quality);
        return "quality/completeInspection";
    }
    
    /**
     * 검사 완료 처리
     * @param inspectionNo 검사번호
     * @param goodQty 양품수량
     * @param defectQty 불량수량
     * @param defectReason 불량사유
     * @return 품질관리 페이지로 리다이렉트
     */
    @PostMapping("/completeInspection")
    public String completeInspection(Quality2DTO dto) {
        qualityService.completeInspection(dto.getInspectionNo(), dto.getGoodQty(), dto.getDefectQty(), dto.getDefectReason());
        return "redirect:/quality";
    }

    /**
     * 품질검사 상세보기
     * @param inspectionNo 검사번호
     * @param model Model 객체
     * @return 상세보기 페이지
     */
    @GetMapping("/detail")
    public String qualityDetail(@RequestParam String inspectionNo, Model model) {
        List<Quality2DTO> allList = qualityService.selectAllQuality(new Quality2DTO());
        Quality2DTO quality = null;
        
        for (Quality2DTO q : allList) {
            if (inspectionNo.equals(q.getInspectionNo())) {
                quality = q;
                break;
            }
        }
        
        model.addAttribute("quality", quality);
        return "quality/qualityDetail";
    }

    /**
     * 양품 재고 등록
     * @param inspectionNo 검사번호
     * @return 재고관리 페이지로 리다이렉트
     */
    @PostMapping("/registerGoodInventory")
    public String registerGoodInventory(@RequestParam String inspectionNo) {
        // 재고관리 시스템으로 리다이렉트 (재고 등록 처리)
        return "redirect:/inventory/register?inspectionNo=" + inspectionNo;
    }

    /**
     * 불량 처리
     * @param inspectionNo 검사번호
     * @return 품질관리 페이지로 리다이렉트
     */
    @PostMapping("/processDefect")
    public String processDefect(@RequestParam String inspectionNo) {
        // 불량 처리 로직 (추후 구현)
        return "redirect:/quality";
    }
}
