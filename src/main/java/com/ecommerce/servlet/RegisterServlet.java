package com.ecommerce.servlet;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (username == null || username.isEmpty() || email == null || password == null || password.isEmpty()) {
            req.setAttribute("message", "Please fill all fields.");
            req.getRequestDispatcher("/WEB-INF/register.jsp").forward(req, resp);
            return;
        }

        try {
            if (dao.findByUsername(username) != null) {
                req.setAttribute("message", "Username already exists.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }
            User u = new User();
            u.setUsername(username);
            u.setPassword(password); // hash in production
            u.setEmail(email);
            u.setAdmin(false);
            dao.createUser(u);
            resp.sendRedirect(req.getContextPath() + "/login?registered=true");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}