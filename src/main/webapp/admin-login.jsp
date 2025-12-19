<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.dao.UserDAO, com.ecommerce.model.User" %>
<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            UserDAO dao = new UserDAO();
            User u = dao.findByUsernameAndPassword(username, password);
            if (u != null && u.isAdmin()) {
                session.setAttribute("admin", u);
                response.sendRedirect("admin-dashboard.jsp");
                return;
            } else {
                error = "Invalid admin credentials.";
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Admin Login</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', 'Inter', sans-serif;
            background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.55);
            backdrop-filter: blur(8px);
            z-index: -1;
        }

        .admin-container {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            padding: 3rem 3.5rem;
            width: 400px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
            animation: fadeIn 1s ease-out;
        }

        h1 {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            color: #00e6b8;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
        }

        input {
            width: 100%;
            padding: 0.8rem;
            border: none;
            border-radius: 8px;
            background: rgba(255,255,255,0.1);
            color: #fff;
            font-size: 1rem;
            outline: none;
            transition: background 0.3s, box-shadow 0.3s;
        }

        input:focus {
            background: rgba(255,255,255,0.2);
            box-shadow: 0 0 8px rgba(0,255,200,0.5);
        }

        button {
            background: linear-gradient(135deg, #00b09b, #96c93d);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 0.9rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 0 10px rgba(0,255,200,0.6);
        }

        .error {
            color: #ff5252;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        a {
            color: #00e6b8;
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            text-decoration: underline;
        }

        footer {
            position: absolute;
            bottom: 1rem;
            text-align: center;
            width: 100%;
            font-size: 0.9rem;
            color: #aaa;
        }

        footer span {
            color: #00e6b8;
            font-weight: 600;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .admin-container {
                width: 90%;
                padding: 2rem;
            }
        }
    </style>
</head>

<body>

    <div class="admin-container">
        <h1>Bazaaru Admin Login</h1>
        <form method="post" action="admin-login.jsp">
            <input type="text" name="username" placeholder="Admin Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login as Admin</button>
        </form>
        <p class="error"><%= error %></p>
        <p><a href="index.jsp">← Back to Home</a></p>
    </div>

    <footer>
        &copy; 2025 <span>Bazaaru</span> • Admin Access Panel
    </footer>

</body>
</html>
