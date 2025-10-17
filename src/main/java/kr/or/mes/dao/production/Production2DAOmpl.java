package kr.or.mes.dao.production;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

@Repository
public class Production2DAOmpl implements Production2DAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Production2DTO> selectAll() {
		List<Production2DTO> resultList = null;
		
		resultList = sqlSession.selectList("mes.mappers.Production2.selectAllPro");
		System.out.println(resultList);
		return resultList;
	}
	@Override
	public List<Production2DTO> todoselectAll() {
		List<Production2DTO> resultList = null;

		resultList = sqlSession.selectList("mes.mappers.Production2.selectAllProduction");
		System.out.println(resultList);
		return resultList;
	}

	@Override
	public List<Production2DTO> selectByCondition(Production2DTO dto) {
		return sqlSession.selectList("mes.mappers.Production2.selectProductionByCondition", dto);
	}

	@Override
	public Production2DTO selectByLotNumber(String lotNumber) {
		return sqlSession.selectOne("mes.mappers.Production2.selectProductionByLotNumber", lotNumber);
	}

	@Override
	public int insert(Production2DTO production) {
		return sqlSession.insert("mes.mappers.Production2.insertProduction", production);
	}

	@Override
	public int update(Production2DTO production) {
		return sqlSession.update("mes.mappers.Production2.updateProduction", production);
	}

	@Override
	public int delete(String lotNumber) {
		return sqlSession.delete("mes.mappers.Production2.deleteProduction", lotNumber);
	}

	@Override
	public int deleteByLotNumber(String lotNumber) {
		return sqlSession.delete("mes.mappers.Production2.deleteProduction", lotNumber);
	}

	@Override
	public int updateStatus(Production2DTO production) {
		return sqlSession.update("mes.mappers.Production2.updateProductionStatus", production);
	}

	@Override
	public int updateActualQuantity(Production2DTO production) {
		return sqlSession.update("mes.mappers.Production2.updateActualQuantity", production);
	}

	@Override
	public List<Standard2DTO> selectFinishedGoods() {
		return sqlSession.selectList("mes.mappers.Production2.selectFinishedGoods");
	}

	@Override
	public List<Production2DTO> selectByStatus(String status) {
		return sqlSession.selectList("mes.mappers.Production2.selectProductionByStatus", status);
	}

	// ==================== 전체 생산계획 관련 메서드 ====================
	
	@Override
	public List<Production2DTO> selectAllProductionPlans() {
		return sqlSession.selectList("mes.mappers.Production2.selectAllProductionPlans");
	}
	
	@Override
	public int insertAllProduction(Production2DTO production) {
		return sqlSession.insert("mes.mappers.Production2.insertAllProduction", production);
	}
	
	// ==================== 금일 생산계획 관련 메서드 ====================
	
	@Override
	public List<Production2DTO> selectDailyProductionPlans() {
		return sqlSession.selectList("mes.mappers.Production2.selectDailyProductionPlans");
	}
	
	@Override
	public List<Production2DTO> selectDailyProductionByCondition(Production2DTO dto) {
		return sqlSession.selectList("mes.mappers.Production2.selectDailyProductionByCondition", dto);
	}
	
	@Override
	public int insertDailyProduction(Production2DTO production) {
		return sqlSession.insert("mes.mappers.Production2.insertDailyProduction", production);
	}
	
	@Override
	public Production2DTO selectProductionForDailySchedule(String lotNumber) {
		return sqlSession.selectOne("mes.mappers.Production2.selectProductionForDailySchedule", lotNumber);
	}
	
	@Override
	public int updateDailyProductionStatus(Production2DTO production) {
		return sqlSession.update("mes.mappers.Production2.updateDailyProductionStatus", production);
	}

}
