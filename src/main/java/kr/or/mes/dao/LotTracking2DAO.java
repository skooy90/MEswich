package kr.or.mes.dao;

import java.util.List;
import kr.or.mes.dto.LotTracking2DTO;

public interface LotTracking2DAO {
    int insertTracking(LotTracking2DTO dto);
    List<LotTracking2DTO> selectTrackingByLot(String lotNumber);
    String selectLatestStatus(String lotNumber);
}
