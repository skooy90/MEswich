package kr.or.mes.dao;

import java.util.List;
import kr.or.mes.dto.Bom2DTO;

public interface Bom2DAO {
	List<Bom2DTO> selectAllProducts();
    Bom2DTO selectById(String bomId);
    int insert(Bom2DTO dto);
    int update(Bom2DTO dto);
    int delete(String productCode);

    List<Bom2DTO> selectMaterialListByProductCode(String productCode);
    List<String> getRegisteredProductCodes();
    int updateBomMaterial(Bom2DTO dto);
    int deleteBomMaterial(Bom2DTO dto);
    int checkDuplicate(Bom2DTO dto);
}