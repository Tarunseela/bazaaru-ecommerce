<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate admin session
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Admin Logout</title>
    <!-- Redirect back to admin login after 3 seconds -->
    <meta http-equiv="refresh" content="3;url=admin-login.jsp">

    <style>
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
            justify-content: center;
            align-items: center;
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

        .logout-box {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            padding: 3rem 3.5rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
            animation: fadeIn 1.2s ease-out;
        }

        h1 {
            color: #00e6b8;
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        p {
            color: #ccc;
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }

        a {
            display: inline-block;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(135deg, #00b09b, #96c93d);
            padding: 0.7rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        a:hover {
            transform: scale(1.05);
            box-shadow: 0 0 12px rgba(0,255,200,0.6);
        }

        footer {
            position: absolute;
            bottom: 1rem;
            text-align: center;
            width: 100%;
            color: #aaa;
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

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }

        /* Fade-out effect before redirect */
        body.redirecting {
            animation: fadeOut 1.5s ease-in forwards;
        }
    </style>
</head>
<body>
    <div class="logout-box">
        <h1>Logged Out Successfully</h1>
        <p>You’ve been securely signed out of the <strong>Bazaaru</strong> Admin Panel.</p>
        <p>Redirecting to login page...</p>
        <a href="admin-login.jsp">Go to Admin Login</a>
    </div>

    <footer>
        &copy; 2025 <span>Bazaaru</span> • Secure Admin Access
    </footer>
</body>
</html>
