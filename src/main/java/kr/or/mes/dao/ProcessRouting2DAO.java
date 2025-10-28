package kr.or.mes.dao;

import java.util.List;

import kr.or.mes.dto.ProcessRouting2DTO;

public interface ProcessRouting2DAO {
    List<ProcessRouting2DTO> selectAll();
    ProcessRouting2DTO selectById(int routingId);
    int insert(ProcessRouting2DTO dto);
    int update(ProcessRouting2DTO dto);
    int delete(int routingId);
    List<ProcessRouting2DTO> selectDistinctProducts();
    List<ProcessRouting2DTO> selectByProductCode(String productCode);
}
