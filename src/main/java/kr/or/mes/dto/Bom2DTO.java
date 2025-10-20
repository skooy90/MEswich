package kr.or.mes.dto;

import java.util.Date;
import java.util.List;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Bom2DTO {
    private int bomId;              // BOM ID
    private String productCode;     // 완제품 코드
    private String materialCode;    // 원자재 코드
    private double quantity;        // 수량
    private String unit; 			// 단위
    private Date createdDate;       // 등록일
    private Date updatedDate;       // 수정일
    private String createdBy;       // 등록자
    private String updatedBy;       // 수정자
    private String productName;   // 완제품 이름
    private String materialName;  // 원자재 이름
    private List<Bom2DTO> materialList;
}
