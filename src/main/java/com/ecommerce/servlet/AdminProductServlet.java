package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminProductServlet extends HttpServlet {
    private ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Product> products = dao.findAll();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/admin-dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                Product p = new Product();
                p.setName(req.getParameter("name"));
                p.setDescription(req.getParameter("description"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setImageUrl(req.getParameter("imageUrl"));
                p.setStock(Integer.parseInt(req.getParameter("stock")));
                dao.addProduct(p);
            } else if ("remove".equals(action)) {
                int id = Integer.parseInt(req.getParameter("removeId"));
                dao.removeProduct(id);
            }
            // POST-Redirect-GET
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}