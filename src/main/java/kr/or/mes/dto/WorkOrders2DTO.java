package kr.or.mes.dto;

import java.util.Date;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WorkOrders2DTO {
    private String workOrderNo;     // 작업 지시 번호
    private String lotNumber;       // LOT 번호
    private String productCode;     // 제품 코드
    private int plannedQty;         // 계획 수량
    private Integer actualQty;      // 실제 수량
    private String status;          // 상태 (READY, IN_PROGRESS, DONE, CANCELLED)
    private String workerId;        // 작업자 ID
    private Date startDate;         // 시작일
    private Date endDate;           // 종료일
    private Date createdDate;       // 생성일
    private Date updatedDate;       // 수정일
    private String createdBy;       // 생성자
    private String updatedBy;       // 수정자
}
