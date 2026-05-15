<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Lawyer Registration | LegalConnect</title>
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
                min-height: 100vh;
                padding: 40px 20px;
            }

            .register-container {
                background: var(--surface-color);
                width: 100%;
                max-width: 500px;
                /* Wider for more fields */
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

            .grid-2 {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }

            .input-group {
                margin-bottom: 20px;
                position: relative;
            }

            .input-group i {
                position: absolute;
                top: 40px;
                transform: translateY(-50%);
                left: 15px;
                color: var(--text-muted);
            }

            .input-group label {
                display: block;
                font-size: 0.85rem;
                font-weight: 500;
                color: var(--text-main);
                margin-bottom: 8px;
            }

            input,
            select {
                width: 100%;
                padding: 12px 15px 12px 45px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 1rem;
                color: var(--text-main);
                outline: none;
                transition: 0.3s;
                font-family: 'Inter', sans-serif;
            }

            select {
                appearance: none;
                background-color: #fff;
                cursor: pointer;
            }

            input:focus,
            select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.1);
            }

            .submit-btn {
                width: 100%;
                padding: 14px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: 0.3s;
                margin-top: 10px;
            }

            .submit-btn:hover {
                background-color: #1e40af;
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
                <i class="fa-solid fa-briefcase"></i>
                <h2>Partner with LegalConnect</h2>
                <p>Register as a Legal Expert</p>
            </div>
            <form action="LawyerRegisterServlet" method="post">
                <div class="input-group">
                    <label>Full Name</label>
                    <i class="fa-regular fa-user"></i>
                    <input type="text" name="name" placeholder="Adv. John Doe" required>
                </div>
                <div class="input-group">
                    <label>Email Address</label>
                    <i class="fa-regular fa-envelope"></i>
                    <input type="email" name="email" placeholder="john.doe@example.com" required>
                </div>
                <div class="grid-2">
                    <div class="input-group">
                        <label>Password</label>
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" placeholder="••••••••" required>
                    </div>
                    <div class="input-group">
                        <label>Experience (Years)</label>
                        <i class="fa-solid fa-calendar-days"></i>
                        <input type="number" name="experience" placeholder="e.g. 5" min="1" required>
                    </div>
                </div>
                <div class="grid-2">
                    <div class="input-group">
                        <label>Specialization</label>
                        <i class="fa-solid fa-scale-balanced"></i>
                        <select name="specialization" required>
                            <option value="" disabled selected>Select Area...</option>
                            <option value="Criminal Law">Criminal Law</option>
                            <option value="Family Law">Family Law</option>
                            <option value="Corporate Law">Corporate Law</option>
                            <option value="Property Law">Property Law</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>Consultation Fee (₹)</label>
                        <i class="fa-solid fa-indian-rupee-sign"></i>
                        <input type="number" name="fee" placeholder="e.g. 500" required>
                    </div>
                </div>
                <div class="input-group">
                    <label>Languages Spoken</label>
                    <i class="fa-solid fa-language"></i>
                    <input type="text" name="languages" placeholder="e.g. English, Hindi, Marathi" required>
                </div>

                <button type="submit" class="submit-btn">Apply as Expert</button>
            </form>
            <div class="footer">
                Already registered? <a href="login.jsp">Sign in</a>
            </div>
        </div>
    </body>

    </html>