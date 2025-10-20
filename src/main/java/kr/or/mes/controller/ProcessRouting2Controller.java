package kr.or.mes.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.mes.dto.ProcessRouting2DTO;
import kr.or.mes.dto.Standard2DTO;
import kr.or.mes.service.ProcessRouting2Service;
import kr.or.mes.service.Standard2Service;

@Controller
@RequestMapping("/processRouting2")
public class ProcessRouting2Controller {

    @Autowired
    private ProcessRouting2Service service;
    @Autowired
    private Standard2Service standardService;

    // 📋 목록
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("routingList", service.getAllRoutings());
        return "processRouting2/ProcessRouting2_list";
    }

    // 📄 상세
    @GetMapping("/detail/{productCode}")
    public String detail(@PathVariable String productCode, Model model) {
        model.addAttribute("detailList", service.getRoutingDetail(productCode));
        return "processRouting2/ProcessRouting2_detail";
    }

    // 🆕 등록 폼
    @GetMapping("/insertForm")
    public String insertForm(Model model) {
        List<Standard2DTO> products = standardService.getProductsByType("FG"); // 완제품
        List<Standard2DTO> materials = standardService.getProductsByType("RM"); // 원자재
        model.addAttribute("productList", products);
        model.addAttribute("materialList", materials);
        return "processRouting2/ProcessRouting2_insertForm";
    }

    // 공정코드 자동 발급용
    @GetMapping("/nextOperationCode")
    @ResponseBody
    public String getNextOperationCode() {
        int nextVal = service.getNextOperationSeq();
        return String.format("P%03d", nextVal);
    }

    // 🆕 등록 처리
    @PostMapping("/insert")
    public String insertMultiple(HttpServletRequest request,
                                 @RequestParam("productCode") String productCode,
                                 @RequestParam("operationSeq") List<Integer> seqList,
                                 @RequestParam("operationCode") List<String> codeList,
                                 @RequestParam("operationName") List<String> nameList,
                                 @RequestParam("operationDesc") List<String> descList,  // ✅ 공정 설명 추가
                                 @RequestParam("standardTime") List<Integer> timeList) {

        for (int i = 0; i < seqList.size(); i++) {
            ProcessRouting2DTO dto = ProcessRouting2DTO.builder()
                    .productCode(productCode)
                    .operationSeq(seqList.get(i))
                    .operationCode(codeList.get(i))
                    .operationName(nameList.get(i))
                    .operationDesc(descList.get(i))   // ✅ builder 적용
                    .standardTime(timeList.get(i))
                    .createdBy("admin")
                    .build();

            service.insertRouting(dto);

            int routingId = service.getLastRoutingId();
            String[] materials = request.getParameterValues("materialCode_" + (i + 1));

            if (materials != null) {
                for (String mCode : materials) {
                    service.insertRoutingMaterial(routingId, mCode);
                }
            }
        }

        return "redirect:/processRouting2/list";
    }

    // ✏️ 수정
    @GetMapping("/updateForm/{productCode}")
    public String updateForm(@PathVariable String productCode, Model model) {
        model.addAttribute("detailList", service.getRoutingDetail(productCode));
        return "processRouting2/ProcessRouting2_updateForm";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute ProcessRouting2DTO dto) {
        service.updateRouting(dto);
        return "redirect:/processRouting2/detail/" + dto.getProductCode();
    }

    // ❌ 삭제
    @GetMapping("/delete/{productCode}")
    public String delete(@PathVariable String productCode) {
        service.deleteRouting(productCode);
        return "redirect:/processRouting2/list";
    }
}

