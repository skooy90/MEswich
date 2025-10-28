package kr.or.mes.service.Inventory2;

import java.util.List;
import kr.or.mes.dto.Inventory2DTO;

/**
 * 재고관리 Service 인터페이스
 * 재고관리의 비즈니스 로직 처리 및 유효성 검사 담당
 */
public interface Inventory2Service {
    
    /**
     * 전체재고현황 조회
     * @param dto 검색 조건이 포함된 Inventory2DTO
     * @return 조건에 맞는 재고 목록
     */
    List<Inventory2DTO> selectAllInventory(Inventory2DTO dto);
    
    /**
     * 재고 상세 조회
     * @param inventoryId 재고 ID
     * @return 해당 재고 정보
     */
    Inventory2DTO selectInventoryById(int inventoryId);
    
    /**
     * 조건별 재고 검색
     * @param dto 검색 조건이 포함된 Inventory2DTO
     * @return 조건에 맞는 재고 목록
     */
    List<Inventory2DTO> selectInventoryByCondition(Inventory2DTO dto);
    
    /**
     * 재고 등록
     * @param dto 등록할 재고 정보
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String insertInventory(Inventory2DTO dto);
    
    /**
     * 품질검사에서 재고 등록
     * @param inspectionNo 검사번호
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String registerFromQuality(String inspectionNo);
    
    /**
     * 일괄 재고 등록 (품질검사에서)
     * @param inspectionNos 검사번호 목록
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String batchRegisterFromQuality(List<String> inspectionNos);
    
    /**
     * 재고 수정
     * @param dto 수정할 재고 정보
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String updateInventory(Inventory2DTO dto);
    
    /**
     * 재고 삭제
     * @param inventoryId 삭제할 재고 ID
     * @return 성공 시 "SUCCESS", 실패 시 에러 메시지
     */
    String deleteInventory(int inventoryId);
}
