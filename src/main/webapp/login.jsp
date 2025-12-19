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
            if (u != null) {
                session.setAttribute("user", u);
                response.sendRedirect("index.jsp");
                return;
            } else {
                error = "Invalid credentials.";
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
  <title>Login - E-Commerce</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Inter:wght@400;500&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

  <!-- Fullscreen Background Video -->
  <video autoplay muted loop id="bg-video">
    <source src="assets/video/bg.mp4" type="video/mp4">
  </video>

  <!-- Dark Overlay -->
  <div class="overlay"></div>

  <!-- Glass Login Card -->
  <div class="login-container">
    <form method="post" action="login.jsp" class="login-form">
      <h1 class="title">Welcome Back</h1>
      <p class="subtitle">Sign in to your E-Commerce Dashboard</p>

      <div class="input-group">
        <input type="text" name="username" id="username" required>
        <label for="username">Username</label>
      </div>

      <div class="input-group">
        <input type="password" name="password" id="password" required>
        <label for="password">Password</label>
      </div>

      <% if (!error.isEmpty()) { %>
        <div class="error-message"><%= error %></div>
      <% } %>

      <button type="submit" class="login-btn">Login</button>
    </form>
  </div>

</body>
</html>
