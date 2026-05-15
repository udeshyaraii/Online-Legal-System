<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% 
    if(session.getAttribute("lawyer") == null){ 
        response.sendRedirect("lawyer_login.jsp"); 
        return; 
    } 
    String lawyerEmail = (String) session.getAttribute("lawyer"); 
    
    int bookingsCount = 0;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM bookings WHERE lawyer_email=?");
        ps.setString(1, lawyerEmail);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) bookingsCount = rs.getInt(1);
    } catch(Exception e) { e.printStackTrace(); }
    
    int consultationFee = 500;
    int totalEarnings = bookingsCount * consultationFee;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Earnings | LegalConnect Premium</title>
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

        .earnings-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .earning-card {
            background: var(--surface-dark);
            border-radius: 24px;
            padding: 40px;
            border: 1px solid var(--border-color);
        }

        .earning-summary {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 40px;
        }

        .summary-box {
            background: var(--surface-light);
            padding: 25px;
            border-radius: 20px;
            text-align: center;
        }

        .summary-box h4 {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .summary-box .amount {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-gold);
        }

        .payout-card {
            background: var(--surface-dark);
            border-radius: 24px;
            padding: 30px;
            border: 1px solid var(--border-color);
        }

        .payout-card h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .transaction-list {
            list-style: none;
        }

        .transaction-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .transaction-item:last-child {
            border-bottom: none;
        }

        .tx-info h5 {
            font-size: 0.95rem;
            margin-bottom: 3px;
        }

        .tx-info p {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .tx-amount {
            font-weight: 700;
            color: #10b981;
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
            <a href="lawyer_earnings.jsp" class="nav-item active">
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
            <h1>Practice Earnings</h1>
        </div>

        <div class="earnings-grid">
            <div class="earning-card">
                <div class="earning-summary">
                    <div class="summary-box">
                        <h4>Total Balance</h4>
                        <div class="amount">₹<%= totalEarnings %></div>
                    </div>
                    <div class="summary-box">
                        <h4>Consultations</h4>
                        <div class="amount"><%= bookingsCount %></div>
                    </div>
                </div>

                <h3>Recent Transactions</h3>
                <div class="transaction-list">
                    <%
                        try {
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM bookings WHERE lawyer_email=? ORDER BY id DESC LIMIT 5");
                            ps.setString(1, lawyerEmail);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                    %>
                                <div class="transaction-item">
                                    <div class="tx-info">
                                        <h5>Payment from <%= rs.getString("user_email").split("@")[0] %></h5>
                                        <p>Consultation Fee • #<%= rs.getInt("id") %></p>
                                    </div>
                                    <div class="tx-amount">+ ₹<%= consultationFee %></div>
                                </div>
                    <%
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                    %>
                </div>
            </div>

            <div class="payout-card">
                <h3>Payout Method</h3>
                <div style="background: var(--surface-light); padding: 20px; border-radius: 15px; display: flex; align-items: center; gap: 15px; margin-bottom: 20px;">
                    <i class="fa-solid fa-building-columns" style="font-size: 1.5rem; color: var(--primary-gold);"></i>
                    <div>
                        <h5 style="margin-bottom: 2px;">Bank Transfer</h5>
                        <p style="font-size: 0.8rem; color: var(--text-muted);">**** **** 8920</p>
                    </div>
                </div>
                <button style="width: 100%; padding: 15px; background: var(--primary-gold); color: #000; border: none; border-radius: 12px; font-weight: 700; cursor: pointer;">Withdraw Funds</button>
            </div>
        </div>
    </div>
</body>
</html>
