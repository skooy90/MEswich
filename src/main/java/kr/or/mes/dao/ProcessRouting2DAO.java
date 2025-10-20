package kr.or.mes.dao;

import java.util.List;
import kr.or.mes.dto.ProcessRouting2DTO;

public interface ProcessRouting2DAO {

    List<ProcessRouting2DTO> selectAllRoutings();
    List<ProcessRouting2DTO> selectRoutingDetail(String productCode);

    int insertRouting(ProcessRouting2DTO dto);
    int updateRouting(ProcessRouting2DTO dto);
    int deleteRouting(String productCode);

    int getLastRoutingId();
    int insertRoutingMaterial(int routingId, String materialCode);
    int getNextOperationSeq();
}
