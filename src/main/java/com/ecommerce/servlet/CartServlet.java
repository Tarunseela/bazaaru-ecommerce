package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private final ProductDAO pdao = new ProductDAO();

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // forward to view-only JSP
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(true);
        try {
            if ("add".equals(action)) {
                String sid = req.getParameter("productId");
                String sqty = req.getParameter("qty");
                if (sid != null) {
                    int productId = Integer.parseInt(sid);
                    int qty = 1;
                    if (sqty != null) {
                        try { qty = Math.max(1, Integer.parseInt(sqty)); } catch (NumberFormatException ignored) {}
                    }
                    Product p = pdao.findById(productId);
                    if (p != null) {
                        List<CartItem> cart = getCart(session);
                        boolean found = false;
                        for (CartItem ci : cart) {
                            if (ci.getProduct().getId() == p.getId()) {
                                ci.setQuantity(ci.getQuantity() + qty);
                                found = true;
                                break;
                            }
                        }
                        if (!found) cart.add(new CartItem(p, qty));
                    }
                }
            } else if ("remove".equals(action)) {
                String sid = req.getParameter("productId");
                if (sid != null) {
                    int productId = Integer.parseInt(sid);
                    List<CartItem> cart = getCart(session);
                    cart.removeIf(ci -> ci.getProduct().getId() == productId);
                }
            } else if ("update".equals(action)) {
                String sid = req.getParameter("productId");
                String sqty = req.getParameter("qty");
                if (sid != null && sqty != null) {
                    int productId = Integer.parseInt(sid);
                    int qty;
                    try { qty = Math.max(1, Integer.parseInt(sqty)); } catch (NumberFormatException nfe) { qty = 1; }
                    List<CartItem> cart = getCart(session);
                    for (CartItem ci : cart) {
                        if (ci.getProduct().getId() == productId) {
                            ci.setQuantity(qty);
                            break;
                        }
                    }
                }
            } else if ("clear".equals(action)) {
                List<CartItem> cart = getCart(session);
                cart.clear();
            }
            // PRG pattern
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}