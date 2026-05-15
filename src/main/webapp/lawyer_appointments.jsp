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
    <title>Manage Appointments | LegalConnect Premium</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .section-header h1 {
            font-size: 1.8rem;
        }

        /* Table */
        .table-card {
            background: var(--surface-dark);
            border-radius: 20px;
            padding: 20px;
            border: 1px solid var(--border-color);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        td {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 0.95rem;
        }

        .client-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .client-avatar {
            width: 35px;
            height: 35px;
            background: var(--primary-gold);
            color: #000;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 700;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .action-btns {
            display: flex;
            gap: 10px;
        }

        .btn-icon {
            width: 35px;
            height: 35px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-icon:hover {
            border-color: var(--primary-gold);
            color: var(--primary-gold);
            background: rgba(197, 160, 89, 0.1);
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
            <a href="lawyer_appointments.jsp" class="nav-item active">
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
            <h1>Manage Booked Appointments</h1>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Client Detail</th>
                        <th>Service Type</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        boolean hasData = false;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM bookings WHERE lawyer_email=? ORDER BY id DESC");
                            ps.setString(1, lawyerEmail);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                                hasData = true;
                                String client = rs.getString("user_email");
                    %>
                                <tr>
                                    <td>#<%= rs.getInt("id") %></td>
                                    <td>
                                        <div class="client-info">
                                            <div class="client-avatar"><%= client.substring(0, 1).toUpperCase() %></div>
                                            <span><%= client %></span>
                                        </div>
                                    </td>
                                    <td>Legal Consultation</td>
                                    <td><span class="status-badge">Confirmed</span></td>
                                    <td>
                                        <div class="action-btns">
                                            <div class="btn-icon"><i class="fa-solid fa-eye"></i></div>
                                            <div class="btn-icon" onclick="window.location.href='lawyer_chat.jsp'"><i class="fa-solid fa-comment"></i></div>
                                            <div class="btn-icon"><i class="fa-solid fa-check"></i></div>
                                        </div>
                                    </td>
                                </tr>
                    <%
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                        if(!hasData) {
                    %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px; color: var(--text-muted);">No booked appointments found.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
