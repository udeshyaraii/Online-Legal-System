<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% 
    if(session.getAttribute("user") == null){ 
        response.sendRedirect("login.jsp"); 
        return; 
    } 
    String user = (String) session.getAttribute("user"); 
%>
<!DOCTYPE html>
<html>
<head>
    <title>Messages | LegalConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --sidebar-width: 250px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background-color: var(--primary-color);
            color: white;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }

        .sidebar-header {
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h2 {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .sidebar-nav {
            flex: 1;
            padding: 20px 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 24px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: 0.3s;
            gap: 15px;
            font-weight: 500;
        }

        .nav-item:hover, .nav-item.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid var(--secondary-color);
        }

        .sidebar-footer {
            padding: 20px 24px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            background-color: var(--bg-color);
        }

        .top-nav {
            height: 70px;
            background-color: var(--surface-color);
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 0 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            z-index: 5;
        }

        .profile-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
        }

        /* Chat Layout */
        .chat-container {
            flex: 1;
            display: flex;
            overflow: hidden;
            margin: 20px;
            background: var(--surface-color);
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
        }

        /* Chat List */
        .chat-list {
            width: 320px;
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            background: #fff;
        }

        .chat-list-header {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .conversations {
            flex: 1;
            overflow-y: auto;
        }

        .conversation-item {
            padding: 15px 20px;
            display: flex;
            gap: 15px;
            border-bottom: 1px solid var(--border-color);
            cursor: pointer;
            transition: 0.2s;
            align-items: center;
        }

        .conversation-item:hover, .conversation-item.active {
            background-color: #f8fafc;
        }

        .conv-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background-color: #e0e7ff;
            color: var(--primary-color);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .conv-details {
            flex: 1;
            overflow: hidden;
        }

        .conv-name {
            font-weight: 600;
            display: block;
            margin-bottom: 2px;
        }

        .conv-msg {
            font-size: 0.85rem;
            color: var(--text-muted);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Chat Window */
        .chat-window {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: #fafafa;
        }

        .chat-header {
            padding: 20px;
            background: #fff;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .messages-area {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .message {
            max-width: 70%;
            padding: 12px 16px;
            border-radius: 16px;
            font-size: 0.95rem;
        }

        .message.received {
            align-self: flex-start;
            background: #fff;
            border: 1px solid var(--border-color);
        }

        .message.sent {
            align-self: flex-end;
            background: var(--primary-color);
            color: white;
        }

        .chat-input-area {
            padding: 20px;
            background: #fff;
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 15px;
        }

        .chat-input-area input {
            flex: 1;
            padding: 12px 20px;
            border-radius: 24px;
            border: 1px solid var(--border-color);
            outline: none;
        }

        .send-btn {
            padding: 10px 20px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 24px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header"><i class="fa-solid fa-scale-balanced fa-lg text-white"></i>
            <h2>LegalConnect</h2>
        </div>
        <div class="sidebar-nav">
            <a href="dashboard.jsp" class="nav-item"><i class="fa-solid fa-house"></i><span>Dashboard</span></a>
            <a href="viewBookings.jsp" class="nav-item"><i class="fa-solid fa-calendar-check"></i><span>My Bookings</span></a>
            <a href="chat.jsp" class="nav-item active"><i class="fa-regular fa-comments"></i><span>Messages</span></a>
            <a href="profile.jsp" class="nav-item"><i class="fa-solid fa-user"></i><span>Profile</span></a>
            <a href="settings.jsp" class="nav-item"><i class="fa-solid fa-gear"></i><span>Settings</span></a>
        </div>
        <div class="sidebar-footer">
            <a href="LogoutServlet" class="nav-item"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-nav">
            <div class="profile-info">
                <div class="avatar"><%= user.substring(0, 1).toUpperCase() %></div>
                <div style="margin-left: 10px;">
                    <span style="font-weight: 600; display: block;"><%= user %></span>
                    <span style="font-size: 0.75rem; color: var(--text-muted);">Client</span>
                </div>
            </div>
        </div>

        <div class="chat-container">
            <div class="chat-list">
                <div class="chat-list-header">
                    <h3 style="font-size: 1.1rem;">My Advocates</h3>
                </div>
                <div class="conversations">
                    <%
                        boolean hasLawyers = false;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
                            PreparedStatement ps = con.prepareStatement("SELECT DISTINCT lawyer FROM bookings WHERE user_email=?");
                            ps.setString(1, user);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                                hasLawyers = true;
                                String lawyerName = rs.getString("lawyer");
                    %>
                                <div class="conversation-item" onclick="selectLawyer('<%= lawyerName %>')">
                                    <div class="conv-avatar"><i class="fa-solid fa-user-tie"></i></div>
                                    <div class="conv-details">
                                        <span class="conv-name"><%= lawyerName %></span>
                                        <span class="conv-msg">Click to start chatting...</span>
                                    </div>
                                </div>
                    <%
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                        if(!hasLawyers) {
                    %>
                        <div style="padding: 30px; text-align: center; color: var(--text-muted); font-size: 0.85rem;">
                            No advocates booked yet. Book one to start chatting!
                        </div>
                    <% } %>
                </div>
            </div>

            <div class="chat-window">
                <div class="chat-header">
                    <div class="conv-avatar" style="width: 40px; height: 40px;"><i class="fa-solid fa-user-tie"></i></div>
                    <h3 id="chat-lawyer-name">Select an Advocate</h3>
                </div>
                <div class="messages-area" id="msg-area">
                    <div style="text-align: center; color: var(--text-muted); font-size: 0.85rem; padding: 50px;">
                        Secure end-to-end encrypted messaging with your legal experts.
                    </div>
                </div>
                <div class="chat-input-area">
                    <input type="text" placeholder="Type your message..." id="msg-input" onkeypress="if(event.key === 'Enter') sendMsg()">
                    <button class="send-btn" onclick="sendMsg()">Send</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function selectLawyer(name) {
            document.querySelectorAll('.conversation-item').forEach(i => i.classList.remove('active'));
            document.getElementById('chat-lawyer-name').textContent = name;
            document.getElementById('msg-area').innerHTML = `
                <div class="message received">
                    Hello! I'm ${name}. How can I assist you with your case today?
                </div>
            `;
        }

        function sendMsg() {
            const input = document.getElementById('msg-input');
            const text = input.value.trim();
            if (text) {
                const area = document.getElementById('msg-area');
                area.insertAdjacentHTML('beforeend', `<div class="message sent">${text}</div>`);
                input.value = '';
                area.scrollTop = area.scrollHeight;
            }
        }
    </script>
</body>
</html>