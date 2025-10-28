package kr.or.mes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.Standard2DAO;
import kr.or.mes.dto.Standard2DTO;

@Service
public class Standard2Service {
	
    @Autowired
    private Standard2DAO dao;

    public List<Standard2DTO> getAllStandards() {
        return dao.selectAll();
    }
    
    public List<Standard2DTO> getProductsByType(String type) {
        return dao.selectByType(type); // Mapper: WHERE item_type = #{type}
    }

    public Standard2DTO getStandardById(String itemCode) {
        return dao.selectById(itemCode);
    }
    
    public int addStandard(Standard2DTO dto) {
        return dao.insert(dto);
    }

    public int updateStandard(Standard2DTO dto) {
        return dao.update(dto);
    }

    public int deleteStandard(String itemCode) {
        return dao.delete(itemCode);
    }
}
