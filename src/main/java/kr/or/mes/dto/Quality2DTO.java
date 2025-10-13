package kr.or.mes.dto;

import java.util.Date;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Quality2DTO {
    private String inspectionNo;    // 검사 번호
    private String workOrderNo;     // 작업지시 번호
    private String lotNumber;       // LOT 번호
    private String status;          // 상태 (PENDING, PASS, FAIL, HOLD)
    private String inspectorId;     // 검사자 ID
    private String inspectorName;   // 검사자 이름
    private Integer goodQty;        // 양품 수량
    private Integer defectQty;      // 불량 수량
    private String defectReason;    // 불량 사유
    private Date inspectionDate;    // 검사 일자
    private Date createdDate;       // 생성일
    private Date updatedDate;       // 수정일
    private String createdBy;       // 생성자
    private String updatedBy;       // 수정자
}
