package kr.or.mes.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Standard2DTO;

@Repository
public class Standard2DAOImpl implements Standard2DAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.or.mes.dao.Standard2DAO.";

    // 전체 조회
    @Override
    public List<Standard2DTO> selectAll() {
        List<Standard2DTO> resultList = sqlSession.selectList(NAMESPACE + "selectAll");
        System.out.println(resultList);
        return resultList;
    }

    // 단건 조회
    @Override
    public Standard2DTO selectById(String itemCode) {
        Standard2DTO dto = sqlSession.selectOne(NAMESPACE + "selectById", itemCode);
        System.out.println("dto : " + dto);
        return dto;
    }

    // 등록
    @Override
    public int insert(Standard2DTO dto) {
        System.out.println("dao 잘옴 ========================");
        return sqlSession.insert(NAMESPACE + "insert", dto);
    }

    // 수정
    @Override
    public int update(Standard2DTO dto) {
        return sqlSession.update(NAMESPACE + "update", dto);
    }

    // 삭제
    @Override
    public int delete(String itemCode) {
        return sqlSession.delete(NAMESPACE + "delete", itemCode);
    }

    // ✅ 추가: 유형별 조회 (FG, RM 등)
    @Override
    public List<Standard2DTO> selectByType(String itemType) {
        return sqlSession.selectList(NAMESPACE + "selectByType", itemType);
    }
}