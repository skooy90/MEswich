package kr.or.mes.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.mes.dto.Users2DTO;
import kr.or.mes.service.Users2Service;

@Controller
@RequestMapping("/users2")
public class Users2Controller {

    @Autowired
    private Users2Service service;

    // 목록
    @GetMapping("/list")
    public String list(Model model) {
        List<Users2DTO> list = service.getAllUsers();
        model.addAttribute("userList", list);
        return "/users2/Users2_list";
    }

    // 등록 폼
    @GetMapping("/insertForm")
    public String insertForm(Model model) {
        String newUserId = service.generateNextUserId();
        model.addAttribute("newUserId", newUserId);
        return "/users2/Users2_insert";
    }

    // 등록 처리
    @PostMapping("/insert")
    public String insert(@ModelAttribute Users2DTO dto, HttpSession session) {
        Users2DTO loginUser = (Users2DTO) session.getAttribute("loginUser");
        if (loginUser != null) {
            dto.setCreatedBy(loginUser.getUserId());
        }
        service.insertUser(dto);
        return "redirect:/users2/list";
    }

    // 수정 폼
    @GetMapping("/updateForm/{userId}")
    public String updateForm(@PathVariable("userId") String userId, Model model) {
        model.addAttribute("user", service.getUserById(userId));
        return "/users2/Users2_update";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(@ModelAttribute Users2DTO dto, HttpSession session) {
        Users2DTO loginUser = (Users2DTO) session.getAttribute("loginUser");
        if (loginUser != null) {
            dto.setUpdatedBy(loginUser.getUserId());
        }
        service.updateUser(dto);
        // ✅ 수정 완료 메시지 전달
        return "redirect:/users2/list?updated=true";
    }

    // 삭제
    @GetMapping("/delete/{userId}")
    public String delete(@PathVariable("userId") String userId) {
        service.deleteUser(userId);
        return "redirect:/users2/list";
    }
    
    @PostMapping("/changePassword")
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 HttpSession session,
                                 Model model) {
        Users2DTO loginUser = (Users2DTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login";
        }

        // 새 비밀번호 형식 체크
        boolean hasNumber = newPassword.matches(".*[0-9].*");
        boolean hasLetter = newPassword.matches(".*[A-Za-z].*");
        boolean isLongEnough = newPassword.length() >= 8;
        if (!hasNumber || !hasLetter || !isLongEnough) {
            model.addAttribute("message", "❌ 비밀번호는 8자 이상이며 숫자와 영문자를 포함해야 합니다.");
            return "/mypage/change_password_result";
        }

        // 비밀번호 변경 시도
        boolean result = service.changePassword(loginUser.getUserId(), currentPassword, newPassword);
        model.addAttribute("message", result ? "✅ 비밀번호가 성공적으로 변경되었습니다." : "❌ 현재 비밀번호가 일치하지 않습니다.");

        return "/mypage/change_password_result";
    }

}
