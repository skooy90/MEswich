package kr.or.mes.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.ProcessRouting2DAO;
import kr.or.mes.dto.ProcessRouting2DTO;

@Service
public class ProcessRouting2Service {

    @Autowired
    private ProcessRouting2DAO dao;

    public List<ProcessRouting2DTO> getAllRoutings() {
        return dao.selectAll();
    }

    public ProcessRouting2DTO getRoutingById(int routingId) {
        return dao.selectById(routingId);
    }

    public int insertRouting(ProcessRouting2DTO dto) {
        return dao.insert(dto);
    }

    public int updateRouting(ProcessRouting2DTO dto) {
        return dao.update(dto);
    }

    public int deleteRouting(int routingId) {
        return dao.delete(routingId);
    }
    
    public List<ProcessRouting2DTO> getDistinctProductList() {
        return dao.selectDistinctProducts();
    }

    public List<ProcessRouting2DTO> getRoutingsByProductCode(String productCode) {
        return dao.selectByProductCode(productCode);
    }

}
