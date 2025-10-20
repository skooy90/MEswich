package kr.or.mes.dto;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProcessRouting2DTO {
    private int routingId;
    private String productCode;
    private String productName; // ← 추가
    private int operationSeq;
    private String operationCode;
    private String operationName;
    private String operationDesc;
    private int standardTime;
    private Date createdDate;
    private Date updatedDate;
    private String createdBy;
    private String updatedBy;
}