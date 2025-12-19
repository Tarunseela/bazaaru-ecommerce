<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.ecommerce.model.CartItem" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) cart = java.util.Collections.emptyList();
    double total = 0;
    for (CartItem ci : cart) total += ci.getTotalPrice();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Your Cart</title>
    <style>
        /* Reset */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', 'Inter', sans-serif;
            background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
            color: #fff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: rgba(0, 0, 0, 0.6);
            padding: 1.5rem 2rem;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        header h1 {
            color: #00e6b8;
            font-size: 2rem;
        }

        main {
            flex: 1;
            padding: 2rem 3rem;
            max-width: 1100px;
            margin: auto;
            animation: fadeIn 1s ease-out;
        }

        p, a {
            font-size: 1rem;
            color: #ccc;
        }

        a {
            color: #00e6b8;
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Cart Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            background: rgba(255,255,255,0.08);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
        }

        th, td {
            padding: 1rem;
            text-align: center;
        }

        th {
            background: rgba(255,255,255,0.15);
            color: #00e6b8;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background: rgba(255,255,255,0.05);
        }

        td {
            font-size: 0.95rem;
            color: #fff;
        }

        /* Buttons */
        button {
            background: linear-gradient(135deg, #00b09b, #96c93d);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: 600;
            padding: 0.6rem 1.2rem;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0,255,200,0.6);
        }

        input[type="number"] {
            width: 60px;
            padding: 0.4rem;
            border-radius: 6px;
            border: none;
            background: rgba(255,255,255,0.1);
            color: #fff;
            text-align: center;
        }

        /* Empty Cart */
        .empty-cart {
            text-align: center;
            margin-top: 4rem;
            font-size: 1.1rem;
        }

        /* Checkout Section */
        .cart-actions {
            margin-top: 2rem;
            text-align: right;
        }

        .cart-actions a button,
        .cart-actions form button {
            margin-left: 1rem;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 1rem;
            background: rgba(0, 0, 0, 0.5);
            color: #aaa;
            border-top: 1px solid rgba(255,255,255,0.2);
            font-size: 0.9rem;
        }

        footer span {
            color: #00e6b8;
            font-weight: 600;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            main { padding: 1rem; }
            th, td { font-size: 0.85rem; padding: 0.6rem; }
            button { padding: 0.5rem 1rem; }
        }
    </style>
</head>
<body>

<header>
    <h1>Your Bazaaru Cart</h1>
</header>

<main>
    <% if (cart.isEmpty()) { %>
        <div class="empty-cart">
            <p>Your cart is empty.</p>
            <p><a href="index.jsp">Continue Shopping</a></p>
        </div>
    <% } else { %>
        <table>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            <% for (CartItem ci : cart) { %>
                <tr>
                    <td><%= ci.getProduct().getName() %></td>
                    <td>₹<%= String.format("%.2f", ci.getProduct().getPrice()) %></td>
                    <td>
                        <form method="post" action="<%= request.getContextPath() %>/cart" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="productId" value="<%= ci.getProduct().getId() %>">
                            <input type="number" name="qty" value="<%= ci.getQuantity() %>" min="1">
                            <button type="submit">Update</button>
                        </form>
                    </td>
                    <td>₹<%= String.format("%.2f", ci.getTotalPrice()) %></td>
                    <td>
                        <form method="post" action="<%= request.getContextPath() %>/cart" style="display:inline;">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productId" value="<%= ci.getProduct().getId() %>">
                            <button type="submit" style="background:#ff5252;">Remove</button>
                        </form>
                    </td>
                </tr>
            <% } %>
            <tr>
                <td colspan="3"><strong>Total:</strong></td>
                <td colspan="2">₹<%= String.format("%.2f", total) %></td>
            </tr>
        </table>

        <div class="cart-actions">
            <a href="<%= request.getContextPath() %>/checkout"><button>Proceed to Checkout</button></a>
            <form method="post" action="<%= request.getContextPath() %>/cart" style="display:inline;">
                <input type="hidden" name="action" value="clear">
                <button type="submit" style="background:#ff5252;">Clear Cart</button>
            </form>
        </div>
    <% } %>
</main>

<footer>
    &copy; 2025 <span>Bazaaru</span> — Empowering Andhra’s Digital Marketplace
</footer>

</body>
</html>
