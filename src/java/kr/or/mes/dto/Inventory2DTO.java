package kr.or.mes.dto;

import java.util.Date;
import lombok.Data;

@Data  // Getter/Setter, toString, equals, hashCode 자동 생성
public class Inventory2DTO {
    private int inventoryId;     // 재고 ID (기본키)
    private String itemCode;     // 품목 코드 (FK)
    private String lotNumber;    // LOT 번호
    private int currentQty;      // 현재 수량
    private String location;     // 재고 등록 확인
    private Date lastUpdated;    // 마지막 수정일
    private Date createdDate;    // 생성일
    private String createdBy;    // 생성자
    private String updatedBy;    // 수정자
    private String dailyLotNumber;    // daily_LOT 번호
    
 // JOIN을 위한 추가 필드
    private String productName;       // 제품명
}

