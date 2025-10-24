package kr.or.mes.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.mes.dto.Users2DTO;
import kr.or.mes.service.Users2Service;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private Users2Service userService;

    @GetMapping("/login")
    public String loginForm() {
        return "auth/login"; // JSP 파일 경로: /WEB-INF/views/auth/login.jsp
    }

    @PostMapping("/login")
    public String login(@RequestParam("userId") String userId,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {
        Users2DTO user = userService.login(userId, password);
        if (user != null) {
            session.setAttribute("loginUser", user);
            System.out.println("✅ 로그인 성공: " + user.getUserId());
            return "redirect:/standard2/list"; // 로그인 성공 시 첫 페이지
        } else {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "auth/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }
      
}
