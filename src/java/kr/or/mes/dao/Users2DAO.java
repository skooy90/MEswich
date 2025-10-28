package kr.or.mes.dao;

import java.util.List;
import kr.or.mes.dto.Users2DTO;

public interface Users2DAO {

    /** 로그인 시 사용자 조회 */
    Users2DTO findById(String userId);

    /** 사용자 전체 조회 */
    List<Users2DTO> selectAll();

    /** 단일 사용자 조회 */
    Users2DTO selectById(String userId);

    /** 신규 사용자 등록 */
    int insert(Users2DTO dto);

    /** 사용자 정보 수정 */
    int update(Users2DTO dto);

    /** 사용자 삭제 */
    int delete(String userId);
    
    String getLastUserId();
    



}