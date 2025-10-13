package kr.or.mes.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.mes.dto.Production2DTO;
import kr.or.mes.dto.Standard2DTO;

/**
 * 생산관리 DAO 클래스
 * 생산 LOT의 CRUD 기능을 담당
 */
@Repository
public class Production2DAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    /**
     * 모든 생산 LOT 조회
     * @return 생산 LOT 목록
     */
    public List<Production2DTO> selectAll() {
        return sqlSession.selectList("mes.mappers.Production2Mapper.selectAllProduction");
    }

    /**
     * 조건에 따른 생산 LOT 검색
     * @param searchParams 검색 조건 (LOT번호, 제품코드, 상태)
     * @return 검색된 생산 LOT 목록
     */
    public List<Production2DTO> selectByCondition(Map<String, Object> searchParams) {
        return sqlSession.selectList("mes.mappers.Production2Mapper.selectProductionByCondition", searchParams);
    }

    /**
     * LOT번호로 생산 LOT 단건 조회
     * @param lotNumber LOT번호
     * @return 생산 LOT 정보
     */
    public Production2DTO selectByLotNumber(String lotNumber) {
        return sqlSession.selectOne("mes.mappers.Production2Mapper.selectProductionByLotNumber", lotNumber);
    }

    /**
     * 새로운 생산 LOT 등록
     * @param production 생산 LOT 정보
     * @return 등록된 행 수
     */
    public int insert(Production2DTO production) {
        return sqlSession.insert("mes.mappers.Production2Mapper.insertProduction", production);
    }

    /**
     * 생산 LOT 정보 수정
     * @param production 수정할 생산 LOT 정보
     * @return 수정된 행 수
     */
    public int update(Production2DTO production) {
        return sqlSession.update("mes.mappers.Production2Mapper.updateProduction", production);
    }

    /**
     * 생산 LOT 삭제
     * @param lotNumber 삭제할 LOT번호
     * @return 삭제된 행 수
     */
    public int delete(String lotNumber) {
        return sqlSession.delete("mes.mappers.Production2Mapper.deleteProduction", lotNumber);
    }

    /**
     * 생산 LOT 상태 업데이트
     * @param lotNumber LOT번호
     * @param status 새로운 상태
     * @param updatedBy 수정자
     * @return 업데이트된 행 수
     */
    public int updateStatus(String lotNumber, String status, String updatedBy) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("lotNumber", lotNumber);
        params.put("status", status);
        params.put("updatedBy", updatedBy);
        return sqlSession.update("mes.mappers.Production2Mapper.updateProductionStatus", params);
    }

    /**
     * 생산 LOT 실제 수량 업데이트
     * @param lotNumber LOT번호
     * @param actualQty 실제 수량
     * @param updatedBy 수정자
     * @return 업데이트된 행 수
     */
    public int updateActualQuantity(String lotNumber, Integer actualQty, String updatedBy) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("lotNumber", lotNumber);
        params.put("actualQty", actualQty);
        params.put("updatedBy", updatedBy);
        return sqlSession.update("mes.mappers.Production2Mapper.updateActualQuantity", params);
    }

    /**
     * 완제품 목록 조회 (생산계획 등록용)
     * @return 완제품 목록
     */
    public List<Standard2DTO> selectFinishedGoods() {
        return sqlSession.selectList("mes.mappers.Production2Mapper.selectFinishedGoods");
    }
}
