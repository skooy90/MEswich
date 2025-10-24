package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.util.List;

/**
 * 불량 통계 데이터 전송용 DTO
 * 총 불량 갯수와 일별 불량 데이터를 포함
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DefectStatsDTO {
    
    /**
     * 총 불량 갯수 (최근 7일간)
     */
    private int totalDefects;
    
    /**
     * 일별 불량 데이터 리스트
     */
    private List<DefectDailyDTO> dailyDefects;
}
