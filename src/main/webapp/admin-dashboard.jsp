<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.dao.ProductDAO, com.ecommerce.model.Product, java.util.List" %>
<%
    Object adminObj = session.getAttribute("admin");
    if (adminObj == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
    ProductDAO dao = new ProductDAO();
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                Product p = new Product();
                p.setName(request.getParameter("name"));
                p.setDescription(request.getParameter("description"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setImageUrl(request.getParameter("imageUrl"));
                p.setStock(Integer.parseInt(request.getParameter("stock")));
                dao.addProduct(p);
                message = "✅ Product added successfully.";
            } else if ("remove".equals(action)) {
                int id = Integer.parseInt(request.getParameter("removeId"));
                dao.removeProduct(id);
                message = "🗑️ Product removed successfully.";
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    List<Product> products = dao.findAll();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Admin Dashboard</title>
    <style>
        /* ====== Reset ====== */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', 'Inter', sans-serif;
            background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
            color: #fff;
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* ====== Sidebar ====== */
        aside {
            width: 230px;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(10px);
            border-right: 1px solid rgba(255,255,255,0.15);
            padding: 2rem 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        aside h2 {
            color: #00e6b8;
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }

        aside a, aside form button {
            display: block;
            background: transparent;
            color: #fff;
            text-decoration: none;
            border: none;
            font-weight: 500;
            padding: 0.8rem 1rem;
            margin-bottom: 0.6rem;
            border-radius: 8px;
            transition: background 0.3s;
            cursor: pointer;
        }

        aside a:hover, aside form button:hover {
            background: rgba(255,255,255,0.15);
        }

        /* ====== Main Area ====== */
        main {
            flex: 1;
            padding: 2rem 3rem;
            overflow-y: auto;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        header h1 {
            font-size: 2rem;
            color: #00e6b8;
        }

        header a {
            color: #fff;
            text-decoration: none;
            background: linear-gradient(135deg, #00b09b, #96c93d);
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        header a:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0,255,200,0.6);
        }

        /* ====== Form ====== */
        .form-card {
            background: rgba(255,255,255,0.08);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
        }

        h2 {
            margin-bottom: 1rem;
            color: #a8e6ff;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        form label {
            display: flex;
            flex-direction: column;
            font-size: 0.9rem;
            color: #ddd;
        }

        input {
            padding: 0.7rem;
            margin-top: 0.4rem;
            border-radius: 8px;
            border: none;
            outline: none;
            background: rgba(255,255,255,0.1);
            color: #fff;
        }

        button {
            grid-column: span 2;
            margin-top: 0.5rem;
            background: linear-gradient(135deg, #00b09b, #96c93d);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: 600;
            padding: 0.8rem;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0,255,200,0.6);
        }

        /* ====== Message ====== */
        .message {
            color: #00e676;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        /* ====== Table ====== */
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.08);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
        }

        th, td {
            padding: 0.8rem;
            text-align: center;
        }

        th {
            background: rgba(255,255,255,0.1);
            color: #00e6b8;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background: rgba(255,255,255,0.05);
        }

        td form {
            display: inline;
        }

        td button {
            background: #ff5252;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            cursor: pointer;
            color: #fff;
            font-weight: 600;
            transition: background 0.3s;
        }

        td button:hover {
            background: #ff1744;
        }

        /* ====== Scrollbar ====== */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-thumb {
            background: rgba(255,255,255,0.2);
            border-radius: 10px;
        }

        /* ====== Responsive ====== */
        @media (max-width: 768px) {
            aside { display: none; }
            form { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

    <aside>
        <h2>Bazaaru</h2>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="index.jsp">View Store</a>
        <form action="admin-logout.jsp" method="post">
            <button type="submit">Logout</button>
        </form>
    </aside>

    <main>
        <header>
            <h1>Admin Dashboard</h1>
            <a href="index.jsp">Go to Store</a>
        </header>

        <% if (!message.isEmpty()) { %>
            <p class="message"><%= message %></p>
        <% } %>

        <section class="form-card">
            <h2>Add Product</h2>
            <form method="post" action="admin-dashboard.jsp">
                <input type="hidden" name="action" value="add">
                <label>Name: <input type="text" name="name" required></label>
                <label>Description: <input type="text" name="description" required></label>
                <label>Price: <input type="number" step="0.01" name="price" required></label>
                <label>Image URL: <input type="text" name="imageUrl"></label>
                <label>Stock: <input type="number" name="stock" value="10" required></label>
                <button type="submit">Add Product</button>
            </form>
        </section>

        <section>
            <h2>Existing Products</h2>
            <table>
                <tr>
                    <th>ID</th><th>Name</th><th>Price</th><th>Stock</th><th>Action</th>
                </tr>
                <% for (Product p : products) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getName() %></td>
                        <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                        <td><%= p.getStock() %></td>
                        <td>
                            <form method="post" action="admin-dashboard.jsp">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="removeId" value="<%= p.getId() %>">
                                <button type="submit">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
        </section>
    </main>

</body>
</html>
