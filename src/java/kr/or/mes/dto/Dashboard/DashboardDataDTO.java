package kr.or.mes.dto.Dashboard;

import java.util.List;

import kr.or.mes.dto.Production2DTO;
import lombok.*;

/**
 * 대시보드 데이터 DTO
 * 대시보드에 필요한 모든 데이터를 담는 객체
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DashboardDataDTO {
    private List<Production2DTO> allProductions;     // 전체 생산 항목 목록
    private ProductionStatsDTO productionStats;       // 생산 통계
    private Production2DTO selectedProduction;        // 선택된 생산 항목
}
