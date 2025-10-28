package kr.or.mes.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 금일 생산계획 DTO
 * Daily_Production2_Plans 테이블과 매핑되는 데이터 전송 객체
 * 
 * @author MES System
 * @version 1.0
 * @since 2024-10-17
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DailyProduction2DTO {
    
    /**
     * 금일 생산계획 ID (Primary Key)
     * 형식: DP + YYYYMMDDHH24MISS + 3자리 시퀀스
     * 예: DP20241017123456001
     */
    private String dailyPlanId;
    
    /**
     * 금일 생산계획 LOT 번호
     * 형식: 전체생산계획LOT번호-01, 전체생산계획LOT번호-02, ...
     * 예: LOT20241017123456-01
     */
    private String lotNumber;
    
    /**
     * 원본 전체 생산계획 LOT 번호 (Foreign Key)
     * Production2 테이블의 lot_number를 참조
     * 예: LOT20241017123456
     */
    private String parentLotNumber;
    
    /**
     * 제품 코드 (Foreign Key)
     * Standard2 테이블의 item_code를 참조
     */
    private String productCode;
    
    /**
     * 제품명 (Standard2 테이블과 조인하여 가져옴)
     */
    private String productName;
    
    /**
     * 계획 수량
     * 금일 생산할 계획 수량
     */
    private int plannedQty;
    
    /**
     * 실제 수량
     * 실제 생산 완료된 수량
     */
    private Integer actualQty;
    
    /**
     * 금일 생산계획 상태
     * - Production: 계획
     * - work: 작업중
     * - quality: 품질검사중
     * - inventory: 완료
     */
    private String status;
    
    /**
     * 계획 시작일
     * 금일 생산계획의 시작 예정일
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date plannedStartDate;
    
    /**
     * 계획 종료일
     * 금일 생산계획의 완료 예정일
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date plannedEndDate;
    
    /**
     * 실제 시작일
     * 실제 생산 작업이 시작된 날짜
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date actualStartDate;
    
    /**
     * 실제 종료일
     * 실제 생산 작업이 완료된 날짜
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date actualEndDate;
    
    /**
     * 작업자 ID
     * 해당 금일 생산계획을 담당하는 작업자
     */
    private String workerId;
    
    /**
     * 등록일
     * 금일 생산계획이 등록된 날짜
     */
    private Date createdDate;
    
    /**
     * 수정일
     * 금일 생산계획이 마지막으로 수정된 날짜
     */
    private Date updatedDate;
    
    /**
     * 등록자
     * 금일 생산계획을 등록한 사용자
     */
    private String createdBy;
    
    /**
     * 수정자
     * 금일 생산계획을 마지막으로 수정한 사용자
     */
    private String updatedBy;
    
    /**
     * 상태별 한글 표시명
     * Java 1.6 호환을 위해 필드로 처리
     */
    private String statusDisplayName;
    
    /**
     * 완료 여부
     * Java 1.6 호환을 위해 필드로 처리
     */
    private boolean completed;
    
    /**
     * 진행중 여부
     * Java 1.6 호환을 위해 필드로 처리
     */
    private boolean inProgress;
}
