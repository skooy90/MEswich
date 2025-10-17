package kr.or.mes.service.WorkOrders;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.WorkOrders.WorkOrderDAO;
import kr.or.mes.dto.WorkOrders2DTO;

/**
 * 작업지시서 Service 구현체
 * 비즈니스 로직 처리 및 유효성 검사 담당
 */
@Service
public class WorkOrdersServiceImpl implements WorkOrdersService {
    
    @Autowired
    private WorkOrderDAO workOrdersDAO;

    
    // 작업지시서 자동 생성
    @Override
    public String createWorkOrderFromProduction(String lotNumber) {
        WorkOrders2DTO workOrder = new WorkOrders2DTO();
        workOrder.setLotNumber(lotNumber);
        workOrder.setStatus("READY");
        
        int result = workOrdersDAO.insertWorkOrderFromProduction(workOrder);
        return result > 0 ? "SUCCESS" : "작업지시서 생성에 실패했습니다.";
    }
    
	/**
	 * 조건별 작업지시서 조회
	 * @param dto 검색 조건이 포함된 WorkOrders2DTO
	 * @return 조건에 맞는 작업지시서 목록
	 */
	@Override
	public List<WorkOrders2DTO> selectWorkOrdersByCondition(WorkOrders2DTO dto) {
		return workOrdersDAO.selectWorkOrdersByCondition(dto);
	}

	/**
	 * 작업지시번호로 단건 조회
	 * @param workOrderNo 작업지시번호
	 * @return 해당 작업지시서 정보
	 */
	@Override
	public WorkOrders2DTO selectWorkOrderByNo(String workOrderNo) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return null;
		}
		return workOrdersDAO.selectWorkOrderByNo(workOrderNo);
	}


	/**
	 * 작업지시서 수정
	 * @param workOrder 수정할 작업지시서 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String updateWorkOrder(WorkOrders2DTO workOrder) {
		if (workOrder == null || workOrder.getWorkOrderNo() == null) {
			return "작업지시서 정보가 필요합니다.";
		}
		
		int result = workOrdersDAO.updateWorkOrder(workOrder);
		return result > 0 ? "SUCCESS" : "작업지시서 수정에 실패했습니다.";
	}

	/**
	 * 작업지시서 상태 업데이트
	 * @param workOrder 상태 업데이트할 작업지시서 정보
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String updateWorkOrderStatus(WorkOrders2DTO workOrder) {
		if (workOrder == null || workOrder.getWorkOrderNo() == null) {
			return "작업지시서 정보가 필요합니다.";
		}
		
		int result = workOrdersDAO.updateWorkOrderStatus(workOrder);
		return result > 0 ? "SUCCESS" : "작업지시서 상태 업데이트에 실패했습니다.";
	}

	/**
	 * 작업지시서 삭제
	 * @param workOrderNo 삭제할 작업지시번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String deleteWorkOrder(String workOrderNo) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		int result = workOrdersDAO.deleteWorkOrder(workOrderNo);
		return result > 0 ? "SUCCESS" : "작업지시서 삭제에 실패했습니다.";
	}

	/**
	 * 작업지시서 상세 조회 (수정용)
	 * @param workOrderNo 작업지시번호
	 * @return 작업지시서 상세 정보
	 */
	@Override
	public WorkOrders2DTO getWorkOrderForEdit(String workOrderNo) {
		return selectWorkOrderByNo(workOrderNo);
	}

	/**
	 * 작업지시서 상세 조회 (조회용)
	 * @param workOrderNo 작업지시번호
	 * @return 작업지시서 상세 정보
	 */
	@Override
	public WorkOrders2DTO getWorkOrderDetail(String workOrderNo) {
		return selectWorkOrderByNo(workOrderNo);
	}

	/**
	 * 상태별 작업지시서 조회
	 * @param status 작업 상태 (READY, IN_PROGRESS, DONE)
	 * @return 해당 상태의 작업지시서 목록
	 */
	@Override
	public List<WorkOrders2DTO> selectWorkOrdersByStatus(String status) {
		if (status == null || status.trim().isEmpty()) {
			return null;
		}
		
		WorkOrders2DTO dto = new WorkOrders2DTO();
		dto.setStatus(status);
		return workOrdersDAO.selectWorkOrdersByCondition(dto);
	}

	/**
	 * 전체 작업지시서 조회 (JSP에서 필터링용)
	 * @return 모든 작업지시서 목록
	 */
	@Override
	public List<WorkOrders2DTO> selectAllWorkOrders() {
		// 빈 DTO로 전체 조회
		WorkOrders2DTO dto = new WorkOrders2DTO();
		return workOrdersDAO.selectWorkOrdersByCondition(dto);
	}

	/**
	 * 생산계획에서 작업지시서 생성
	 * @param lotNumber LOT번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */

	/**
	 * 생산량 업데이트
	 * @param workOrderNo 작업지시번호
	 * @param actualQty 실제 생산량
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String updateProductionQuantity(String workOrderNo, int actualQty) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		if (actualQty < 0) {
			return "생산량은 0 이상이어야 합니다.";
		}
		
		WorkOrders2DTO workOrder = new WorkOrders2DTO();
		workOrder.setWorkOrderNo(workOrderNo);
		workOrder.setActualQty(actualQty);
		
		int result = workOrdersDAO.updateWorkOrder(workOrder);
		return result > 0 ? "SUCCESS" : "생산량 업데이트에 실패했습니다.";
	}

	/**
	 * 작업 완료 처리
	 * @param workOrderNo 작업지시번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String completeWork(String workOrderNo) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		WorkOrders2DTO workOrder = new WorkOrders2DTO();
		workOrder.setWorkOrderNo(workOrderNo);
		workOrder.setStatus("DONE");
		
		int result = workOrdersDAO.updateWorkOrderStatus(workOrder);
		return result > 0 ? "SUCCESS" : "작업 완료 처리에 실패했습니다.";
	}

	/**
	 * 품질관리로 전달
	 * @param workOrderNo 작업지시번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String transferToQuality(String workOrderNo) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		// 품질관리로 전달 로직 (추후 품질관리 모듈과 연동)
		return "SUCCESS";
	}

	/**
	 * 작업자 배정
	 * @param workOrderNo 작업지시번호
	 * @param workerId 작업자ID
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String assignWorker(String workOrderNo, String workerId) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		if (workerId == null || workerId.trim().isEmpty()) {
			return "작업자ID가 필요합니다.";
		}
		
		WorkOrders2DTO workOrder = new WorkOrders2DTO();
		workOrder.setWorkOrderNo(workOrderNo);
		workOrder.setWorkerId(workerId);
		
		int result = workOrdersDAO.updateWorkOrder(workOrder);
		return result > 0 ? "SUCCESS" : "작업자 배정에 실패했습니다.";
	}

	/**
	 * 작업 시작 (READY → IN_PROGRESS)
	 * @param workOrderNo 작업지시번호
	 * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
	 */
	@Override
	public String startWork(String workOrderNo) {
		if (workOrderNo == null || workOrderNo.trim().isEmpty()) {
			return "작업지시번호가 필요합니다.";
		}
		
		WorkOrders2DTO workOrder = new WorkOrders2DTO();
		workOrder.setWorkOrderNo(workOrderNo);
		workOrder.setStatus("IN_PROGRESS");
		
		int result = workOrdersDAO.updateWorkOrderStatus(workOrder);
		return result > 0 ? "SUCCESS" : "작업 시작 처리에 실패했습니다.";
	}
    
    }
