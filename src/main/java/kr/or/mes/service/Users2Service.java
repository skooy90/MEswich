package kr.or.mes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import kr.or.mes.dao.Users2DAO;
import kr.or.mes.dto.Users2DTO;

@Service
public class Users2Service {

    @Autowired
    private Users2DAO dao;

    // BCrypt 인스턴스 (work factor 10; 필요시 숫자 조정 가능)
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

    /** 로그인 처리 (평문 -> 해시 자동 마이그레이션 포함) */
    public Users2DTO login(String userId, String password) {
        Users2DTO user = dao.findById(userId);
        if (user == null || password == null) return null;

        String stored = user.getPassword();
        if (stored == null) return null;

        // 1) 저장된 값이 bcrypt 해시인지 검사
        if (isBcryptHash(stored)) {
            // bcrypt일 경우 matches로 검증
            if (passwordEncoder.matches(password, stored)) {
                return user;
            } else {
                return null;
            }
        } else {
            // bcrypt 해시가 아닌 경우(구 평문 저장 가능)
            // 평문과 동일하면 해시로 마이그레이션 후 로그인 허용
            if (stored.equals(password)) {
                // 마이그레이션: 평문 -> bcrypt 해시로 업데이트
                String hashed = passwordEncoder.encode(password);
                user.setPassword(hashed);
                // DB 업데이트: dao.update는 전체 update를 담당하므로 DTO에 필요한 값이 포함되어야 함
                dao.update(user);
                return user;
            } else {
                return null;
            }
        }
    }

    /** 사용자 전체 조회 (관리자용 목록 페이지) */
    public List<Users2DTO> getAllUsers() {
        return dao.selectAll();
    }

    /** 단일 사용자 조회 */
    public Users2DTO getUserById(String userId) {
        return dao.selectById(userId);
    }

    /** 사용자 등록: 비밀번호는 무조건 해시로 저장 */
    public int insertUser(Users2DTO dto) {
        // 기본 동작: 비밀번호가 비어있으면 userId를 기본 비밀번호로 사용(기존 규칙 유지하되 해시 저장)
        String raw = dto.getPassword();
        if (!StringUtils.hasText(raw)) {
            raw = dto.getUserId();
        }
        String hashed = passwordEncoder.encode(raw);
        dto.setPassword(hashed);
        return dao.insert(dto);
    }

    /** 사용자 수정 */
    public int updateUser(Users2DTO dto) {
        // 주의: 비밀번호를 변경하지 않는 경우 dto.password가 기존 해시로 포함되어 있어야 함
        return dao.update(dto);
    }

    /** 사용자 삭제 */
    public int deleteUser(String userId) {
        return dao.delete(userId);
    }

    /** 신규 사번 자동 생성 */
    public String generateNextUserId() {
        String lastId = dao.getLastUserId(); // 예: "U0005"
        if (lastId == null || lastId.isEmpty()) {
            return "U0001";
        }
        int number = Integer.parseInt(lastId.substring(1));
        String nextId = String.format("U%04d", number + 1);
        return nextId;
    }

    /**
     * 비밀번호 변경
     * - currentPassword: 사용자가 입력한 현재 비밀번호 (평문)
     * - newPassword: 변경할 비밀번호 (평문)
     */
    public boolean changePassword(String userId, String currentPassword, String newPassword) {
        Users2DTO user = dao.findById(userId);
        if (user == null) return false;

        String stored = user.getPassword();
        if (stored == null) return false;

        // 새 비밀번호 유효성(서비스 레벨에서도 다시 체크 가능)
        boolean hasNumber = newPassword.matches(".*[0-9].*");
        boolean hasLetter = newPassword.matches(".*[A-Za-z].*");
        boolean isLongEnough = newPassword.length() >= 8;
        if (!hasNumber || !hasLetter || !isLongEnough) {
            return false;
        }

        // 현재 비밀번호 검증: 저장된 값이 bcrypt면 matches, 아니면 평문비교
        boolean currentMatches;
        if (isBcryptHash(stored)) {
            currentMatches = passwordEncoder.matches(currentPassword, stored);
        } else {
            currentMatches = stored.equals(currentPassword);
        }

        if (!currentMatches) {
            return false;
        }

        // 새 비밀번호 해시화 후 저장
        String newHashed = passwordEncoder.encode(newPassword);
        user.setPassword(newHashed);
        user.setUpdatedBy(userId); // 업데이트한 사용자 정보 기록 (테이블 칼럼 존재 시)
        dao.update(user);
        return true;
    }

    /** bcrypt 해시인지 단순 판별 */
    private boolean isBcryptHash(String s) {
        if (s == null) return false;
        return s.startsWith("$2a$") || s.startsWith("$2b$") || s.startsWith("$2y$");
    }
}

