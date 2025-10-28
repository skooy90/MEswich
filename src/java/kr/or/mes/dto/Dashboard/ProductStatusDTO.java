package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

/**
 * 완제품별 현황 DTO
 * Work_Orders2와 Standard2 테이블을 조인한 완제품별 작업 현황을 담는 클래스
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductStatusDTO {
    private String productName;     // 완제품명
    private int plannedQty;        // 계획 수량
    private int actualQty;         // 실제 수량
    private String workStatus;      // 작업 상태
    private double completionRate;  // 완료율
}

