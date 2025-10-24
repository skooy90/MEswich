package kr.or.mes.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Users2DTO;

@Repository
public class Users2DAOImpl implements Users2DAO {

    private final String NS = "kr.or.mes.dao.Users2DAO.";

    @Autowired
    private SqlSession sqlSession;

    /** 로그인용 조회 */
    @Override
    public Users2DTO findById(String userId) {
        return sqlSession.selectOne(NS + "findById", userId);
    }

    /** 전체 조회 */
    @Override
    public List<Users2DTO> selectAll() {
        return sqlSession.selectList(NS + "selectAll");
    }

    /** 단일 조회 */
    @Override
    public Users2DTO selectById(String userId) {
        return sqlSession.selectOne(NS + "selectById", userId);
    }

    /** 신규 등록 */
    @Override
    public int insert(Users2DTO dto) {
        return sqlSession.insert(NS + "insert", dto);
    }

    /** 수정 */
    @Override
    public int update(Users2DTO dto) {
        return sqlSession.update(NS + "update", dto);
    }

    /** 삭제 */
    @Override
    public int delete(String userId) {
        return sqlSession.delete(NS + "delete", userId);
    }
    
    @Override
    public String getLastUserId() {
        return sqlSession.selectOne(NS + "getLastUserId");
    }
    

}