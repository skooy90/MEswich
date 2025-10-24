package kr.or.mes.dto.Dashboard;

import lombok.*;

/**
 * 생산 상태 DTO
 * 생산 항목의 상태 정보를 담는 객체
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductionStatusDTO {
    private String lotNumber;        // LOT 번호
    private String status;           // 상태
    private String progressStatus;   // 진행 상태
    private String progressColor;    // 진행 상태 색상
    private double completionRate;   // 완료율
}
