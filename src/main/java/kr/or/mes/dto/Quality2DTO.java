package kr.or.mes.dto;

import java.util.Date;

import lombok.Data;

/**
 * 품질검사 DTO 클래스
 * 품질검사 정보를 담는 데이터 전송 객체
 */
@Data
public class Quality2DTO {
    
    private String inspectionNo;      // 검사번호
    private String workOrderNo;       // 작업지시번호
    private String lotNumber;         // LOT번호
    private String status;            // 상태 (PENDING, PASS, FAIL, HOLD)
    private String inspectorId;       // 검사자 ID
    private String inspectorName;     // 검사자명
    private Integer goodQty;          // 양품수량
    private Integer defectQty;        // 불량수량
    private String defectReason;      // 불량사유
    private Date inspectionDate;      // 검사일
    private Date createdDate;         // 생성일
    private Date updatedDate;         // 수정일
    private String createdBy;         // 생성자
    private String updatedBy;         // 수정자
    private String Location;     // 재고 등록 확인
    private String dailyLotNumber;    // daily_LOT 번호
    
    // JOIN을 위한 추가 필드
    private String productCode;       // 제품코드
    private String productName;       // 제품명
    private Integer plannedQty;       // 계획수량
    private Integer actualQty;        // 실제수량
    private String workerId;          // 작업자 ID


}