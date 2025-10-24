package kr.or.mes.dto.Dashboard;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 생산 통계 DTO
 * 전체 생산량 현황을 담는 객체
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductionStatsDTO {
    private int totalPlannedQty;    // 총 계획 수량
    private int totalActualQty;     // 총 실제 수량
    private int totalLots;          // 총 LOT 수
    private int completedLots;     // 완료된 LOT 수
    private int inProgressLots;    // 진행중인 LOT 수
    private int plannedLots;       // 계획된 LOT 수
    private double completionRate; // 완료율 (%)
}
