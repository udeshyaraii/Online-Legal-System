<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lawyer Login | LegalConnect Premium</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-gold: #c5a059;
            --primary-gold-dark: #a68546;
            --bg-dark: #0f1115;
            --surface-dark: #1a1d23;
            --text-light: #e5e7eb;
            --text-muted: #9ca3af;
            --border-color: rgba(197, 160, 89, 0.2);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-light);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        /* Animated Background */
        .bg-glow {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(197, 160, 89, 0.05) 0%, transparent 70%);
            z-index: -1;
            filter: blur(50px);
        }

        .login-card {
            background: var(--surface-dark);
            width: 100%;
            max-width: 450px;
            padding: 50px;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            border: 1px solid var(--border-color);
            position: relative;
            backdrop-filter: blur(10px);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo-section i {
            font-size: 3rem;
            color: var(--primary-gold);
            margin-bottom: 15px;
            filter: drop-shadow(0 0 10px rgba(197, 160, 89, 0.3));
        }

        .logo-section h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--primary-gold);
            letter-spacing: 1px;
        }

        .logo-section p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-top: 8px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text-muted);
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-gold);
            font-size: 1.1rem;
        }

        input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(197, 160, 89, 0.1);
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            outline: none;
        }

        input:focus {
            border-color: var(--primary-gold);
            background: rgba(197, 160, 89, 0.05);
            box-shadow: 0 0 0 4px rgba(197, 160, 89, 0.1);
        }

        .login-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--primary-gold) 0%, var(--primary-gold-dark) 100%);
            color: #000;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(197, 160, 89, 0.3);
            filter: brightness(1.1);
        }

        .footer-links {
            margin-top: 30px;
            text-align: center;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .footer-links a {
            color: var(--primary-gold);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        .role-switcher {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 0.8rem;
        }

        .role-switcher a {
            color: var(--text-muted);
            text-decoration: none;
            padding: 6px 12px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            transition: 0.3s;
        }

        .role-switcher a:hover {
            border-color: var(--primary-gold);
            color: var(--primary-gold);
        }
    </style>
</head>
<body>
    <div class="bg-glow"></div>

    <div class="login-card">
        <div class="role-switcher">
            <a href="login.jsp">Client Login</a>
        </div>

        <div class="logo-section">
            <i class="fa-solid fa-scale-balanced"></i>
            <h1>LegalConnect</h1>
            <p>Advocate Excellence Portal</p>
        </div>

        <form action="LawyerLoginServlet" method="post">
            <div class="form-group">
                <label>Professional ID / Email</label>
                <div class="input-wrapper">
                    <i class="fa-regular fa-envelope"></i>
                    <input type="email" name="email" placeholder="lawyer@legalconnect.com" required>
                </div>
            </div>

            <div class="form-group">
                <label>Secure Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <button type="submit" class="login-btn">Enter Portal</button>
        </form>

        <div class="footer-links">
            <p>New to the elite network? <a href="lawyer_register.jsp">Join as Advocate</a></p>
            <p style="margin-top: 15px;"><a href="#">Forgot security credentials?</a></p>
        </div>
    </div>
</body>
</html>
