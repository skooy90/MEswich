package kr.or.mes.dao.WorkOrders;

import java.util.List;
import kr.or.mes.dto.WorkOrders2DTO;

/**
 * 작업지시서 DAO 인터페이스
 * WorkOrdersMapper.xml의 메서드들과 매칭되는 데이터 접근 메서드 정의
 */
public interface WorkOrderDAO {
    
    /**
     * 조건별 작업지시서 조회
     * @param dto 검색 조건이 포함된 WorkOrders2DTO
     * @return 조건에 맞는 작업지시서 목록
     */
    List<WorkOrders2DTO> selectWorkOrdersByCondition(WorkOrders2DTO dto);
    
    /**
     * 작업지시번호로 단건 조회
     * @param workOrderNo 작업지시번호
     * @return 해당 작업지시서 정보
     */
    WorkOrders2DTO selectWorkOrderByNo(String workOrderNo);
    
    /**
     * 작업지시서 등록
     * @param workOrder 등록할 작업지시서 정보
     * @return 등록된 행 수
     */
    int insertWorkOrder(WorkOrders2DTO workOrder);
    
    /**
     * 작업지시서 수정
     * @param workOrder 수정할 작업지시서 정보
     * @return 수정된 행 수
     */
    int updateWorkOrder(WorkOrders2DTO workOrder);
    
    /**
     * 작업지시서 상태 업데이트
     * @param workOrder 상태 업데이트할 작업지시서 정보
     * @return 업데이트된 행 수
     */
    int updateWorkOrderStatus(WorkOrders2DTO workOrder);
    
    /**
     * 작업지시서 삭제
     * @param workOrderNo 삭제할 작업지시번호
     * @return 삭제된 행 수
     */
    int deleteWorkOrder(String workOrderNo);
}
