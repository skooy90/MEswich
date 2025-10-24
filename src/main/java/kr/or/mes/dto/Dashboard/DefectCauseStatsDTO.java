package kr.or.mes.dto.Dashboard;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.util.List;

/**
 * 불량 원인별 통계 데이터 전송용 DTO
 * 총 불량 갯수와 3가지 원인별 데이터를 포함
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DefectCauseStatsDTO {
    
    /**
     * 총 불량 갯수 (최근 7일간)
     */
    private int totalDefects;
    
    /**
     * 불량 원인별 데이터 리스트 (설비결함, 포장불량, 모형문제)
     */
    private List<DefectCauseDTO> causeList;
}
