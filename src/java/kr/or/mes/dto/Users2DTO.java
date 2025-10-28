package kr.or.mes.dto;

import java.util.Date;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Users2DTO {
    private String userId;              // 사용자 ID
    private String userName;            // 이름
    private String password;            // 비밀번호
    private String department;          // 부서
    private String role;                // 역할
    private String status;              // 상태 (ACTIVE, INACTIVE, LOCKED)
    private Date lastLogin;             // 마지막 로그인
    private Date passwordChangeDate;    // 비밀번호 변경일
    private Date createdDate;           // 생성일
    private Date updatedDate;           // 수정일
    private String createdBy;           // 생성자
    private String updatedBy;           // 수정자
}
