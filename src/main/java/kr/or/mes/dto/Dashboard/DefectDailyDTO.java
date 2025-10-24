package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

/**
 * 일별 불량 데이터 전송용 DTO
 * 날짜(MM.dd 형식)와 해당 날짜의 불량 갯수를 포함
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DefectDailyDTO {
    
    /**
     * 날짜 문자열 (MM.dd 형식)
     * 예: "01.15", "01.16"
     */
    private String dateStr;
    
    /**
     * 해당 날짜의 불량 갯수
     */
    private int defectCount;
}
