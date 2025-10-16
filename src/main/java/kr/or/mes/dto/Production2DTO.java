package kr.or.mes.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Production2DTO {
    private String lotNumber;           // LOT 번호
    private String productCode;         // 제품 코드
    private String productName;         // 제품명 (Standard 테이블과 조인)
    private int plannedQty;             // 계획 수량
    private Integer actualQty;          // 실제 수량
    private String status;              // 상태 (PLANNED, IN_PROGRESS, COMPLETED, CANCELLED)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date plannedStartDate;      // 계획 시작일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date plannedEndDate;        // 계획 종료일
    private Date actualStartDate;       // 실제 시작일
    private Date actualEndDate;         // 실제 종료일
    private Date createdDate;           // 등록일
    private Date updatedDate;           // 수정일
    private String createdBy;           // 등록자
    private String updatedBy;           // 수정자
	
    
}
