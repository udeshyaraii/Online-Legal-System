<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% 
    if(session.getAttribute("lawyer") == null){ 
        response.sendRedirect("lawyer_login.jsp"); 
        return; 
    } 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Settings | LegalConnect Premium</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-gold: #c5a059;
            --bg-dark: #0f1115;
            --surface-dark: #1a1d23;
            --surface-light: #242830;
            --text-light: #e5e7eb;
            --text-muted: #9ca3af;
            --border-color: rgba(197, 160, 89, 0.1);
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-light);
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        .sidebar {
            width: var(--sidebar-width);
            background: var(--surface-dark);
            border-right: 1px solid var(--border-color);
            position: fixed;
            height: 100vh;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 40px;
        }

        .settings-card {
            background: var(--surface-dark);
            border-radius: 24px;
            padding: 40px;
            border: 1px solid var(--border-color);
            max-width: 600px;
        }

        .setting-item {
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .setting-item label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .setting-item input {
            width: 100%;
            padding: 12px;
            background: var(--surface-light);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            color: white;
            outline: none;
        }

        .save-btn {
            background: var(--primary-gold);
            color: black;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <!-- Re-use Sidebar items if needed -->
        <div style="padding: 40px 30px; color: var(--primary-gold); font-weight: 700;">
            <i class="fa-solid fa-scale-balanced"></i> LEGAL CONNECT
        </div>
        <a href="lawyer_dashboard.jsp" style="display: block; padding: 15px 30px; color: var(--text-muted); text-decoration: none;">Dashboard</a>
    </div>

    <div class="main-content">
        <h1>Account Settings</h1>
        <div class="settings-card">
            <div class="setting-item">
                <label>Change Password</label>
                <input type="password" placeholder="New Password">
            </div>
            <div class="setting-item">
                <label>Update Notification Email</label>
                <input type="email" placeholder="Email for notifications">
            </div>
            <button class="save-btn">Save Changes</button>
        </div>
    </div>
</body>
</html>
