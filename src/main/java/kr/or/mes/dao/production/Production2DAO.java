package kr.or.mes.dao.production;

import java.util.List;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

public interface Production2DAO {
	// 전체 생산 계획 조회
	public List<Production2DTO> selectAll();
	//	모든 생산 LOT 조회 (금일 생산 조회에 사용)
	public List<Production2DTO> todoselectAll();
	//	조건에 따른 생산 LOT 검색
	public List<Production2DTO> selectByCondition(Production2DTO dto);
	//	LOT번호로 생산 LOT 단건 조회	
	public Production2DTO selectByLotNumber(String lotNumber);
//	새로운 금일 생산 LOT 등록
	public int insert(Production2DTO production);
//	금일 생산 LOT 정보 수정
	public int update(Production2DTO production);
//	금일 생산 LOT 삭제
	public int delete(String lotNumber);
//	LOT번호로 생산 LOT 삭제
	public int deleteByLotNumber(String lotNumber);
//	금일 생산 LOT 상태 업데이트
	public int updateStatus(Production2DTO production);
//	금일 생산 LOT 실제 수량 업데이트
	public int updateActualQuantity(Production2DTO production);
//	완제품 목록 조회 (생산계획 등록용)
	public List<Standard2DTO> selectFinishedGoods();
//	상태별 생산 LOT 조회
	public List<Production2DTO> selectByStatus(String status);
	
	// ==================== 전체 생산계획 관련 메서드 ====================
	
	/**
	 * 전체 생산계획 조회
	 * @return 전체 생산계획 목록
	 */
	public List<Production2DTO> selectAllProductionPlans();
	
	/**
	 * 전체 생산계획 등록
	 * @param production 등록할 전체 생산계획 정보
	 * @return 등록 결과 (1: 성공, 0: 실패)
	 */
	public int insertAllProduction(Production2DTO production);
	
	// ==================== 금일 생산계획 관련 메서드 ====================
	
	/**
	 * 금일 생산계획 조회
	 * @return 금일 생산계획 목록
	 */
	public List<Production2DTO> selectDailyProductionPlans();
	
	/**
	 * 금일 생산계획 조건별 검색
	 * @param dto 검색 조건이 담긴 DTO
	 * @return 검색된 금일 생산계획 목록
	 */
	public List<Production2DTO> selectDailyProductionByCondition(Production2DTO dto);
	
	/**
	 * 금일 생산계획 등록
	 * @param production 등록할 금일 생산계획 정보
	 * @return 등록 결과 (1: 성공, 0: 실패)
	 */
	public int insertDailyProduction(Production2DTO production);
	
	/**
	 * 전체 생산계획에서 금일 생산계획 생성용 데이터 조회
	 * @param lotNumber LOT번호
	 * @return 전체 생산계획 정보
	 */
	public Production2DTO selectProductionForDailySchedule(String lotNumber);
	
	/**
	 * 금일 생산계획 상태 업데이트
	 * @param production 상태 업데이트할 금일 생산계획 정보
	 * @return 업데이트 결과 (1: 성공, 0: 실패)
	 */
	public int updateDailyProductionStatus(Production2DTO production);
	
}
