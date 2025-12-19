<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.dao.UserDAO, com.ecommerce.model.User" %>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (username == null || email == null || password == null || username.isEmpty()) {
            message = "Please fill all fields.";
        } else {
            User u = new User();
            u.setUsername(username);
            u.setPassword(password); // hash in production
            u.setEmail(email);
            u.setAdmin(false);
            UserDAO dao = new UserDAO();
            try {
                if (dao.findByUsername(username) != null) {
                    message = "Username already exists.";
                } else {
                    dao.createUser(u);
                    message = "Registration successful. <a href='login.jsp'>Login</a>";
                }
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Register</title>
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

        /* Background overlay */
        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.55);
            backdrop-filter: blur(8px);
            z-index: -1;
        }

        .register-container {
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
            margin-bottom: 1rem;
        }

        label {
            position: relative;
            width: 100%;
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

        p {
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

        .message {
            margin-top: 1rem;
            font-size: 0.95rem;
            color: <%= message.contains("successful") ? "#00e676" : "#ff5252" %>;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .register-container {
                width: 90%;
                padding: 2rem;
            }
        }
    </style>
</head>
<body>

    <div class="register-container">
        <h1>Bazaaru Register</h1>
        <form method="post" action="register.jsp">
            <label>
                <input type="text" name="username" placeholder="Username" required>
            </label>
            <label>
                <input type="email" name="email" placeholder="Email" required>
            </label>
            <label>
                <input type="password" name="password" placeholder="Password" required>
            </label>
            <button type="submit">Create Account</button>
        </form>
        <p>Already a member? <a href="login.jsp">Login</a></p>
        <div class="message"><%= message %></div>
    </div>

</body>
</html>
