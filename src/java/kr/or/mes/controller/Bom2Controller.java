package kr.or.mes.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import kr.or.mes.dto.Bom2DTO;
import kr.or.mes.dto.Standard2DTO;
import kr.or.mes.service.Bom2Service;
import kr.or.mes.service.Standard2Service;

@Controller
@RequestMapping("/bom2")
public class Bom2Controller {

    @Autowired
    private Bom2Service service;

    @Autowired
    private Standard2Service standard2Service;

    // 목록
    @GetMapping("/list")
    public String list(Model model) {
        List<Bom2DTO> list = service.getAllProductBoms();
        model.addAttribute("bomList", list);
        return "bom2/Bom2_list";
    }

    // 상세페이지
    @GetMapping("/detail/{productCode}")
    public String detail(@PathVariable("productCode") String productCode, Model model) {
        List<Bom2DTO> materials = service.selectMaterialListByProductCode(productCode);
        model.addAttribute("productCode", productCode);
        model.addAttribute("bomList", materials);
        return "bom2/Bom2_detail";
    }

    // 등록 폼
    @GetMapping("/insertForm")
    public String insertForm(Model model) {
        List<Standard2DTO> productList = standard2Service.getProductsByType("FG");
        List<Standard2DTO> materialList = standard2Service.getProductsByType("RM");
        List<String> registeredProducts = service.getRegisteredProductCodes(); // 새로 추가할 메서드
        
        model.addAttribute("productList", productList);
        model.addAttribute("materialList", materialList);
        model.addAttribute("registeredProducts", registeredProducts);

        return "bom2/Bom2_insert";
    }

    // 등록 처리
    @PostMapping("/insert")
    public String insert(
            @RequestParam("productCode") String productCode,
            @RequestParam List<String> materialCode,
            @RequestParam List<String> unit,
            @RequestParam List<Double> quantity,
            @RequestParam String createdBy) {

        for (int i = 0; i < materialCode.size(); i++) {
            Bom2DTO dto = new Bom2DTO();
            dto.setProductCode(productCode);
            dto.setMaterialCode(materialCode.get(i));
            dto.setUnit(unit.get(i));
            dto.setQuantity(quantity.get(i));
            dto.setCreatedBy(createdBy);
            service.addBom(dto);
        }
        return "redirect:/bom2/list";
    }

 // 수정 폼 (bomId 기준)
    @GetMapping("/updateForm/{bomId}")
    public String updateForm(@PathVariable String bomId, Model model) {
        // 1️⃣ 단건 조회 (해당 BOM 레코드)
        Bom2DTO bom = service.getBomById(bomId);

        if (bom == null) {
            model.addAttribute("error", "해당 BOM 정보를 찾을 수 없습니다.");
            return "error";
        }

        // 2️⃣ 동일한 productCode에 속한 모든 자재 리스트 조회
        List<Bom2DTO> materialListByProduct = service.selectMaterialListByProductCode(bom.getProductCode());
        bom.setMaterialList(materialListByProduct);

        // 3️⃣ 신규 추가용 원자재 목록 (insert용 select)
        List<Standard2DTO> materialList = standard2Service.getProductsByType("RM");

        // 4️⃣ 모델에 데이터 전달
        model.addAttribute("bom", bom);
        model.addAttribute("materialList", materialList);

        // 5️⃣ 수정 JSP로 이동
        return "bom2/Bom2_update";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(Bom2DTO dto) {
        dto.setUpdatedBy("admin");
        service.updateBom(dto);
        return "redirect:/bom2/list";
    }

    // 삭제
    @GetMapping("/deleteAll/{productCode}")
    public String deleteAll(@PathVariable("productCode") String productCode) {
        service.deleteBom(productCode);
        return "redirect:/bom2/list";
    }

    // Ajax: 단일 행 수정
    @PostMapping("/updateInline")
    @ResponseBody
    public String updateInline(@RequestBody Bom2DTO dto) {
        dto.setUpdatedBy("admin");
        return service.updateBomMaterial(dto) > 0 ? "success" : "fail";
    }

    // Ajax: 단일 행 삭제
    @PostMapping("/deleteInline")
    @ResponseBody
    public String deleteInline(@RequestBody Bom2DTO dto) {
        return service.deleteBomMaterial(dto) > 0 ? "success" : "fail";
    }
 // Ajax: 자재 추가
    @PostMapping("/insertInline")
    @ResponseBody
    public String insertInline(@RequestBody Bom2DTO dto) {
        int check = service.addBom(dto);
        if (check == 0) return "duplicate";
        return "success";
    }

}

