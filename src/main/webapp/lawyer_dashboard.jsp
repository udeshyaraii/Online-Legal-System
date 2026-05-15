<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% 
    if(session.getAttribute("lawyer") == null){ 
        response.sendRedirect("lawyer_login.jsp"); 
        return; 
    } 
    String lawyerEmail = (String) session.getAttribute("lawyer"); 
    
    int totalConsultations = 0;
    double totalEarnings = 0;
    int pendingRequests = 0;
    String lawyerName = "Counselor";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
        
        // Get lawyer name
        PreparedStatement psName = con.prepareStatement("SELECT name FROM lawyers WHERE email=?");
        psName.setString(1, lawyerEmail);
        ResultSet rsName = psName.executeQuery();
        if(rsName.next()) lawyerName = rsName.getString("name");

        // Get stats
        PreparedStatement psStats = con.prepareStatement("SELECT COUNT(*) as total FROM bookings WHERE lawyer_email=?");
        psStats.setString(1, lawyerEmail);
        ResultSet rsStats = psStats.executeQuery();
        if(rsStats.next()) totalConsultations = rsStats.getInt("total");
        
        // Mock earnings for now based on consultations
        totalEarnings = totalConsultations * 500; 

    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lawyer Dashboard | LegalConnect Premium</title>
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

        .sidebar-footer {
            padding: 30px;
            border-top: 1px solid var(--border-color);
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 40px;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .welcome-text h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .welcome-text p {
            color: var(--text-muted);
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-premium {
            background: linear-gradient(135deg, var(--primary-gold) 0%, #a68546 100%);
            color: #000;
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--surface-dark);
            padding: 25px;
            border-radius: 20px;
            border: 1px solid var(--border-color);
        }

        .stat-card .icon {
            width: 45px;
            height: 45px;
            background: rgba(197, 160, 89, 0.1);
            color: var(--primary-gold);
            border-radius: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .stat-card .value {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-card .label {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        /* Dashboard Content Sections */
        .content-sections {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .section-card {
            background: var(--surface-dark);
            border-radius: 24px;
            padding: 30px;
            border: 1px solid var(--border-color);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-header h3 {
            font-size: 1.2rem;
        }

        .view-all {
            color: var(--primary-gold);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
        }

        /* Appointment List */
        .appointment-item {
            display: flex;
            align-items: center;
            padding: 15px;
            background: var(--surface-light);
            border-radius: 16px;
            margin-bottom: 15px;
            transition: transform 0.2s;
        }

        .appointment-item:hover {
            transform: translateX(10px);
        }

        .client-avatar {
            width: 50px;
            height: 50px;
            background: #3b82f6;
            border-radius: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 700;
            margin-right: 15px;
        }

        .appointment-info {
            flex: 1;
        }

        .appointment-info h4 {
            font-size: 1rem;
            margin-bottom: 4px;
        }

        .appointment-info p {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .appointment-time {
            text-align: right;
        }

        .time-tag {
            background: rgba(197, 160, 89, 0.1);
            color: var(--primary-gold);
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        /* Messages */
        .message-item {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .msg-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #10b981;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-shrink: 0;
        }

        .msg-content h5 {
            font-size: 0.95rem;
            margin-bottom: 3px;
        }

        .msg-content p {
            font-size: 0.85rem;
            color: var(--text-muted);
            line-height: 1.4;
        }

        .msg-time {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 5px;
        }

        .empty-text {
            text-align: center;
            padding: 20px;
            color: var(--text-muted);
            font-style: italic;
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
            <a href="lawyer_dashboard.jsp" class="nav-item active">
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
            <a href="lawyer_profile.jsp" class="nav-item">
                <i class="fa-solid fa-user-tie"></i>
                Profile
            </a>
            <a href="lawyer_settings.jsp" class="nav-item">
                <i class="fa-solid fa-gear"></i>
                Settings
            </a>
        </div>
        <div class="sidebar-footer">
            <a href="LogoutServlet" class="nav-item">
                <i class="fa-solid fa-right-from-bracket"></i>
                Sign Out
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header-top">
            <div class="welcome-text">
                <h1>Welcome, Adv. <%= lawyerName %></h1>
                <p>Here's what's happening with your practice today.</p>
            </div>
            <div class="user-actions">
                <a href="#" class="btn-premium">
                    <i class="fa-solid fa-crown"></i>
                    PREMIUM MEMBER
                </a>
                <div style="width: 45px; height: 45px; border-radius: 50%; background: var(--primary-gold); color: #000; display: flex; justify-content: center; align-items: center; font-weight: 700;">
                    <%= lawyerName.substring(0, 1).toUpperCase() %>
                </div>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="icon"><i class="fa-solid fa-calendar-check"></i></div>
                <div class="value"><%= totalConsultations %></div>
                <div class="label">Consultations</div>
            </div>
            <div class="stat-card">
                <div class="icon"><i class="fa-solid fa-star"></i></div>
                <div class="value">4.9</div>
                <div class="label">Avg. Rating</div>
            </div>
            <div class="stat-card">
                <div class="icon"><i class="fa-solid fa-indian-rupee-sign"></i></div>
                <div class="value">₹<%= (int)totalEarnings %></div>
                <div class="label">Total Earnings</div>
            </div>
            <div class="stat-card">
                <div class="icon"><i class="fa-solid fa-user-clock"></i></div>
                <div class="value">0</div>
                <div class="label">Pending Requests</div>
            </div>
        </div>

        <!-- Content -->
        <div class="content-sections">
            <!-- Appointments -->
            <div class="section-card">
                <div class="section-header">
                    <h3>Upcoming Appointments</h3>
                    <a href="lawyer_appointments.jsp" class="view-all">View Schedule</a>
                </div>
                
                <div class="appointment-list">
                    <%
                        boolean hasAppointments = false;
                        try {
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM bookings WHERE lawyer_email=? ORDER BY id DESC LIMIT 3");
                            ps.setString(1, lawyerEmail);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                                hasAppointments = true;
                                String clientEmail = rs.getString("user_email");
                                String initials = clientEmail.substring(0, 1).toUpperCase();
                    %>
                                <div class="appointment-item">
                                    <div class="client-avatar"><%= initials %></div>
                                    <div class="appointment-info">
                                        <h4><%= clientEmail %></h4>
                                        <p>Legal Consultation • Case Review</p>
                                    </div>
                                    <div class="appointment-time">
                                        <span class="time-tag">TBD</span>
                                        <p style="font-size: 0.75rem; margin-top: 5px;">Today</p>
                                    </div>
                                </div>
                    <%
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                        if(!hasAppointments) {
                    %>
                        <div class="empty-text">No booked appointments yet.</div>
                    <% } %>
                </div>
            </div>

            <!-- Messages -->
            <div class="section-card">
                <div class="section-header">
                    <h3>Recent Messages</h3>
                    <a href="lawyer_chat.jsp" class="view-all">Open Chat</a>
                </div>

                <div class="message-list">
                    <%
                        // Simulated message data for demo as we don't have a messages table yet
                        // In a real app, you'd fetch from a messages table
                    %>
                    <div class="message-item">
                        <div class="msg-avatar">UK</div>
                        <div class="msg-content">
                            <h5>User Client</h5>
                            <p>I have some questions about the case...</p>
                            <div class="msg-time">Just now</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
