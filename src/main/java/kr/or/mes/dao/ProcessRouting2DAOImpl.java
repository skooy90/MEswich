package kr.or.mes.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.ProcessRouting2DTO;

@Repository
public class ProcessRouting2DAOImpl implements ProcessRouting2DAO {

    private static final String NS = "kr.or.mes.dao.ProcessRouting2DAO.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ProcessRouting2DTO> selectAllRoutings() {
        return sqlSession.selectList(NS + "selectAllRoutings");
    }

    @Override
    public List<ProcessRouting2DTO> selectRoutingDetail(String productCode) {
        return sqlSession.selectList(NS + "selectRoutingDetail", productCode);
    }

    @Override
    public int insertRouting(ProcessRouting2DTO dto) {
        return sqlSession.insert(NS + "insertRouting", dto);
    }

    @Override
    public int updateRouting(ProcessRouting2DTO dto) {
        return sqlSession.update(NS + "updateRouting", dto);
    }

    @Override
    public int deleteRouting(String productCode) {
        return sqlSession.delete(NS + "deleteRouting", productCode);
    }

    @Override
    public int getLastRoutingId() {
        return sqlSession.selectOne(NS + "getLastRoutingId");
    }

    @Override
    public int insertRoutingMaterial(int routingId, String materialCode) {
        Map<String, Object> map = new HashMap<>();
        map.put("routingId", routingId);
        map.put("materialCode", materialCode);
        return sqlSession.insert(NS + "insertRoutingMaterial", map);
    }
    
    @Override
    public int getNextOperationSeq() {
        return sqlSession.selectOne(NS + "getNextOperationSeq");
    }
}
