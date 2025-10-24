package kr.or.mes.dao;

import java.util.List;

import kr.or.mes.dto.Standard2DTO;


public interface Standard2DAO {
    List<Standard2DTO> selectAll();
    List<Standard2DTO> selectByType(String itemType);
    Standard2DTO selectById(String itemCode);
    int insert(Standard2DTO dto);
    int update(Standard2DTO dto);
    int delete(String itemCode);
}
