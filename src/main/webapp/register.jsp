<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Register | LegalConnect</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #1d1e1f;
                --secondary-color: #f59e0b;
                --bg-color: #f3f4f6;
                --surface-color: #ffffff;
                --text-main: #111827;
                --text-muted: #6b7280;
                --border-color: #e5e7eb;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .register-container {
                background: var(--surface-color);
                width: 100%;
                max-width: 400px;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
                border: 1px solid var(--border-color);
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
            }

            .header i {
                font-size: 2.5rem;
                color: var(--primary-color);
                margin-bottom: 15px;
            }

            .header h2 {
                color: var(--text-main);
                font-weight: 600;
                font-size: 1.5rem;
            }

            .header p {
                color: var(--text-muted);
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .input-group {
                margin-bottom: 20px;
                position: relative;
            }

            .input-group i {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                left: 15px;
                color: var(--text-muted);
            }

            input {
                width: 100%;
                padding: 12px 15px 12px 45px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 1rem;
                color: var(--text-main);
                outline: none;
                transition: 0.3s;
            }

            input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.1);
            }

            .submit-btn {
                width: 100%;
                padding: 12px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: 0.3s;
            }

            .submit-btn:hover {
                background-color: #218838;
            }

            .footer {
                text-align: center;
                margin-top: 20px;
                font-size: 0.9rem;
                color: var(--text-muted);
            }

            .footer a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
            }

            .footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="register-container">
            <div class="header">
                <i class="fa-solid fa-scale-balanced"></i>
                <h2>Create an Account</h2>
                <p>Join LegalConnect today</p>
            </div>
            <form action="RegisterServlet" method="post">
                <div class="input-group">
                    <i class="fa-regular fa-user"></i>
                    <input type="text" name="name" placeholder="Full Name" required>
                </div>
                <div class="input-group">
                    <i class="fa-regular fa-envelope"></i>
                    <input type="email" name="email" placeholder="Email Address" required>
                </div>
                <div class="input-group">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="submit-btn">Register</button>
            </form>
            <div class="footer">
                Already have an account? <a href="login.jsp">Sign in</a><br>
                <span style="display:inline-block; margin-top:10px;">Are you a legal expert? <a
                        href="lawyer_register.jsp">Register as a Lawyer</a></span>
            </div>
        </div>
    </body>

    </html>