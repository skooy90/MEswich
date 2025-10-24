package kr.or.mes.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class LoginCheckFilter implements Filter {

    // 로그인 없이 접근 가능한 URL (예외 목록)
    private static final List<String> whitelist = Arrays.asList(
        "/mes/auth/login",     // ✅ contextPath 포함
        "/mes/auth/logout",
        "/mes/css/",
        "/mes/js/",
        "/mes/images/"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath(); // ex) /mes

        // 화이트리스트 URL은 필터 통과
        if (uri.equals(contextPath + "/auth/login") ||
            uri.equals(contextPath + "/auth/logout") ||
            uri.startsWith(contextPath + "/css/") ||
            uri.startsWith(contextPath + "/js/") ||
            uri.startsWith(contextPath + "/images/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        // 세션이 없으면 로그인 페이지로 리다이렉트
        if (session == null || session.getAttribute("loginUser") == null) {
            res.sendRedirect(contextPath + "/auth/login");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void destroy() {}
}


