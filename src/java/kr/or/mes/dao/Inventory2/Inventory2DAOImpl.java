package kr.or.mes.dao.Inventory2;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.mes.dto.Inventory2DTO;

/**
 * 재고관리 DAO 구현체
 * MyBatis SqlSession을 사용하여 Inventory2Mapper.xml의 쿼리 실행
 */
@Repository
public class Inventory2DAOImpl implements Inventory2DAO {
    
    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 전체재고현황 조회 (품목명 포함)
     * @param dto 검색 조건이 포함된 Inventory2DTO
     * @return 조건에 맞는 재고 목록
     */
    @Override
    public List<Inventory2DTO> selectAllInventory(Inventory2DTO dto) {
        return sqlSession.selectList("kr.or.mes.dao.Inventory2.Inventory2DAO.selectAllInventory", dto);
    }
    
    /**
     * 재고 상세 조회
     * @param inventoryId 재고 ID
     * @return 해당 재고 정보
     */
    @Override
    public Inventory2DTO selectInventoryById(int inventoryId) {
        return sqlSession.selectOne("kr.or.mes.dao.Inventory2.Inventory2DAO.selectInventoryById", inventoryId);
    }
    
    /**
     * 조건별 재고 검색
     * @param dto 검색 조건이 포함된 Inventory2DTO
     * @return 조건에 맞는 재고 목록
     */
    @Override
    public List<Inventory2DTO> selectInventoryByCondition(Inventory2DTO dto) {
        return sqlSession.selectList("kr.or.mes.dao.Inventory2.Inventory2DAO.selectInventoryByCondition", dto);
    }
    
    /**
     * 재고 등록
     * @param dto 등록할 재고 정보
     * @return 등록된 행 수
     */
    @Override
    public int insertInventory(Inventory2DTO dto) {
        return sqlSession.insert("kr.or.mes.dao.Inventory2.Inventory2DAO.insertInventory", dto);
    }
    
    /**
     * 재고 중복 체크 (LOT번호 기준)
     * @param lotNumber LOT번호
     * @return 기존 재고 정보 (없으면 null)
     */
    @Override
    public Inventory2DTO selectInventoryByLot(String lotNumber) {
        return sqlSession.selectOne("kr.or.mes.dao.Inventory2.Inventory2DAO.selectInventoryByLot", lotNumber);
    }
    
    /**
     * 재고 수량 업데이트
     * @param dto 수량 업데이트할 재고 정보
     * @return 업데이트된 행 수
     */
    @Override
    public int updateInventoryQty(Inventory2DTO dto) {
        return sqlSession.update("kr.or.mes.dao.Inventory2.Inventory2DAO.updateInventoryQty", dto);
    }
    
    /**
     * 재고 수정
     * @param dto 수정할 재고 정보
     * @return 수정된 행 수
     */
    @Override
    public int updateInventory(Inventory2DTO dto) {
        return sqlSession.update("kr.or.mes.dao.Inventory2.Inventory2DAO.updateInventory", dto);
    }
    
    /**
     * 재고 삭제
     * @param inventoryId 삭제할 재고 ID
     * @return 삭제된 행 수
     */
    @Override
    public int deleteInventory(int inventoryId) {
        return sqlSession.delete("kr.or.mes.dao.Inventory2.Inventory2DAO.deleteInventory", inventoryId);
    }
}
