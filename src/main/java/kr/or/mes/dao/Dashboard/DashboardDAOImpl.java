package kr.or.mes.dao.Dashboard;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Dashboard.ProductionStatsDTO;
import kr.or.mes.dto.Dashboard.DefectDailyDTO;
import kr.or.mes.dto.Dashboard.DefectCauseDTO;
import kr.or.mes.dto.Dashboard.WorkStatusDTO;
import kr.or.mes.dto.Dashboard.ProductStatusDTO;

/**
 * 대시보드 DAO 구현체
 * MyBatis SqlSession을 사용하여 DashboardMapper.xml의 쿼리 실행
 */
@Repository
public class DashboardDAOImpl implements DashboardDAO {
    
    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 전체 생산량 통계 조회
     * @return 생산 통계 데이터
     */
    @Override
    public ProductionStatsDTO getTotalProductionStats() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getTotalProductionStats");
    }
    
    /**
     * 전체 생산 항목 목록 조회
     * @return 생산 항목 목록
     */
    @Override
    public List<Production2DTO> getAllProductions() {
        return sqlSession.selectList("kr.or.mes.dao.Dashboard.DashboardDAO.getAllProductions");
    }
    
    /**
     * 선택된 생산 항목 상세 조회
     * @param lotNumber LOT 번호
     * @return 생산 항목 상세 정보
     */
    @Override
    public Production2DTO getProductionByLot(String lotNumber) {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getProductionByLot", lotNumber);
    }
    
    /**
     * 총 불량 갯수 조회
     * @return 총 불량 갯수
     */
    @Override
    public int getTotalDefects() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getTotalDefects");
    }
    
    /**
     * 일별 불량 갯수 조회
     * @return 일별 불량 데이터 리스트
     */
    @Override
    public List<DefectDailyDTO> getDailyDefects() {
        return sqlSession.selectList("kr.or.mes.dao.Dashboard.DashboardDAO.getDailyDefects");
    }
    
    /**
     * 총 불량 갯수 조회 (3가지 원인만)
     * @return 총 불량 갯수
     */
    @Override
    public int getTotalDefectsByCause() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getTotalDefectsByCause");
    }
    
    /**
     * 불량 원인별 갯수 조회
     * @return 불량 원인별 데이터 리스트
     */
    @Override
    public List<DefectCauseDTO> getDefectCauses() {
        return sqlSession.selectList("kr.or.mes.dao.Dashboard.DashboardDAO.getDefectCauses");
    }
    
    // ===== 4번 위젯: 작업현황 관련 메서드 =====
    
    /**
     * 총 작업 수 조회
     * @return 총 작업 수
     */
    @Override
    public int getTotalWorks() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getTotalWorks");
    }
    
    /**
     * 진행 중인 작업 수 조회
     * @return 진행 중인 작업 수
     */
    @Override
    public int getInProgressWorks() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getInProgressWorks");
    }
    
    /**
     * 완료된 작업 수 조회
     * @return 완료된 작업 수
     */
    @Override
    public int getCompletedWorks() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getCompletedWorks");
    }
    
    /**
     * 대기 중인 작업 수 조회
     * @return 대기 중인 작업 수
     */
    @Override
    public int getReadyWorks() {
        return sqlSession.selectOne("kr.or.mes.dao.Dashboard.DashboardDAO.getReadyWorks");
    }
    
    /**
     * 작업 상태별 통계 조회
     * @return 작업 상태별 데이터 리스트
     */
    @Override
    public List<WorkStatusDTO> getWorkStatusStats() {
        return sqlSession.selectList("kr.or.mes.dao.Dashboard.DashboardDAO.getWorkStatusStats");
    }
    
    /**
     * 완제품별 현황 조회
     * @return 완제품별 데이터 리스트
     */
    @Override
    public List<ProductStatusDTO> getProductStatusStats() {
        return sqlSession.selectList("kr.or.mes.dao.Dashboard.DashboardDAO.getProductStatusStats");
    }
}
