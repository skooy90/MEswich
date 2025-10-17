package kr.or.mes.service.WorkOrders;

import java.util.List;
import kr.or.mes.dto.WorkOrders2DTO;

/**
 * 작업지시서 Service 인터페이스
 * 비즈니스 로직을 정의하는 서비스 계층
 */
public interface WorkOrdersService {
    
	
	// 작업지시서 자동 생성
	String createWorkOrderFromProduction(String lotNumber);
	
    /**
     * 전체 작업지시서 조회 (JSP에서 필터링용)
     */
    List<WorkOrders2DTO> selectAllWorkOrders();
    
    /**
     * 조건별 작업지시서 조회
     */
    List<WorkOrders2DTO> selectWorkOrdersByCondition(WorkOrders2DTO dto);
    
    /**
     * 작업지시번호로 단건 조회
     */
    WorkOrders2DTO selectWorkOrderByNo(String workOrderNo);
    
    /**
     * 작업지시서 수정
     */
    String updateWorkOrder(WorkOrders2DTO workOrder);
    
    /**
     * 작업지시서 상태 업데이트
     */
    String updateWorkOrderStatus(WorkOrders2DTO workOrder);
    
    /**
     * 작업지시서 삭제
     */
    String deleteWorkOrder(String workOrderNo);
    
    /**
     * 작업지시서 상세 조회 (수정용)
     */
    WorkOrders2DTO getWorkOrderForEdit(String workOrderNo);
    
    /**
     * 작업지시서 상세 조회 (조회용)
     */
    WorkOrders2DTO getWorkOrderDetail(String workOrderNo);
    
    /**
     * 상태별 작업지시서 조회
     * @param status 작업 상태 (READY, IN_PROGRESS, DONE)
     * @return 해당 상태의 작업지시서 목록
     */
    List<WorkOrders2DTO> selectWorkOrdersByStatus(String status);
    
    /**
     * 생산량 업데이트
     * @param workOrderNo 작업지시번호
     * @param actualQty 실제 생산량
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String updateProductionQuantity(String workOrderNo, int actualQty);
    
    /**
     * 작업 완료 처리
     * @param workOrderNo 작업지시번호
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String completeWork(String workOrderNo);
    
    /**
     * 품질관리로 전달
     * @param workOrderNo 작업지시번호
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String transferToQuality(String workOrderNo);
    
    /**
     * 작업자 배정
     * @param workOrderNo 작업지시번호
     * @param workerId 작업자ID
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String assignWorker(String workOrderNo, String workerId);
    
    /**
     * 작업 시작 (READY → IN_PROGRESS)
     * @param workOrderNo 작업지시번호
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String startWork(String workOrderNo);
}
