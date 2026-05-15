<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% 
    if(session.getAttribute("lawyer") == null){ 
        response.sendRedirect("lawyer_login.jsp"); 
        return; 
    } 
    String lawyerEmail = (String) session.getAttribute("lawyer"); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Clients | LegalConnect Premium</title>
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

        .section-header {
            margin-bottom: 40px;
        }

        .section-header h1 {
            font-size: 1.8rem;
        }

        /* Clients Grid */
        .clients-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .client-card {
            background: var(--surface-dark);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid var(--border-color);
            text-align: center;
            transition: 0.3s;
        }

        .client-card:hover {
            transform: translateY(-5px);
            border-color: var(--primary-gold);
        }

        .client-avatar {
            width: 80px;
            height: 80px;
            background: var(--surface-light);
            color: var(--primary-gold);
            border-radius: 20px;
            margin: 0 auto 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2rem;
            font-weight: 700;
            border: 1px solid var(--border-color);
        }

        .client-card h3 {
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .client-card p {
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-bottom: 20px;
        }

        .client-meta {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
            font-size: 0.85rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--text-muted);
        }

        .meta-item i {
            color: var(--primary-gold);
        }

        .btn-chat {
            width: 100%;
            padding: 12px;
            background: rgba(197, 160, 89, 0.1);
            color: var(--primary-gold);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            display: block;
            transition: 0.3s;
        }

        .btn-chat:hover {
            background: var(--primary-gold);
            color: #000;
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
            <a href="lawyer_clients.jsp" class="nav-item active">
                <i class="fa-solid fa-users"></i>
                Clients
            </a>
            <a href="lawyer_earnings.jsp" class="nav-item">
                <i class="fa-solid fa-file-invoice-dollar"></i>
                Earnings
            </a>
            <a href="lawyer_profile.jsp" class="nav-item">
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
        <div class="section-header">
            <h1>Active Clients</h1>
        </div>

        <div class="clients-grid">
            <%
                boolean hasClients = false;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
                    PreparedStatement ps = con.prepareStatement("SELECT DISTINCT user_email FROM bookings WHERE lawyer_email=?");
                    ps.setString(1, lawyerEmail);
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()){
                        hasClients = true;
                        String client = rs.getString("user_email");
            %>
                        <div class="client-card">
                            <div class="client-avatar"><%= client.substring(0, 1).toUpperCase() %></div>
                            <h3><%= client.split("@")[0] %></h3>
                            <p><%= client %></p>
                            <div class="client-meta">
                                <div class="meta-item"><i class="fa-solid fa-calendar-check"></i> 1 Consultation</div>
                            </div>
                            <a href="lawyer_chat.jsp" class="btn-chat">Message Client</a>
                        </div>
            <%
                    }
                } catch(Exception e) { e.printStackTrace(); }
                if(!hasClients) {
            %>
                <div style="grid-column: 1/-1; text-align: center; padding: 100px; color: var(--text-muted);">
                    <i class="fa-solid fa-users-slash" style="font-size: 3rem; margin-bottom: 20px;"></i>
                    <p>No active clients found in your network.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
