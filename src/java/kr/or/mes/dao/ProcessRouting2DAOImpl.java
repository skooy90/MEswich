package kr.or.mes.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.ProcessRouting2DTO;

@Repository
public class ProcessRouting2DAOImpl implements ProcessRouting2DAO {

    private final String namespace = "kr.or.mes.dao.ProcessRouting2DAO";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ProcessRouting2DTO> selectAll() {
        return sqlSession.selectList(namespace + ".selectAll");
    }

    @Override
    public ProcessRouting2DTO selectById(int routingId) {
        return sqlSession.selectOne(namespace + ".selectById", routingId);
    }

    @Override
    public int insert(ProcessRouting2DTO dto) {
        return sqlSession.insert(namespace + ".insert", dto);
    }

    @Override
    public int update(ProcessRouting2DTO dto) {
        return sqlSession.update(namespace + ".update", dto);
    }

    @Override
    public int delete(int routingId) {
        return sqlSession.delete(namespace + ".delete", routingId);
    }
    
    @Override
    public List<ProcessRouting2DTO> selectDistinctProducts() {
        return sqlSession.selectList(namespace + ".selectDistinctProducts");
    }

    @Override
    public List<ProcessRouting2DTO> selectByProductCode(String productCode) {
        return sqlSession.selectList(namespace + ".selectByProductCode", productCode);
    }

}
