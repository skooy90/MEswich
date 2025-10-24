package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

/**
 * 작업 상태별 통계 DTO
 * Work_Orders2 테이블의 상태별 작업 수를 담는 클래스
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WorkStatusDTO {
    private String status;      // READY, IN_PROGRESS, DONE, CANCELLED
    private int workCount;      // 해당 상태의 작업 수
}
