package kr.or.mes.service.Production;

import java.util.List;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

/**
 * 생산관리 Service 인터페이스
 * 생산 LOT 관리 비즈니스 로직을 담당
 */
public interface Production2Service {
	
	/**
	 * 모든 생산 LOT 조회
	 * @return 생산 LOT 목록
	 */
	public List<Production2DTO> selectAll();
	
	/**
	 * 조건에 따른 생산 LOT 검색
	 * @param dto 검색 조건이 담긴 DTO
	 * @return 검색된 생산 LOT 목록
	 */
	public List<Production2DTO> selectByCondition(Production2DTO dto);
	
	/**
	 * LOT번호로 생산 LOT 단건 조회
	 * @param lotNumber LOT번호
	 * @return 생산 LOT 정보
	 */
	public Production2DTO selectByLotNumber(String lotNumber);
	
	/**
	 * 새로운 생산 LOT 등록
	 * @param production 등록할 생산 LOT 정보
	 * @return 등록 결과 (1: 성공, 0: 실패)
	 */
	public int insert(Production2DTO production);
	
	/**
	 * 생산 LOT 등록 처리 (비즈니스 로직 포함)
	 * @param production 등록할 생산 LOT 정보
	 * @return 등록 결과 메시지
	 */
	public String createProduction(Production2DTO production);
	
	/**
	 * 생산 LOT 정보 수정
	 * @param production 수정할 생산 LOT 정보
	 * @return 수정 결과 (1: 성공, 0: 실패)
	 */
	public int update(Production2DTO production);
	
	/**
	 * 생산 LOT 수정 처리 (비즈니스 로직 포함)
	 * @param production 수정할 생산 LOT 정보
	 * @return 수정 결과 메시지
	 */
	public String updateProduction(Production2DTO production);
	
	/**
	 * 생산 LOT 삭제
	 * @param lotNumber 삭제할 LOT번호
	 * @return 삭제 결과 메시지
	 */
	public String deleteProduction(String lotNumber);
	
	/**
	 * 생산 LOT 상태 업데이트
	 * @param production 상태 업데이트할 생산 LOT 정보
	 * @return 업데이트 결과 (1: 성공, 0: 실패)
	 */
	public int updateStatus(Production2DTO production);
	
	/**
	 * 생산 LOT 실제 수량 업데이트
	 * @param production 실제 수량 업데이트할 생산 LOT 정보
	 * @return 업데이트 결과 (1: 성공, 0: 실패)
	 */
	public int updateActualQuantity(Production2DTO production);
	
	/**
	 * 완제품 목록 조회 (생산계획 등록용)
	 * @return 완제품 목록
	 */
	public List<Standard2DTO> selectFinishedGoods();
	
	/**
	 * 상태별 생산 LOT 조회
	 * @param status 조회할 상태
	 * @return 해당 상태의 생산 LOT 목록
	 */
	public List<Production2DTO> selectByStatus(String status);
	
	/**
	 * 생산 LOT 상세 조회 (비즈니스 로직 포함)
	 * @param lotNumber LOT번호
	 * @return 생산 LOT 정보 또는 null
	 */
	public Production2DTO getProductionDetail(String lotNumber);
	
	/**
	 * 생산 LOT 수정 폼 데이터 조회 (비즈니스 로직 포함)
	 * @param lotNumber LOT번호
	 * @return 생산 LOT 정보 또는 null
	 */
	public Production2DTO getProductionForEdit(String lotNumber);
}
