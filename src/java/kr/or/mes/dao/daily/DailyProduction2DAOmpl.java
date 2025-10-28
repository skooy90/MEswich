package kr.or.mes.dao.daily;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.DailyProduction2DTO;

/**
 * 금일 생산계획 DAO 구현체
 * Daily_Production2_Plans 테이블과 관련된 데이터 접근 로직을 구현
 * 
 * @author MES System
 * @version 1.0
 * @since 2024-10-17
 */
@Repository
public class DailyProduction2DAOmpl implements DailyProduction2DAO {

    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 금일 생산계획 전체 조회
     * @return 금일 생산계획 목록
     */
    @Override
    public List<DailyProduction2DTO> selectAllDailyProductionPlans() {
        return sqlSession.selectList("mes.mappers.DailyProduction2.selectAllDailyProductionPlans");
    }
    
    /**
     * 금일 생산계획 조건별 검색
     * @param dto 검색 조건이 담긴 DTO
     * @return 검색된 금일 생산계획 목록
     */
    @Override
    public List<DailyProduction2DTO> selectDailyProductionByCondition(DailyProduction2DTO dto) {
        return sqlSession.selectList("mes.mappers.DailyProduction2.selectDailyProductionByCondition", dto);
    }
    
    /**
     * LOT 번호로 금일 생산계획 단건 조회
     * @param lotNumber LOT 번호
     * @return 금일 생산계획 정보
     */
    @Override
    public DailyProduction2DTO selectDailyProductionByLotNumber(String lotNumber) {
        return sqlSession.selectOne("mes.mappers.DailyProduction2.selectDailyProductionByLotNumber", lotNumber);
    }
    
    /**
     * daily_plan_id로 금일 생산계획 단건 조회
     * @param dailyPlanId 금일 생산계획 ID
     * @return 금일 생산계획 정보
     */
    @Override
    public DailyProduction2DTO selectDailyProductionById(String dailyPlanId) {
        return sqlSession.selectOne("mes.mappers.DailyProduction2.selectDailyProductionById", dailyPlanId);
    }
    
    /**
     * 새로운 금일 생산계획 등록
     * @param dailyProduction 등록할 금일 생산계획 정보
     * @return 등록 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int insertDailyProduction(DailyProduction2DTO dailyProduction) {
        return sqlSession.insert("mes.mappers.DailyProduction2.insertDailyProduction", dailyProduction);
    }
    
    /**
     * 금일 생산계획 정보 수정
     * @param dailyProduction 수정할 금일 생산계획 정보
     * @return 수정 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int updateDailyProduction(DailyProduction2DTO dailyProduction) {
        return sqlSession.update("mes.mappers.DailyProduction2.updateDailyProduction", dailyProduction);
    }
    
    /**
     * daily_plan_id로 금일 생산계획 삭제
     * @param dailyPlanId 삭제할 금일 생산계획 ID
     * @return 삭제 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int deleteDailyProductionById(String dailyPlanId) {
        return sqlSession.delete("mes.mappers.DailyProduction2.deleteDailyProductionById", dailyPlanId);
    }
    
    /**
     * LOT 번호로 금일 생산계획 삭제
     * @param lotNumber 삭제할 LOT 번호
     * @return 삭제 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int deleteDailyProductionByLotNumber(String lotNumber) {
        return sqlSession.delete("mes.mappers.DailyProduction2.deleteDailyProductionByLotNumber", lotNumber);
    }
    
    /**
     * 금일 생산계획 상태 업데이트
     * @param dailyProduction 상태 업데이트할 금일 생산계획 정보
     * @return 업데이트 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int updateDailyProductionStatus(DailyProduction2DTO dailyProduction) {
        return sqlSession.update("mes.mappers.DailyProduction2.updateDailyProductionStatus", dailyProduction);
    }
    
    /**
     * 금일 생산계획 실제 수량 업데이트
     * @param dailyProduction 실제 수량 업데이트할 금일 생산계획 정보
     * @return 업데이트 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int updateDailyProductionActualQty(DailyProduction2DTO dailyProduction) {
        return sqlSession.update("mes.mappers.DailyProduction2.updateDailyProductionActualQty", dailyProduction);
    }
    
    /**
     * 금일 생산계획 작업자 배정
     * @param dailyProduction 작업자 배정할 금일 생산계획 정보
     * @return 업데이트 결과 (1: 성공, 0: 실패)
     */
    @Override
    public int assignWorkerToDailyProduction(DailyProduction2DTO dailyProduction) {
        return sqlSession.update("mes.mappers.DailyProduction2.assignWorkerToDailyProduction", dailyProduction);
    }
    
    /**
     * 상태별 금일 생산계획 조회
     * @param status 조회할 상태
     * @return 해당 상태의 금일 생산계획 목록
     */
    @Override
    public List<DailyProduction2DTO> selectDailyProductionByStatus(String status) {
        return sqlSession.selectList("mes.mappers.DailyProduction2.selectDailyProductionByStatus", status);
    }
    
    /**
     * 특정 전체 생산계획의 금일 생산계획 목록 조회
     * @param parentLotNumber 원본 전체 생산계획 LOT 번호
     * @return 해당 전체 생산계획의 금일 생산계획 목록
     */
    @Override
    public List<DailyProduction2DTO> selectDailyProductionByParentLot(String parentLotNumber) {
        return sqlSession.selectList("mes.mappers.DailyProduction2.selectDailyProductionByParentLot", parentLotNumber);
    }
    
    /**
     * 특정 전체 생산계획의 금일 생산계획 수량 합계 조회
     * @param parentLotNumber 원본 전체 생산계획 LOT 번호
     * @return 금일 생산계획 수량 합계
     */
    @Override
    public int selectTotalDailyQtyByParentLot(String parentLotNumber) {
        Integer result = sqlSession.selectOne("mes.mappers.DailyProduction2.selectTotalDailyQtyByParentLot", parentLotNumber);
        return result != null ? result : 0;
    }
    
    /**
     * 특정 전체 생산계획의 금일 생산계획 실제 수량 합계 조회
     * @param parentLotNumber 원본 전체 생산계획 LOT 번호
     * @return 금일 생산계획 실제 수량 합계
     */
    @Override
    public int selectTotalActualQtyByParentLot(String parentLotNumber) {
        Integer result = sqlSession.selectOne("mes.mappers.DailyProduction2.selectTotalActualQtyByParentLot", parentLotNumber);
        return result != null ? result : 0;
    }
    
    /**
     * 작업자별 금일 생산계획 조회
     * @param workerId 작업자 ID
     * @return 해당 작업자의 금일 생산계획 목록
     */
    @Override
    public List<DailyProduction2DTO> selectDailyProductionByWorker(String workerId) {
        return sqlSession.selectList("mes.mappers.DailyProduction2.selectDailyProductionByWorker", workerId);
    }
    
    /**
     * 특정 parent_lot_number에 대한 최대 시퀀스 번호 조회
     * @param parentLotNumber 원본 전체 생산계획 LOT 번호
     * @return 최대 시퀀스 번호
     */
    @Override
    public int getMaxSequenceForParentLot(String parentLotNumber) {
        Integer result = sqlSession.selectOne("mes.mappers.DailyProduction2.getMaxSequenceForParentLot", parentLotNumber);
        return result != null ? result : 0;
    }
}
