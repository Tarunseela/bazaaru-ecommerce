package com.ecommerce.servlet;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        try {
            User u = dao.findByUsernameAndPassword(username, password);
            if (u != null) {
                if (u.isAdmin()) {
                    req.getSession().setAttribute("admin", u);
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                } else {
                    req.getSession().setAttribute("user", u);
                    resp.sendRedirect(req.getContextPath() + "/products");
                }
            } else {
                req.setAttribute("error", "Invalid credentials.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}