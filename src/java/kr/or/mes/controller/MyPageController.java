package kr.or.mes.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.mes.dto.Users2DTO;
import kr.or.mes.service.Users2Service;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    private Users2Service userService;

    /** ✅ 마이페이지 화면 */
    @GetMapping
    public String myPage(HttpSession session, Model model) {
        Users2DTO loginUser = (Users2DTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login";
        }

        Users2DTO user = userService.getUserById(loginUser.getUserId());
        model.addAttribute("user", user);
        return "/mypage/mypage";
    }

    /** ✅ 비밀번호 변경 폼 */
    @GetMapping("/changePasswordForm")
    public String changePasswordForm(HttpSession session, Model model) {
        Users2DTO loginUser = (Users2DTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("userId", loginUser.getUserId());
        return "/mypage/change_password";
    }

    /** ✅ 비밀번호 변경 처리 */
    @PostMapping("/changePassword")
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 HttpSession session,
                                 Model model) {
        Users2DTO loginUser = (Users2DTO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login";
        }

        boolean result = userService.changePassword(loginUser.getUserId(), currentPassword, newPassword);
        if (result) {
            model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        } else {
            model.addAttribute("message", "현재 비밀번호가 일치하지 않습니다.");
        }

        // 변경 후 다시 마이페이지로 리디렉트
        model.addAttribute("user", userService.getUserById(loginUser.getUserId()));
        return "/mypage/change_password_result";
    }
}
