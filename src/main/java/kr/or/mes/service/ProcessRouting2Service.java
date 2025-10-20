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
        return dao.selectAllRoutings();
    }

    public List<ProcessRouting2DTO> getRoutingDetail(String productCode) {
        return dao.selectRoutingDetail(productCode);
    }

    public void insertRouting(ProcessRouting2DTO dto) {
        dao.insertRouting(dto);
    }

    public void updateRouting(ProcessRouting2DTO dto) {
        dao.updateRouting(dto);
    }

    public void deleteRouting(String productCode) {
        dao.deleteRouting(productCode);
    }
    public int getLastRoutingId() {
        return dao.getLastRoutingId();
    }
    public void insertRoutingMaterial(int routingId, String materialCode) {
        dao.insertRoutingMaterial(routingId, materialCode);
    }
 // ProcessRouting2Service.java
    public int getNextOperationSeq() {
        return dao.getNextOperationSeq();
    }

}
