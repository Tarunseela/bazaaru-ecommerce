<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.dao.ProductDAO, com.ecommerce.model.Product, java.util.List" %>
<%
    ProductDAO dao = new ProductDAO();
    List<Product> products = dao.findAll();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Home</title>
    <style>
        /* ====== Reset & Base ====== */
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }

        body {
          font-family: 'Poppins', 'Inter', sans-serif;
          background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
          color: #fff;
          overflow-x: hidden;
        }

        /* ====== Header ====== */
        header {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          background: rgba(0, 0, 0, 0.5);
          backdrop-filter: blur(10px);
          padding: 1rem 3rem;
          display: flex;
          justify-content: space-between;
          align-items: center;
          z-index: 100;
          border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        header h1 {
          font-size: 2rem;
          font-weight: 600;
          letter-spacing: 1px;
          color: #00e6b8;
        }

        header nav a {
          color: #fff;
          text-decoration: none;
          margin-left: 1rem;
          font-weight: 500;
          transition: color 0.3s ease;
        }

        header nav a:hover {
          color: #00e6b8;
        }

        /* ====== Hero Section ====== */
        .hero {
          position: relative;
          height: 70vh;
          background: url('assets/images/banner.jpg') center/cover no-repeat;
          display: flex;
          align-items: center;
          justify-content: center;
          text-align: center;
          color: #fff;
        }

        .hero::after {
          content: "";
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: rgba(0, 0, 0, 0.6);
        }

        .hero-content {
          position: relative;
          z-index: 1;
          max-width: 700px;
          padding: 2rem;
          backdrop-filter: blur(10px);
          border-radius: 16px;
          background: rgba(255, 255, 255, 0.1);
          animation: fadeIn 1.2s ease-out;
        }

        .hero-content h2 {
          font-size: 2.5rem;
          margin-bottom: 1rem;
          font-weight: 600;
        }

        .hero-content p {
          font-size: 1.1rem;
          color: #ccc;
        }

        /* ====== Main ====== */
        main {
          padding: 8rem 2rem 3rem;
          max-width: 1200px;
          margin: 0 auto;
        }

        main h2 {
          text-align: center;
          font-size: 2rem;
          color: #a8e6ff;
          margin-bottom: 2rem;
        }

        /* ====== Product Grid ====== */
        .product-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
          gap: 2rem;
        }

        .product-card {
          background: rgba(255, 255, 255, 0.08);
          border: 1px solid rgba(255, 255, 255, 0.15);
          border-radius: 16px;
          padding: 1.2rem;
          text-align: center;
          box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
          backdrop-filter: blur(15px);
          transition: transform 0.4s ease, box-shadow 0.4s ease;
          animation: fadeUp 1s ease forwards;
          opacity: 0;
        }

        .product-card:nth-child(odd) { animation-delay: 0.1s; }
        .product-card:nth-child(even) { animation-delay: 0.3s; }

        .product-card:hover {
          transform: translateY(-10px) scale(1.02);
          box-shadow: 0 20px 30px rgba(0, 255, 200, 0.25);
        }

        .product-card img {
          width: 100%;
          height: 220px;
          object-fit: cover;
          border-radius: 12px;
          margin-bottom: 1rem;
        }

        .product-card h3 {
          font-size: 1.2rem;
          margin-bottom: 0.5rem;
        }

        .product-card p {
          color: #ddd;
          font-size: 0.95rem;
          margin-bottom: 0.4rem;
        }

        .product-card p:last-of-type {
          font-weight: 600;
          color: #00e6b8;
        }

        /* ====== Buttons & Inputs ====== */
        .product-card input[type="number"] {
          width: 60px;
          padding: 0.4rem;
          border-radius: 6px;
          border: none;
          outline: none;
          text-align: center;
          background: rgba(255, 255, 255, 0.2);
          color: #fff;
        }

        .product-card button {
          margin-top: 0.5rem;
          background: linear-gradient(135deg, #00b09b, #96c93d);
          border: none;
          border-radius: 8px;
          color: #fff;
          font-weight: 600;
          padding: 0.6rem 1.2rem;
          cursor: pointer;
          transition: all 0.3s ease;
        }

        .product-card button:hover {
          box-shadow: 0 0 12px rgba(0, 255, 200, 0.6);
          transform: scale(1.05);
        }

        /* ====== Footer ====== */
        footer {
          background: rgba(0, 0, 0, 0.4);
          text-align: center;
          padding: 1rem 0;
          color: #aaa;
          border-top: 1px solid rgba(255, 255, 255, 0.15);
        }

        footer span {
          color: #00e6b8;
          font-weight: 600;
        }

        /* ====== Animations ====== */
        @keyframes fadeIn {
          from { opacity: 0; transform: translateY(20px); }
          to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeUp {
          to { opacity: 1; transform: translateY(0); }
        }

        /* ====== Responsive ====== */
        @media (max-width: 768px) {
          header { flex-direction: column; }
          .hero-content h2 { font-size: 1.8rem; }
          .hero-content p { font-size: 0.95rem; }
        }
    </style>
</head>

<body>

<header>
    <h1>Bazaaru</h1>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="register.jsp">Register</a>
        <a href="login.jsp">Login</a>
        <a href="admin-login.jsp">Admin</a>
        <a href="cart.jsp">Cart</a>
    </nav>
</header>

<section class="hero">
  <div class="hero-content">
    <h2>Welcome to Bazaaru</h2>
    <p>Andhra’s own e-commerce platform — local heart, global shopping experience.</p>
  </div>
</section>

<main>
  <h2>Featured Products</h2>
  <div class="product-grid">
      <% for (Product p : products) { %>
          <div class="product-card">
              <img src="<%= p.getImageUrl() != null ? p.getImageUrl() : "assets/images/placeholder.png" %>" alt="<%= p.getName() %>">
              <h3><%= p.getName() %></h3>
              <p><%= p.getDescription() %></p>
              <p>₹<%= String.format("%.2f", p.getPrice()) %></p>
              <form action="cart" method="post">
                  <input type="hidden" name="action" value="add">
                  <input type="hidden" name="productId" value="<%= p.getId() %>">
                  <label>Qty:</label>
                  <input type="number" name="qty" value="1" min="1" max="<%= p.getStock() %>">
                  <br><br>
                  <button type="submit">Add to Cart</button>
              </form>
          </div>
      <% } %>
  </div>
</main>

<footer>
  <p>&copy; 2025 <span>Bazaaru</span> — Empowering Andhra’s Digital Marketplace</p>
</footer>

</body>
</html>
