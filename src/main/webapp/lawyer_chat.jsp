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
    <title>Client Messages | LegalConnect Premium</title>
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
            height: 100vh;
            overflow: hidden;
        }

        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--surface-dark);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
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

        /* Chat Layout */
        .chat-layout {
            flex: 1;
            display: flex;
        }

        .chat-list {
            width: 350px;
            background: var(--surface-dark);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
        }

        .chat-list-header {
            padding: 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .chat-list-header h3 {
            font-size: 1.25rem;
            margin-bottom: 20px;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            background: var(--surface-light);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            color: white;
            outline: none;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .conversations {
            flex: 1;
            overflow-y: auto;
        }

        .conv-item {
            padding: 20px 30px;
            display: flex;
            gap: 15px;
            cursor: pointer;
            border-bottom: 1px solid rgba(255, 255, 255, 0.03);
            transition: 0.2s;
        }

        .conv-item:hover, .conv-item.active {
            background: var(--surface-light);
        }

        .client-avatar {
            width: 50px;
            height: 50px;
            background: #3b82f6;
            border-radius: 14px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 700;
            flex-shrink: 0;
        }

        .conv-info {
            flex: 1;
            overflow: hidden;
        }

        .conv-info h4 {
            font-size: 0.95rem;
            margin-bottom: 4px;
            display: flex;
            justify-content: space-between;
        }

        .conv-info h4 span {
            font-size: 0.75rem;
            font-weight: 400;
            color: var(--text-muted);
        }

        .conv-info p {
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
            background: var(--bg-dark);
        }

        .chat-header {
            padding: 20px 40px;
            background: var(--surface-dark);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-header-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .status-online {
            font-size: 0.75rem;
            color: #10b981;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .status-online::before {
            content: '';
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
        }

        .messages-container {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .msg {
            max-width: 60%;
            padding: 15px 20px;
            border-radius: 20px;
            font-size: 0.95rem;
            line-height: 1.5;
        }

        .msg.received {
            background: var(--surface-dark);
            align-self: flex-start;
            border-bottom-left-radius: 4px;
            border: 1px solid var(--border-color);
        }

        .msg.sent {
            background: var(--primary-gold);
            color: #000;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
            font-weight: 500;
        }

        .msg-time {
            font-size: 0.75rem;
            margin-top: 8px;
            opacity: 0.7;
            display: block;
        }

        .input-area {
            padding: 30px 40px;
            background: var(--surface-dark);
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .input-area input {
            flex: 1;
            padding: 15px 25px;
            background: var(--surface-light);
            border: 1px solid var(--border-color);
            border-radius: 15px;
            color: white;
            outline: none;
            font-size: 0.95rem;
        }

        .send-btn {
            width: 50px;
            height: 50px;
            background: var(--primary-gold);
            color: #000;
            border: none;
            border-radius: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            font-size: 1.2rem;
            transition: 0.3s;
        }

        .send-btn:hover {
            transform: scale(1.05);
            background: #a68546;
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
            <a href="lawyer_chat.jsp" class="nav-item active">
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

    <!-- Chat Layout -->
    <div class="chat-layout">
        <!-- List -->
        <div class="chat-list">
            <div class="chat-list-header">
                <h3>Client Messages</h3>
                <div class="search-box">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" placeholder="Search clients...">
                </div>
            </div>
            <div class="conversations">
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
                            String name = client.split("@")[0];
                %>
                            <div class="conv-item">
                                <div class="client-avatar"><%= name.substring(0, 1).toUpperCase() %></div>
                                <div class="conv-info">
                                    <h4><%= name %> <span>Just now</span></h4>
                                    <p>I've booked a session with you.</p>
                                </div>
                            </div>
                <%
                        }
                    } catch(Exception e) { e.printStackTrace(); }
                    if(!hasClients) {
                %>
                    <div style="text-align: center; padding: 40px; color: var(--text-muted); font-size: 0.9rem;">No clients have booked you yet.</div>
                <% } %>
            </div>
        </div>

        <!-- Window -->
        <div class="chat-window">
            <div class="chat-header">
                <div class="chat-header-user">
                    <div class="client-avatar">U</div>
                    <div>
                        <h4 style="font-size: 1.1rem;" id="active-client-name">Select a Client</h4>
                        <span class="status-online">System Ready</span>
                    </div>
                </div>
            </div>

            <div class="messages-container" id="msg-container">
                <div class="msg received">
                    Welcome to the LegalConnect Secure Chat. Select a client from the left to start communication.
                    <span class="msg-time">System</span>
                </div>
            </div>

            <div class="input-area">
                <i class="fa-solid fa-paperclip" style="color: var(--text-muted); cursor: pointer; font-size: 1.2rem;"></i>
                <input type="text" placeholder="Type your professional response..." id="chat-input" onkeypress="if(event.key === 'Enter') sendProfessionalMsg()">
                <button class="send-btn" onclick="sendProfessionalMsg()">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        // Simple UI logic to handle conversation switching
        document.querySelectorAll('.conv-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.conv-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
                const name = this.querySelector('h4').firstChild.textContent.trim();
                document.getElementById('active-client-name').textContent = name;
                document.getElementById('msg-container').innerHTML = `
                    <div class="msg received">
                        Hello Adv. Sharma, I have booked a consultation and would like to discuss my case.
                        <span class="msg-time">Just now</span>
                    </div>
                `;
            });
        });

        function sendProfessionalMsg() {
            const input = document.getElementById('chat-input');
            const text = input.value.trim();
            if (text) {
                const container = document.getElementById('msg-container');
                const now = new Date();
                const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

                const msgHTML = `
                    <div class="msg sent">
                        ${text}
                        <span class="msg-time">${timeStr}</span>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', msgHTML);
                input.value = '';
                container.scrollTop = container.scrollHeight;
            }
        }
    </script>
</body>
</html>
