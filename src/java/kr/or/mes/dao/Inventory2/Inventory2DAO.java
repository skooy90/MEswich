package kr.or.mes.dao.Inventory2;

import java.util.List;
import kr.or.mes.dto.Inventory2DTO;

/**
 * 재고관리 DAO 인터페이스
 * Inventory2Mapper.xml의 메서드들과 매칭되는 데이터 접근 메서드 정의
 */
public interface Inventory2DAO {
    
    /**
     * 전체재고현황 조회 (품목명 포함)
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
     * @return 등록된 행 수
     */
    int insertInventory(Inventory2DTO dto);
    
    /**
     * 재고 중복 체크 (LOT번호 기준)
     * @param lotNumber LOT번호
     * @return 기존 재고 정보 (없으면 null)
     */
    Inventory2DTO selectInventoryByLot(String lotNumber);
    
    /**
     * 재고 수량 업데이트
     * @param dto 수량 업데이트할 재고 정보
     * @return 업데이트된 행 수
     */
    int updateInventoryQty(Inventory2DTO dto);
    
    /**
     * 재고 수정
     * @param dto 수정할 재고 정보
     * @return 수정된 행 수
     */
    int updateInventory(Inventory2DTO dto);
    
    /**
     * 재고 삭제
     * @param inventoryId 삭제할 재고 ID
     * @return 삭제된 행 수
     */
    int deleteInventory(int inventoryId);
}
