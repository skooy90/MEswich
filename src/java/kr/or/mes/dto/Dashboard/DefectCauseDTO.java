package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

/**
 * 불량 원인별 데이터 전송용 DTO
 * 설비결함, 포장불량, 모형문제 3가지 원인만 포함
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DefectCauseDTO {
    
    /**
     * 불량 원인명 (설비결함, 포장불량, 모형문제)
     */
    private String causeName;
    
    /**
     * 해당 원인의 불량 갯수
     */
    private int defectCount;
    
    /**
     * 전체 대비 비율 (퍼센트)
     */
    private double percentage;
}
