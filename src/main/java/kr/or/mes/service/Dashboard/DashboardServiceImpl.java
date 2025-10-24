package kr.or.mes.service.Dashboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.Dashboard.DashboardDAO;
import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Dashboard.DashboardDataDTO;
import kr.or.mes.dto.Dashboard.ProductionStatsDTO;
import kr.or.mes.dto.Dashboard.ProductionStatusDTO;
import kr.or.mes.dto.Dashboard.DefectStatsDTO;
import kr.or.mes.dto.Dashboard.DefectDailyDTO;
import kr.or.mes.dto.Dashboard.DefectCauseStatsDTO;
import kr.or.mes.dto.Dashboard.DefectCauseDTO;
import kr.or.mes.dto.Dashboard.WorkStatusStatsDTO;
import kr.or.mes.dto.Dashboard.WorkStatusDTO;
import kr.or.mes.dto.Dashboard.ProductStatusDTO;

/**
 * 대시보드 Service 구현체
 * 대시보드 비즈니스 로직 처리
 */
@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private DashboardDAO dashboardDAO;

    /**
     * 대시보드 전체 데이터 조회 (비즈니스 로직)
     * @param selectedLot 선택된 LOT 번호
     * @return 대시보드 데이터
     */
    @Override
    public DashboardDataDTO getDashboardData(String selectedLot) {
        DashboardDataDTO dashboardData = new DashboardDataDTO();
        
        // 전체 생산 항목 목록 조회
        List<Production2DTO> allProductions = getAllProductions();
        dashboardData.setAllProductions(allProductions);
        
        // 전체 생산량 통계 조회
        ProductionStatsDTO productionStats = getTotalProductionStats();
        dashboardData.setProductionStats(productionStats);
        
        // 선택된 LOT이 있으면 해당 항목의 상세 정보 조회
        Production2DTO selectedProduction = null;
        if (selectedLot != null && !selectedLot.isEmpty()) {
            // LOT 번호 유효성 검증
            if (isValidProductionLot(selectedLot)) {
                selectedProduction = getProductionByLot(selectedLot);
                
                // 생산 완료율 계산 및 상태 분류
                if (selectedProduction != null) {
                    double completionRate = calculateCompletionRate(
                        selectedProduction.getPlannedQty(), 
                        selectedProduction.getActualQty() != null ? selectedProduction.getActualQty() : 0
                    );
                    // DTO에 완료율 정보 추가 (필요시 Production2DTO에 completionRate 필드 추가)
                }
            }
        }
        dashboardData.setSelectedProduction(selectedProduction);
        
        return dashboardData;
    }

    /**
     * 전체 생산량 통계 조회
     * @return 생산 통계 데이터
     */
    @Override
    public ProductionStatsDTO getTotalProductionStats() {
        return dashboardDAO.getTotalProductionStats();
    }

    /**
     * 전체 생산 항목 목록 조회
     * @return 생산 항목 목록
     */
    @Override
    public List<Production2DTO> getAllProductions() {
        return dashboardDAO.getAllProductions();
    }

    /**
     * 선택된 생산 항목 상세 조회
     * @param lotNumber LOT 번호
     * @return 생산 항목 상세 정보
     */
    @Override
    public Production2DTO getProductionByLot(String lotNumber) {
        if (lotNumber == null || lotNumber.trim().isEmpty()) {
            return null;
        }
        return dashboardDAO.getProductionByLot(lotNumber);
    }

    /**
     * 생산 항목 유효성 검증
     * @param lotNumber LOT 번호
     * @return 유효성 여부
     */
    @Override
    public boolean isValidProductionLot(String lotNumber) {
        if (lotNumber == null || lotNumber.trim().isEmpty()) {
            return false;
        }
        
        // LOT 번호 형식 검증 (예: LOT20241201-0001)
        if (!lotNumber.matches("^LOT\\d{8}-\\d{4}$")) {
            return false;
        }
        
        // 데이터베이스에서 존재 여부 확인
        Production2DTO production = dashboardDAO.getProductionByLot(lotNumber);
        return production != null;
    }

    /**
     * 생산 완료율 계산
     * @param plannedQty 계획 수량
     * @param actualQty 실제 수량
     * @return 완료율 (%)
     */
    @Override
    public double calculateCompletionRate(int plannedQty, int actualQty) {
        if (plannedQty <= 0) {
            return 0.0;
        }
        
        double rate = (actualQty * 100.0) / plannedQty;
        return Math.min(rate, 100.0); // 최대 100%로 제한
    }

    /**
     * 생산 상태별 분류
     * @param production 생산 항목
     * @return 생산 상태 정보
     */
    @Override
    public ProductionStatusDTO classifyProductionStatus(Production2DTO production) {
        if (production == null) {
            return null;
        }
        
        ProductionStatusDTO status = new ProductionStatusDTO();
        status.setLotNumber(production.getLotNumber());
        status.setStatus(production.getStatus());
        
        // 완료율에 따른 상태 분류
        double completionRate = calculateCompletionRate(
            production.getPlannedQty(), 
            production.getActualQty() != null ? production.getActualQty() : 0
        );
        
        if (completionRate >= 100) {
            status.setProgressStatus("완료");
            status.setProgressColor("#2ecc71");
        } else if (completionRate >= 50) {
            status.setProgressStatus("진행중");
            status.setProgressColor("#f39c12");
        } else if (completionRate > 0) {
            status.setProgressStatus("시작됨");
            status.setProgressColor("#3498db");
        } else {
            status.setProgressStatus("대기중");
            status.setProgressColor("#95a5a6");
        }
        
        status.setCompletionRate(completionRate);
        return status;
    }
    
    /**
     * 불량 통계 조회 (총 불량 갯수와 일별 불량 데이터)
     * @return 불량 통계 데이터
     */
    @Override
    public DefectStatsDTO getDefectStats() {
        // 총 불량 갯수 조회
        int totalDefects = dashboardDAO.getTotalDefects();
        
        // 일별 불량 갯수 조회
        List<DefectDailyDTO> dailyDefects = dashboardDAO.getDailyDefects();
        
        // DefectStatsDTO 구성
        return DefectStatsDTO.builder()
                .totalDefects(totalDefects)
                .dailyDefects(dailyDefects)
                .build();
    }
    
    /**
     * 불량 원인별 통계 조회 (설비결함, 포장불량, 모형문제)
     * @return 불량 원인별 통계 데이터
     */
    @Override
    public DefectCauseStatsDTO getDefectCauseStats() {
        // 총 불량 갯수 조회 (3가지 원인만)
        int totalDefects = dashboardDAO.getTotalDefectsByCause();
        
        // 불량 원인별 갯수 조회
        List<DefectCauseDTO> causeList = dashboardDAO.getDefectCauses();
        
        // 각 원인별 비율 계산
        if (totalDefects > 0) {
            for (DefectCauseDTO cause : causeList) {
                double percentage = (double) cause.getDefectCount() / totalDefects * 100;
                cause.setPercentage(Math.round(percentage * 100.0) / 100.0); // 소수점 2자리까지
            }
        }
        
        // DefectCauseStatsDTO 구성
        return DefectCauseStatsDTO.builder()
                .totalDefects(totalDefects)
                .causeList(causeList)
                .build();
    }
    
    /**
     * 작업현황 통계 조회
     * 작업 상태별 분포와 완제품별 현황을 조회하여 통합 데이터 구성
     * @return 작업현황 통계 데이터
     */
    @Override
    public WorkStatusStatsDTO getWorkStatusStats() {
        // 기본 통계 조회
        int totalWorks = dashboardDAO.getTotalWorks();
        int inProgressWorks = dashboardDAO.getInProgressWorks();
        int completedWorks = dashboardDAO.getCompletedWorks();
        int readyWorks = dashboardDAO.getReadyWorks();
        
        // 상태별 분포 조회
        List<WorkStatusDTO> statusList = dashboardDAO.getWorkStatusStats();
        
        // 완제품별 현황 조회
        List<ProductStatusDTO> productList = dashboardDAO.getProductStatusStats();
        
        // WorkStatusStatsDTO 구성
        return WorkStatusStatsDTO.builder()
                .totalWorks(totalWorks)
                .inProgressWorks(inProgressWorks)
                .completedWorks(completedWorks)
                .readyWorks(readyWorks)
                .statusList(statusList)
                .productList(productList)
                .build();
    }
}
