package kr.or.mes.dao.production;

import java.util.List;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

public interface Production2DAO {
	
	//	모든 생산 LOT 조회
	public List<Production2DTO> selectAll();
	//	조건에 따른 생산 LOT 검색
	public List<Production2DTO> selectByCondition(Production2DTO dto);
	//	LOT번호로 생산 LOT 단건 조회	
	public Production2DTO selectByLotNumber(String lotNumber);
//	새로운 생산 LOT 등록
	public int insert(Production2DTO production);
//	생산 LOT 정보 수정
	public int update(Production2DTO production);
//	생산 LOT 삭제
	public int delete(String lotNumber);
//	LOT번호로 생산 LOT 삭제
	public int deleteByLotNumber(String lotNumber);
//	생산 LOT 상태 업데이트
	public int updateStatus(Production2DTO production);
//	생산 LOT 실제 수량 업데이트
	public int updateActualQuantity(Production2DTO production);
//	완제품 목록 조회 (생산계획 등록용)
	public List<Standard2DTO> selectFinishedGoods();
//	상태별 생산 LOT 조회
	public List<Production2DTO> selectByStatus(String status);
	
}
