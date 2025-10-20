package kr.or.mes.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.mes.dto.LotTracking2DTO;

@Repository
public class LotTracking2DAOImpl implements LotTracking2DAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String namespace = "kr.or.mes.dao.LotTracking2DAO";

    @Override
    public int insertTracking(LotTracking2DTO dto) {
        return sqlSession.insert(namespace + ".insertTracking", dto);
    }

    @Override
    public List<LotTracking2DTO> selectTrackingByLot(String lotNumber) {
        return sqlSession.selectList(namespace + ".selectTrackingByLot", lotNumber);
    }

    @Override
    public String selectLatestStatus(String lotNumber) {
        return sqlSession.selectOne(namespace + ".selectLatestStatus", lotNumber);
    }
}
