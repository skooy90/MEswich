package kr.or.mes.service.Dashboard;

import java.util.List;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Dashboard.DashboardDataDTO;
import kr.or.mes.dto.Dashboard.DefectCauseStatsDTO;
import kr.or.mes.dto.Dashboard.DefectStatsDTO;
import kr.or.mes.dto.Dashboard.ProductionStatsDTO;
import kr.or.mes.dto.Dashboard.ProductionStatusDTO;
import kr.or.mes.dto.Dashboard.WorkStatusStatsDTO;

/**
 * 대시보드 Service 인터페이스
 * 대시보드 관련 비즈니스 로직 정의
 */
public interface DashboardService {
    
    /** 대시보드 전체 데이터 조회 (비즈니스 로직) */
    DashboardDataDTO getDashboardData(String selectedLot);
    
    /** 전체 생산량 통계 조회 */
    ProductionStatsDTO getTotalProductionStats();
    
    /** 전체 생산 항목 목록 조회 */
    List<Production2DTO> getAllProductions();
    
    /** 선택된 생산 항목 상세 조회 */
    Production2DTO getProductionByLot(String lotNumber);
    
    /** 생산 항목 유효성 검증 */
    boolean isValidProductionLot(String lotNumber);
    
    /** 생산 완료율 계산 */
    double calculateCompletionRate(int plannedQty, int actualQty);
    
    /** 생산 상태별 분류 */
    ProductionStatusDTO classifyProductionStatus(Production2DTO production);
    
    /** 불량 통계 조회 (총 불량 갯수와 일별 불량 데이터) */
    DefectStatsDTO getDefectStats();
    
    /** 불량 원인별 통계 조회 (설비결함, 포장불량, 모형문제) */
    DefectCauseStatsDTO getDefectCauseStats();
    
    /** 작업현황 통계 조회 (작업 상태별 분포와 완제품별 현황) */
    WorkStatusStatsDTO getWorkStatusStats();
}
