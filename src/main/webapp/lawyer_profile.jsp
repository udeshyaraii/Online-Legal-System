<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% 
    if(session.getAttribute("lawyer") == null){ 
        response.sendRedirect("lawyer_login.jsp"); 
        return; 
    } 
    String lawyerEmail = (String) session.getAttribute("lawyer"); 
    
    String name="", spec="", lang="", experience="", fee="";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM lawyers WHERE email=?");
        ps.setString(1, lawyerEmail);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            name = rs.getString("name");
            spec = rs.getString("specialization");
            lang = rs.getString("languages");
            experience = rs.getString("experience");
            fee = rs.getString("fee");
        }
    } catch(Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professional Profile | LegalConnect Premium</title>
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
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--surface-dark);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 100;
        }

        .sidebar-header {
            padding: 40px 30px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .sidebar-header i {
            font-size: 2rem;
            color: var(--primary-gold);
        }

        .sidebar-header h2 {
            font-size: 1.25rem;
            letter-spacing: 1px;
            color: var(--primary-gold);
        }

        .nav-menu {
            flex: 1;
            padding: 20px 15px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            color: var(--text-muted);
            text-decoration: none;
            border-radius: 12px;
            margin-bottom: 8px;
            transition: all 0.3s;
            font-weight: 500;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(197, 160, 89, 0.1);
            color: var(--primary-gold);
        }

        .nav-item i {
            width: 24px;
            font-size: 1.1rem;
            margin-right: 12px;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 40px;
        }

        .profile-card {
            background: var(--surface-dark);
            border-radius: 24px;
            padding: 40px;
            border: 1px solid var(--border-color);
            max-width: 800px;
            margin: 0 auto;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 40px;
            padding-bottom: 40px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            background: var(--surface-light);
            color: var(--primary-gold);
            border-radius: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 3rem;
            font-weight: 700;
            border: 1px solid var(--border-color);
        }

        .profile-title h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .profile-title p {
            color: var(--primary-gold);
            font-weight: 500;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .info-group label {
            display: block;
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        .info-value {
            background: var(--surface-light);
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 500;
            border: 1px solid rgba(255, 255, 255, 0.03);
        }

        .edit-btn {
            margin-top: 40px;
            width: 100%;
            padding: 15px;
            background: var(--primary-gold);
            color: #000;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .edit-btn:hover {
            transform: scale(1.02);
            filter: brightness(1.1);
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fa-solid fa-scale-balanced"></i>
            <h2>LEGAL CONNECT</h2>
        </div>
        <div class="nav-menu">
            <a href="lawyer_dashboard.jsp" class="nav-item">
                <i class="fa-solid fa-gauge-high"></i>
                Dashboard
            </a>
            <a href="lawyer_appointments.jsp" class="nav-item">
                <i class="fa-solid fa-calendar-days"></i>
                Appointments
            </a>
            <a href="lawyer_chat.jsp" class="nav-item">
                <i class="fa-solid fa-comment-dots"></i>
                Messages
            </a>
            <a href="lawyer_clients.jsp" class="nav-item">
                <i class="fa-solid fa-users"></i>
                Clients
            </a>
            <a href="lawyer_earnings.jsp" class="nav-item">
                <i class="fa-solid fa-file-invoice-dollar"></i>
                Earnings
            </a>
            <a href="lawyer_profile.jsp" class="nav-item active">
                <i class="fa-solid fa-user-tie"></i>
                Profile
            </a>
            <a href="lawyer_settings.jsp" class="nav-item">
                <i class="fa-solid fa-gear"></i>
                Settings
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar"><%= name.substring(0, 1).toUpperCase() %></div>
                <div class="profile-title">
                    <h1>Adv. <%= name %></h1>
                    <p><%= spec %></p>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-group">
                    <label>Email Address</label>
                    <div class="info-value"><%= lawyerEmail %></div>
                </div>
                <div class="info-group">
                    <label>Specialization</label>
                    <div class="info-value"><%= spec %></div>
                </div>
                <div class="info-group">
                    <label>Languages</label>
                    <div class="info-value"><%= lang %></div>
                </div>
                <div class="info-group">
                    <label>Experience</label>
                    <div class="info-value"><%= experience %> Years</div>
                </div>
                <div class="info-group">
                    <label>Consultation Fee</label>
                    <div class="info-value">₹<%= fee %></div>
                </div>
            </div>

            <button class="edit-btn">Edit Professional Profile</button>
        </div>
    </div>
</body>
</html>
