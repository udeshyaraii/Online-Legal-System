<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% if(session.getAttribute("user")==null){ response.sendRedirect("login.jsp"); return; } String user=(String)
        session.getAttribute("user"); %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Profile | LegalConnect</title>
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
                    min-height: 100vh;
                }

                /* Sidebar Styles */
                .sidebar {
                    width: var(--sidebar-width);
                    background-color: var(--primary-color);
                    color: white;
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    height: 100vh;
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

                .nav-item:hover,
                .nav-item.active {
                    background-color: rgba(255, 255, 255, 0.1);
                    color: white;
                    border-left: 4px solid var(--secondary-color);
                }

                .nav-item i {
                    font-size: 1.1rem;
                    width: 20px;
                    text-align: center;
                }

                .sidebar-footer {
                    padding: 20px 24px;
                    border-top: 1px solid rgba(255, 255, 255, 0.1);
                }

                /* Main Content */
                .main-content {
                    flex: 1;
                    margin-left: var(--sidebar-width);
                    display: flex;
                    flex-direction: column;
                }

                .top-nav {
                    height: 70px;
                    background-color: var(--surface-color);
                    display: flex;
                    justify-content: flex-end;
                    align-items: center;
                    padding: 0 30px;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                    position: sticky;
                    top: 0;
                    z-index: 5;
                }

                .profile-info {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    cursor: pointer;
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

                /* Content Body */
                .dashboard-body {
                    padding: 30px;
                    flex: 1;
                    max-width: 800px;
                }

                .section-header {
                    margin-bottom: 20px;
                    font-size: 1.5rem;
                    font-weight: 600;
                }

                .profile-card {
                    background: var(--surface-color);
                    border-radius: 16px;
                    padding: 30px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                    border: 1px solid var(--border-color);
                }

                .profile-header {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                    border-bottom: 1px solid var(--border-color);
                    padding-bottom: 20px;
                    margin-bottom: 20px;
                }

                .profile-avatar {
                    width: 80px;
                    height: 80px;
                    border-radius: 50%;
                    background-color: var(--primary-color);
                    color: white;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-size: 2rem;
                    font-weight: bold;
                }

                .profile-name {
                    font-size: 1.4rem;
                    font-weight: 600;
                    margin-bottom: 5px;
                }

                .profile-role {
                    color: var(--text-muted);
                    font-size: 0.9rem;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 500;
                    font-size: 0.9rem;
                }

                .form-group input {
                    width: 100%;
                    padding: 10px 15px;
                    border: 1px solid var(--border-color);
                    border-radius: 8px;
                    font-family: 'Inter';
                    outline: none;
                }

                .form-group input:disabled {
                    background-color: var(--bg-color);
                    color: var(--text-muted);
                    cursor: not-allowed;
                }

                .btn {
                    padding: 10px 20px;
                    background-color: var(--primary-color);
                    color: white;
                    border: none;
                    border-radius: 8px;
                    font-weight: 500;
                    cursor: pointer;
                    transition: 0.2s;
                }

                .btn:hover {
                    background-color: #1e40af;
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
                    <a href="viewBookings.jsp" class="nav-item"><i class="fa-solid fa-calendar-check"></i><span>My
                            Bookings</span></a>
                    <a href="chat.jsp" class="nav-item"><i class="fa-regular fa-comments"></i><span>Messages</span></a>
                    <a href="profile.jsp" class="nav-item active"><i
                            class="fa-solid fa-user"></i><span>Profile</span></a>
                    <a href="settings.jsp" class="nav-item"><i class="fa-solid fa-gear"></i><span>Settings</span></a>
                </div>
                <div class="sidebar-footer"><a href="LogoutServlet" class="nav-item" style="padding: 10px 0;"><i
                            class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></div>
            </div>

            <div class="main-content">
                <div class="top-nav">
                    <div class="profile-info">
                        <div class="avatar">
                            <%= user !=null && user.length()> 0 ? user.substring(0, 1).toUpperCase() : "U" %>
                        </div>
                        <div>
                            <span style="display: block; font-weight: 600; font-size: 0.9rem;">
                                <%= user %>
                            </span>
                            <span style="display: block; font-size: 0.75rem; color: var(--text-muted);">Client</span>
                        </div>
                    </div>
                </div>

                <div class="dashboard-body">
                    <h2 class="section-header">My Profile</h2>
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <%= user !=null && user.length()> 0 ? user.substring(0, 1).toUpperCase() : "U" %>
                            </div>
                            <div>
                                <div class="profile-name">User Account</div>
                                <div class="profile-role">Registered Client</div>
                            </div>
                        </div>
                        <form action="#"
                            onsubmit="event.preventDefault(); alert('Profile updated successfully! (Mock)');">
                            <div class="form-group">
                                <label>Email Address (Cannot be changed)</label>
                                <input type="email" value="<%= user %>" disabled>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" placeholder="+91 xxxxx xxxxx">
                            </div>
                            <div class="form-group">
                                <label>Location</label>
                                <input type="text" placeholder="City, State">
                            </div>
                            <button type="submit" class="btn">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </body>

        </html>