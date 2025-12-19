<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Double total = (Double) request.getAttribute("total");
    if (total == null) total = 0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Checkout Complete</title>
    <style>
        /* ====== Reset ====== */
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
            flex-direction: column;
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

        .checkout-box {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            padding: 3rem 3.5rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
            animation: fadeIn 1s ease-out;
        }

        h1 {
            font-size: 2.2rem;
            color: #00e6b8;
            margin-bottom: 1rem;
        }

        p {
            font-size: 1rem;
            color: #ddd;
            margin: 0.6rem 0;
        }

        .total {
            color: #00e676;
            font-size: 1.2rem;
            font-weight: 600;
            margin-top: 1rem;
        }

        a {
            display: inline-block;
            margin-top: 1.8rem;
            text-decoration: none;
            background: linear-gradient(135deg, #00b09b, #96c93d);
            color: #fff;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        a:hover {
            transform: scale(1.05);
            box-shadow: 0 0 12px rgba(0,255,200,0.6);
        }

        .success-icon {
            width: 100px;
            height: 100px;
            border: 4px solid #00e676;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            animation: popIn 0.8s ease-out;
        }

        .success-icon::after {
            content: '✔';
            font-size: 3rem;
            color: #00e676;
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

        @keyframes popIn {
            0% { transform: scale(0); opacity: 0; }
            80% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }

        @media (max-width: 480px) {
            .checkout-box {
                width: 90%;
                padding: 2rem;
            }
            h1 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>

<body>

    <div class="checkout-box">
        <div class="success-icon"></div>
        <h1>Thank You for Shopping!</h1>
        <p>Your order has been placed successfully.</p>
        <p class="total">Total Paid: ₹<%= String.format("%.2f", total) %></p>
        <a href="index.jsp">Continue Shopping</a>
    </div>

    <footer>
        &copy; 2025 <span>Bazaaru</span> — Empowering Andhra’s Digital Marketplace
    </footer>

</body>
</html>
