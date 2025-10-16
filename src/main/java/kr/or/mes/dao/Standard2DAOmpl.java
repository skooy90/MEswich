package kr.or.mes.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Standard2DTO;

@Repository
public class Standard2DAOmpl implements Standard2DAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<Standard2DTO> selectAll() {
		List<Standard2DTO> resultList = null;

		resultList = sqlSession.selectList("kr.or.mes.dao.Standard2DAO.selectAll");
		System.out.println(resultList);
		return resultList;
	}

	@Override
	public Standard2DTO selectById(String itemCode) {
		
		Standard2DTO dto = null;
		dto = sqlSession.selectOne("kr.or.mes.dao.Standard2DAO.selectById");
		System.out.println("dto : " + dto);
		return dto;
		
	}

	@Override
	public int insert(Standard2DTO dto) {
		System.out.println("dao잘옴 ========================");
		return sqlSession.insert("kr.or.mes.dao.Standard2DAO.insert",dto);
	}

	@Override
	public int update(Standard2DTO dto) {
		return sqlSession.update("kr.or.mes.dao.Standard2DAO.update",dto);
	}

	@Override
	public int delete(String itemCode) {
		return sqlSession.delete("kr.or.mes.dao.Standard2DAO.delete",itemCode);
	}

}
