package com.ecommerce.servlet;

import com.ecommerce.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private List<CartItem> getTypedCart(HttpSession session) {
        Object obj = session.getAttribute("cart");
        List<CartItem> typed = new ArrayList<>();
        if (obj instanceof List) {
            for (Object o : (List) obj) {
                if (o instanceof CartItem) {
                    typed.add((CartItem) o);
                }
            }
            // store typed list back to session
            session.setAttribute("cart", typed);
        }
        return typed;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }
        List<CartItem> cart = getTypedCart(session);
        if (cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double total = 0;
        for (CartItem ci : cart) total += ci.getTotalPrice();

        // TODO: persist order in DB in production
        cart.clear();
        session.setAttribute("cart", cart);

        req.setAttribute("total", total);
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }
}