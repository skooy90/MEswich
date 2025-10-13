package kr.or.mes.dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Inventory2DTO;

@Repository
public class Inventory2DAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<Inventory2DTO> selectAll() {
        return sqlSession.selectList("mes.mappers.Inventory2Mapper.selectAllInventory");
    }
}