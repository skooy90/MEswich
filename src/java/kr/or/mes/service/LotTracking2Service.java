package kr.or.mes.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.mes.dao.LotTracking2DAO;
import kr.or.mes.dto.LotTracking2DTO;

@Service
public class LotTracking2Service {

    @Autowired
    private LotTracking2DAO dao;

    // 1. 추적 이력 등록
    public int recordTracking(LotTracking2DTO dto) {
        return dao.insertTracking(dto);
    }

    // 2. LOT별 전체 이력 조회
    public List<LotTracking2DTO> getTrackingByLot(String lotNumber) {
        return dao.selectTrackingByLot(lotNumber);
    }

    // 3. LOT 최신 상태 조회
    public String getLatestStatus(String lotNumber) {
        return dao.selectLatestStatus(lotNumber);
    }
}
