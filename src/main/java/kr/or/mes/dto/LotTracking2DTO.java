package kr.or.mes.dto;

import java.util.Date;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LotTracking2DTO {
    private int trackingId;         // 추적 ID
    private String lotNumber;       // LOT 번호
    private String status;          // 상태 (PLANNED, IN_PROGRESS, COMPLETED, HOLD, CANCELLED)
    private Date startDate;         // 시작일
    private Date endDate;           // 종료일
    private String remarks;         // 비고
    private Date createdDate;       // 생성일
    private String updatedBy;       // 수정자
}
