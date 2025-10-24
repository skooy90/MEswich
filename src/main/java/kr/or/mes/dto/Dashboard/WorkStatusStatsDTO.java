package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.util.List;

/**
 * 작업현황 통계 DTO
 * 전체 작업 현황과 상태별 분포, 완제품별 현황을 담는 클래스
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WorkStatusStatsDTO {
    private int totalWorks;        // 총 작업 수
    private int inProgressWorks;  // 진행 중인 작업 수
    private int completedWorks;   // 완료된 작업 수
    private int readyWorks;        // 대기 중인 작업 수
    private List<WorkStatusDTO> statusList;     // 상태별 분포
    private List<ProductStatusDTO> productList; // 완제품별 현황
}
