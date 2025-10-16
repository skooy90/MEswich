package kr.or.mes.dao.WorkOrders;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.mes.dto.WorkOrders2DTO;

/**
 * 작업지시서 DAO 구현체
 * MyBatis SqlSession을 사용하여 WorkOrdersMapper.xml의 쿼리 실행
 */
@Repository
public class WorkOrdersDAOmpl implements WorkOrderDAO {
    
    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 작업지시서 조회
     * @param dto 검색 조건이 포함된 WorkOrders2DTO
     * @return 조건에 맞는 작업지시서 목록
     */
    @Override
    public List<WorkOrders2DTO> selectWorkOrdersByCondition(WorkOrders2DTO dto) {
        return sqlSession.selectList("kr.or.mes.dao.WorkOrders.WorkOrdersDAO.selectWorkOrdersByCondition", dto);
    }
    
    /**
     * 작업지시번호로 단건 조회
     * @param workOrderNo 작업지시번호
     * @return 해당 작업지시서 정보
     */
    @Override
    public WorkOrders2DTO selectWorkOrderByNo(String workOrderNo) {
        return sqlSession.selectOne("kr.or.mes.dao.WorkOrders.WorkOrdersDAO.selectWorkOrderByNo", workOrderNo);
    }
    
    /**
     * 작업지시서 등록
     * @param workOrder 등록할 작업지시서 정보
     * @return 등록된 행 수
     */
    @Override
    public int insertWorkOrder(WorkOrders2DTO workOrder) {
        return sqlSession.insert("kr.or.mes.dao.WorkOrders.WorkOrdersDAO.insertWorkOrder", workOrder);
    }
    
    /**
     * 작업지시서 수정
     * @param workOrder 수정할 작업지시서 정보
     * @return 수정된 행 수
     */
    @Override
    public int updateWorkOrder(WorkOrders2DTO workOrder) {
        return sqlSession.update("kr.or.mes.dao.WorkOrders.WorkOrdersDAO.updateWorkOrder", workOrder);
    }
    
    /**
     * 작업지시서 상태 업데이트
     * @param workOrder 상태 업데이트할 작업지시서 정보
     * @return 업데이트된 행 수
     */
    @Override
    public int updateWorkOrderStatus(WorkOrders2DTO workOrder) {
        return sqlSession.update("kr.or.mes.dao.WorkOrders.WorkOrdersDAO.updateWorkOrderStatus", workOrder);
    }
    
    /**
     * 작업지시서 삭제
     * @param workOrderNo 삭제할 작업지시번호
     * @return 삭제된 행 수
     */
    @Override
    public int deleteWorkOrder(String workOrderNo) {
        return sqlSession.delete("kr.or.mes.dao.WorkOrders.WorkOrdersDAO.deleteWorkOrder", workOrderNo);
    }
}
