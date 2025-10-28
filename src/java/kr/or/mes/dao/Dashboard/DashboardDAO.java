package kr.or.mes.dao.Dashboard;

import java.util.List;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Dashboard.ProductionStatsDTO;
import kr.or.mes.dto.Dashboard.DefectDailyDTO;
import kr.or.mes.dto.Dashboard.DefectCauseDTO;
import kr.or.mes.dto.Dashboard.WorkStatusDTO;
import kr.or.mes.dto.Dashboard.ProductStatusDTO;

/**
 * 대시보드 DAO 인터페이스
 * 대시보드 데이터 접근 메서드 정의
 */
public interface DashboardDAO {
    
    /** 전체 생산량 통계 조회 */
    ProductionStatsDTO getTotalProductionStats();
    
    /** 전체 생산 항목 목록 조회 */
    List<Production2DTO> getAllProductions();
    
    /** 선택된 생산 항목 상세 조회 */
    Production2DTO getProductionByLot(String lotNumber);
    
    /** 총 불량 갯수 조회 */
    int getTotalDefects();
    
    /** 일별 불량 갯수 조회 */
    List<DefectDailyDTO> getDailyDefects();
    
    /** 총 불량 갯수 조회 (3가지 원인만) */
    int getTotalDefectsByCause();
    
    /** 불량 원인별 갯수 조회 */
    List<DefectCauseDTO> getDefectCauses();
    
    // ===== 4번 위젯: 작업현황 관련 메서드 =====
    
    /** 총 작업 수 조회 */
    int getTotalWorks();
    
    /** 진행 중인 작업 수 조회 */
    int getInProgressWorks();
    
    /** 완료된 작업 수 조회 */
    int getCompletedWorks();
    
    /** 대기 중인 작업 수 조회 */
    int getReadyWorks();
    
    /** 작업 상태별 통계 조회 */
    List<WorkStatusDTO> getWorkStatusStats();
    
    /** 완제품별 현황 조회 */
    List<ProductStatusDTO> getProductStatusStats();
}