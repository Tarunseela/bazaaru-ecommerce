<%@ page isErrorPage="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bazaaru - Error</title>

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
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          height: 100vh;
          overflow: hidden;
        }

        /* Glassmorphism Container */
        .error-box {
          background: rgba(255, 255, 255, 0.08);
          border: 1px solid rgba(255, 255, 255, 0.2);
          border-radius: 16px;
          padding: 3rem 3.5rem;
          text-align: center;
          box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
          backdrop-filter: blur(12px);
          animation: fadeIn 1s ease-out;
        }

        .error-box h1 {
          font-size: 2.2rem;
          color: #ff5252;
          margin-bottom: 1rem;
        }

        .error-box p {
          font-size: 1rem;
          color: #ddd;
          margin-bottom: 1rem;
        }

        .error-details {
          background: rgba(255, 255, 255, 0.12);
          border-radius: 10px;
          padding: 1rem;
          margin-top: 1rem;
          color: #ff8a80;
          font-size: 0.95rem;
          word-wrap: break-word;
        }

        a {
          display: inline-block;
          margin-top: 1.5rem;
          background: linear-gradient(135deg, #00b09b, #96c93d);
          color: #fff;
          text-decoration: none;
          padding: 0.7rem 1.5rem;
          border-radius: 8px;
          font-weight: 600;
          transition: transform 0.3s, box-shadow 0.3s;
        }

        a:hover {
          transform: scale(1.05);
          box-shadow: 0 0 12px rgba(0, 255, 200, 0.6);
        }

        footer {
          position: absolute;
          bottom: 1rem;
          text-align: center;
          font-size: 0.9rem;
          color: #aaa;
        }

        footer span {
          color: #00e6b8;
          font-weight: 600;
        }

        @keyframes fadeIn {
          from { opacity: 0; transform: translateY(30px); }
          to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
          .error-box {
            width: 90%;
            padding: 2rem;
          }
          .error-box h1 {
            font-size: 1.8rem;
          }
        }
    </style>
</head>

<body>
    <div class="error-box">
        <h1>Oops! Something Went Wrong</h1>
        <p>Sorry, an unexpected error occurred while processing your request.</p>
        <div class="error-details">
            <strong>Error Details:</strong>
            <br>
            <%= exception == null ? "Unknown Error" : exception.getMessage() %>
        </div>
        <a href="index.jsp">Return to Home</a>
    </div>

    <footer>
        &copy; 2025 <span>Bazaaru</span> • Empowering Andhra’s Digital Marketplace
    </footer>
</body>
</html>
