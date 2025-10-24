package kr.or.mes.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.mes.dto.Bom2DTO;

@Repository
public class Bom2DAOImpl implements Bom2DAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NS = "kr.or.mes.dao.Bom2DAO.";

    @Override
    public List<Bom2DTO> selectAllProducts() {
        return sqlSession.selectList(NS + "selectAllProducts");
    }

    @Override
    public Bom2DTO selectById(String bomId) {
        return sqlSession.selectOne(NS + "selectById", bomId);
    }

    @Override
    public int insert(Bom2DTO dto) {
        return sqlSession.insert(NS + "insert", dto);
    }

    @Override
    public int update(Bom2DTO dto) {
        return sqlSession.update(NS + "update", dto);
    }

    @Override
    public int delete(String productCode) {
        return sqlSession.delete(NS + "delete", productCode);
    }

    @Override
    public List<Bom2DTO> selectMaterialListByProductCode(String productCode) {
        return sqlSession.selectList(NS + "selectMaterialListByProductCode", productCode);
    }

    @Override
    public int updateBomMaterial(Bom2DTO dto) {
        return sqlSession.update(NS + "updateBomMaterial", dto);
    }

    @Override
    public int deleteBomMaterial(Bom2DTO dto) {
        return sqlSession.delete(NS + "deleteBomMaterial", dto);
    }
    @Override
    public int checkDuplicate(Bom2DTO dto) {
        return sqlSession.selectOne(NS + "checkDuplicate", dto);
    }

	@Override
	public List<String> getRegisteredProductCodes() {
        return sqlSession.selectList(NS + "getRegisteredProductCodes");
    }
}


