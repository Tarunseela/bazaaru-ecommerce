package com.ecommerce.filter;

import com.ecommerce.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/checkout"})
public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        HttpSession session = req.getSession(false);
        if (uri.startsWith(req.getContextPath() + "/admin")) {
            if (session != null && session.getAttribute("admin") != null) {
                chain.doFilter(request, response);
                return;
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin-login");
                return;
            }
        } else if (uri.equals(req.getContextPath() + "/checkout")) {
            if (session != null && (session.getAttribute("user") != null || session.getAttribute("admin") != null)) {
                chain.doFilter(request, response);
                return;
            } else {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}