package kr.or.mes.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.mes.dao.Bom2DAO;
import kr.or.mes.dto.Bom2DTO;

@Service
public class Bom2Service {

    @Autowired
    private Bom2DAO dao;

    public List<Bom2DTO> getAllProductBoms() {
        return dao.selectAllProducts();
    }

    public Bom2DTO getBomById(String bomId) {
        Bom2DTO bom = dao.selectById(bomId);
        List<Bom2DTO> materials = dao.selectMaterialListByProductCode(bom.getProductCode());
        bom.setMaterialList(materials);
        return bom;
    }

    public int addBom(Bom2DTO dto) {
        // 이미 존재하는 조합인지 검사
        if (dao.checkDuplicate(dto) > 0) {
            return 0; // 중복이면 insert 안함
        }
        return dao.insert(dto);
    }

    public int updateBom(Bom2DTO dto) {
        return dao.update(dto);
    }

    public int deleteBom(String productCode) {
        return dao.delete(productCode);
    }

    public int updateBomMaterial(Bom2DTO dto) {
        return dao.updateBomMaterial(dto);
    }

    public int deleteBomMaterial(Bom2DTO dto) {
        return dao.deleteBomMaterial(dto);
    }

    public List<Bom2DTO> selectMaterialListByProductCode(String productCode) {
        return dao.selectMaterialListByProductCode(productCode);
    }
    public List<String> getRegisteredProductCodes() {
        return dao.getRegisteredProductCodes();
    }
}
