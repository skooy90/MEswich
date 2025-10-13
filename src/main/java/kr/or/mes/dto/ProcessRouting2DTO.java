package kr.or.mes.dto;

import java.util.Date;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProcessRouting2DTO {
    private int routingId;          // 라우팅 ID
    private String productCode;     // 제품 코드
    private int operationSeq;       // 공정 순서
    private String operationCode;   // 공정 코드
    private String operationName;   // 공정명
    private Integer standardTime;   // 표준 시간
    private Date createdDate;       // 등록일
    private Date updatedDate;       // 수정일
    private String createdBy;       // 등록자
    private String updatedBy;       // 수정자
}
