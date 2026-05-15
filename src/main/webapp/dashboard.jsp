<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <% if(session.getAttribute("user")==null){ response.sendRedirect("login.jsp"); return; } String user=(String)
        session.getAttribute("user"); %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>Dashboard | Legal Consultation</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --primary-color: #1d1e1f;
                    /* Deep Navy */
                    --secondary-color: #f59e0b;
                    /* Amber/Gold accent */
                    --bg-color: #f3f4f6;
                    /* Light gray background */
                    --surface-color: #ffffff;
                    /* White cards */
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
                    letter-spacing: 0.5px;
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
                    transition: all 0.3s ease;
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

                /* Main Content Styles */
                .main-content {
                    flex: 1;
                    margin-left: var(--sidebar-width);
                    display: flex;
                    flex-direction: column;
                }

                /* Top Navbar */
                .top-nav {
                    height: 70px;
                    background-color: var(--surface-color);
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 0 30px;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                    position: sticky;
                    top: 0;
                    z-index: 5;
                }

                .search-bar {
                    display: flex;
                    align-items: center;
                    background-color: var(--bg-color);
                    border-radius: 20px;
                    padding: 8px 16px;
                    width: 300px;
                }

                .search-bar input {
                    border: none;
                    background: transparent;
                    outline: none;
                    padding-left: 10px;
                    width: 100%;
                    color: var(--text-main);
                }

                .user-profile {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .notification {
                    position: relative;
                    cursor: pointer;
                    color: var(--text-muted);
                }

                .notification .badge {
                    position: absolute;
                    top: -5px;
                    right: -5px;
                    background-color: #ef4444;
                    color: white;
                    font-size: 0.6rem;
                    padding: 2px 5px;
                    border-radius: 50%;
                    font-weight: bold;
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

                /* Dashboard Body */
                .dashboard-body {
                    padding: 30px;
                    flex: 1;
                }

                .welcome-banner {
                    background: linear-gradient(135deg, var(--primary-color) 0%, #3b82f6 100%);
                    border-radius: 16px;
                    padding: 30px;
                    color: white;
                    margin-bottom: 30px;
                    box-shadow: 0 10px 20px rgba(30, 58, 138, 0.2);
                    position: relative;
                    overflow: hidden;
                }

                .welcome-banner h1 {
                    font-size: 1.8rem;
                    margin-bottom: 10px;
                }

                .welcome-banner p {
                    color: rgba(255, 255, 255, 0.8);
                    max-width: 600px;
                }

                .banner-decoration {
                    position: absolute;
                    right: -20px;
                    top: -40px;
                    font-size: 150px;
                    opacity: 0.1;
                }

                /* Filters */
                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .filters {
                    display: flex;
                    gap: 10px;
                    margin-bottom: 20px;
                }

                .filter-btn {
                    padding: 8px 16px;
                    border: 1px solid var(--border-color);
                    background-color: var(--surface-color);
                    border-radius: 20px;
                    cursor: pointer;
                    font-weight: 500;
                    color: var(--text-muted);
                    transition: all 0.2s;
                }

                .filter-btn.active,
                .filter-btn:hover {
                    background-color: var(--primary-color);
                    color: white;
                    border-color: var(--primary-color);
                }

                /* Cards */
                .cards-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                    gap: 25px;
                }

                .card {
                    background: var(--surface-color);
                    border-radius: 16px;
                    overflow: hidden;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                    border: 1px solid var(--border-color);
                    display: flex;
                    flex-direction: column;
                }

                .card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.1);
                }

                .card-header {
                    padding: 20px;
                    display: flex;
                    align-items: flex-start;
                    gap: 15px;
                    border-bottom: 1px solid var(--border-color);
                    position: relative;
                }

                .lawyer-avatar {
                    width: 60px;
                    height: 60px;
                    border-radius: 12px;
                    background-color: #e0e7ff;
                    color: var(--primary-color);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-size: 1.5rem;
                }

                .lawyer-info h3 {
                    font-size: 1.1rem;
                    color: var(--text-main);
                    margin-bottom: 5px;
                }

                .lawyer-category {
                    font-size: 0.85rem;
                    color: var(--text-muted);
                    background: var(--bg-color);
                    padding: 3px 8px;
                    border-radius: 10px;
                    display: inline-block;
                    margin-bottom: 5px;
                }

                .rating {
                    color: var(--secondary-color);
                    font-size: 0.85rem;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 4px;
                }

                .rating span {
                    color: var(--text-muted);
                    font-weight: normal;
                }

                .status-badge {
                    position: absolute;
                    top: 20px;
                    right: 20px;
                    font-size: 0.75rem;
                    padding: 4px 8px;
                    border-radius: 12px;
                    font-weight: 600;
                }

                .status-available {
                    background-color: #dcfce7;
                    color: #166534;
                }

                .status-busy {
                    background-color: #fee2e2;
                    color: #991b1b;
                }

                .card-body {
                    padding: 20px;
                    flex: 1;
                }

                .info-row {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 10px;
                    font-size: 0.9rem;
                }

                .info-label {
                    color: var(--text-muted);
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }

                .info-value {
                    font-weight: 600;
                    color: var(--text-main);
                }

                .card-footer {
                    padding: 20px;
                    background-color: #f9fafb;
                    border-top: 1px solid var(--border-color);
                }

                .book-btn {
                    width: 100%;
                    padding: 12px;
                    border: none;
                    border-radius: 8px;
                    background-color: var(--primary-color);
                    color: white;
                    font-weight: 600;
                    cursor: pointer;
                    transition: background-color 0.2s;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 8px;
                }

                .book-btn:hover {
                    background-color: #1e40af;
                }

                /* Dropdown Styles */
                .user-profile {
                    position: relative;
                }

                .dropdown-menu {
                    display: none;
                    position: absolute;
                    top: 100%;
                    right: 0;
                    margin-top: 15px;
                    background: var(--surface-color);
                    min-width: 220px;
                    border-radius: 12px;
                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                    border: 1px solid var(--border-color);
                    z-index: 100;
                    overflow: hidden;
                }

                .dropdown-menu.show {
                    display: block;
                }

                .dropdown-header {
                    padding: 15px;
                    font-weight: 600;
                    border-bottom: 1px solid var(--border-color);
                    color: var(--text-main);
                    font-size: 0.95rem;
                }

                .dropdown-item {
                    padding: 12px 15px;
                    color: var(--text-main);
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    transition: 0.2s;
                    font-size: 0.9rem;
                    cursor: pointer;
                }

                .dropdown-item:hover {
                    background-color: var(--bg-color);
                }

                .dropdown-item i {
                    width: 20px;
                    margin-right: 10px;
                    color: var(--text-muted);
                    font-size: 1rem;
                    text-align: center;
                }

                .text-success {
                    color: #16a34a !important;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <i class="fa-solid fa-scale-balanced fa-lg text-white"></i>
                    <h2>LegalConnect</h2>
                </div>

                <div class="sidebar-nav">
                    <a href="dashboard.jsp" class="nav-item active">
                        <i class="fa-solid fa-house"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="viewBookings.jsp" class="nav-item">
                        <i class="fa-solid fa-calendar-check"></i>
                        <span>My Bookings</span>
                    </a>
                    <a href="profile.jsp" class="nav-item">
                        <i class="fa-solid fa-user"></i>
                        <span>Profile</span>
                    </a>
                    <a href="settings.jsp" class="nav-item">
                        <i class="fa-solid fa-gear"></i>
                        <span>Settings</span>
                    </a>
                </div>

                <div class="sidebar-footer">
                    <a href="LogoutServlet" class="nav-item" style="padding: 10px 0;">
                        <i class="fa-solid fa-right-from-bracket"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">

                <!-- Top Navbar -->
                <div class="top-nav">
                    <div class="search-bar">
                        <i class="fa-solid fa-magnifying-glass text-muted"></i>
                        <input type="text" placeholder="Search lawyers, categories...">
                    </div>

                    <div class="user-profile">
                        <div class="notification" onclick="toggleDropdown('notif-dropdown', event)"
                            style="position: relative;">
                            <i class="fa-regular fa-bell fa-lg"></i>
                            <span class="badge">3</span>

                            <div class="dropdown-menu" id="notif-dropdown">
                                <div class="dropdown-header">Notifications</div>
                                <a href="#" class="dropdown-item"><i class="fa-solid fa-check-circle text-success"></i>
                                    Booking Confirmed</a>
                                <a href="#" class="dropdown-item"><i class="fa-solid fa-envelope"></i> New message
                                    received</a>
                                <a href="#" class="dropdown-item"><i class="fa-solid fa-circle-info"></i> Welcome to
                                    LegalConnect!</a>
                            </div>
                        </div>
                        <div class="profile-info" onclick="toggleDropdown('profile-dropdown', event)"
                            style="position: relative;">
                            <div class="avatar">
                                <%= user !=null && user.length()> 0 ? user.substring(0, 1).toUpperCase() : "U" %>
                            </div>
                            <div>
                                <span style="display: block; font-weight: 600; font-size: 0.9rem;">
                                    <%= user %>
                                </span>
                                <span
                                    style="display: block; font-size: 0.75rem; color: var(--text-muted);">Client</span>
                            </div>
                            <i class="fa-solid fa-chevron-down"
                                style="font-size: 0.8rem; color: var(--text-muted); margin-left: 5px;"></i>

                            <div class="dropdown-menu" id="profile-dropdown">
                                <a href="profile.jsp" class="dropdown-item"><i class="fa-solid fa-user"></i> My
                                    Profile</a>
                                <a href="settings.jsp" class="dropdown-item"><i class="fa-solid fa-gear"></i>
                                    Settings</a>
                                <div style="border-top: 1px solid var(--border-color); margin: 5px 0;"></div>
                                <a href="LogoutServlet" class="dropdown-item" style="color: #dc2626;"><i
                                        class="fa-solid fa-right-from-bracket" style="color: #dc2626;"></i> Logout</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dashboard Body -->
                <div class="dashboard-body">

                    <% if (session.getAttribute("error_msg") != null) { %>
                        <div style="background-color: #fee2e2; color: #991b1b; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: 500;">
                            <i class="fa-solid fa-circle-exclamation"></i> <%= session.getAttribute("error_msg") %>
                        </div>
                    <% session.removeAttribute("error_msg"); } %>

                    <!-- Welcome Banner -->
                    <div class="welcome-banner">
                        <i class="fa-solid fa-gavel banner-decoration"></i>
                        <h1>Welcome back, <%= user %>!</h1>
                        <p>Find the right legal expert for your needs. Book a consultation with top-rated lawyers
                            specializing in various fields.</p>
                    </div>

                    <!-- Section Header & Filters -->
                    <div class="section-header" style="margin-top: 20px;">
                        <h2 style="font-size: 1.4rem; font-weight: 600;">Recently Joined Experts</h2>
                        <span style="font-size: 0.85rem; color: #16a34a; font-weight: 600;"><i class="fa-solid fa-bolt"></i> Live Updates</span>
                    </div>

                    <div class="cards-grid" style="margin-bottom: 40px;">
                        <!-- New Lawyer Card -->
                        <div class="card" style="border-top: 4px solid var(--secondary-color);">
                            <div class="card-header">
                                <div class="lawyer-avatar" style="background-color: #fff7ed; color: var(--secondary-color);">
                                    <i class="fa-solid fa-user-tie"></i>
                                </div>
                                <div class="lawyer-info">
                                    <h3>Adv. Ishaan Malhotra</h3>
                                    <span class="lawyer-category">Taxation Law</span>
                                    <div class="rating">
                                        <i class="fa-solid fa-star"></i> NEW <span>(0 reviews)</span>
                                    </div>
                                </div>
                                <span class="status-badge status-available" style="background-color: #fef9c3; color: #854d0e;">Just Joined</span>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-briefcase"></i> Experience</span>
                                    <span class="info-value">12 Years</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-language"></i> Languages</span>
                                    <span class="info-value">English, Punjabi</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="book-btn" onclick="window.location.href='chat.jsp'">
                                    <i class="fa-regular fa-comments"></i> Chat Now
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="section-header">
                        <h2 style="font-size: 1.4rem; font-weight: 600;">Available Experts</h2>
                    </div>

                    <div class="filters">
                        <button class="filter-btn active">All Categories</button>
                        <button class="filter-btn">Criminal Law</button>
                        <button class="filter-btn">Family Law</button>
                        <button class="filter-btn">Corporate Law</button>
                        <button class="filter-btn">Property Law</button>
                    </div>

                    <!-- Lawyer Cards Grid -->
                    <div class="cards-grid">

                        <!-- Card 1 -->
                        <div class="card">
                            <div class="card-header">
                                <div class="lawyer-avatar">
                                    <i class="fa-solid fa-user-tie"></i>
                                </div>
                                <div class="lawyer-info">
                                    <h3>Adv. Rajiv Sharma</h3>
                                    <span class="lawyer-category">Criminal Lawyer</span>
                                    <div class="rating">
                                        <i class="fa-solid fa-star"></i> 4.9 <span>(120 reviews)</span>
                                    </div>
                                </div>
                                <span class="status-badge status-available">Available Now</span>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-briefcase"></i> Experience</span>
                                    <span class="info-value">15+ Years</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-language"></i> Languages</span>
                                    <span class="info-value">English, Hindi</span>
                                </div>
                                <div class="info-row" style="margin-top: 15px;">
                                    <span class="info-label"
                                        style="font-size: 1.1rem; color: var(--text-main); font-weight: 600;">Consultation
                                        Fee</span>
                                    <span class="info-value"
                                        style="font-size: 1.2rem; color: var(--primary-color);">₹500</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <form action="BookServlet" method="post">
                                    <input type="hidden" name="lawyer" value="Criminal Lawyer">
                                    <button class="book-btn">
                                        <i class="fa-regular fa-calendar-plus"></i> Book Appointment
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Card 2 -->
                        <div class="card">
                            <div class="card-header">
                                <div class="lawyer-avatar">
                                    <i class="fa-solid fa-user-tie"></i>
                                </div>
                                <div class="lawyer-info">
                                    <h3>Adv. Neha Gupta</h3>
                                    <span class="lawyer-category">Family Lawyer</span>
                                    <div class="rating">
                                        <i class="fa-solid fa-star"></i> 4.7 <span>(85 reviews)</span>
                                    </div>
                                </div>
                                <span class="status-badge status-available">Available Now</span>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-briefcase"></i> Experience</span>
                                    <span class="info-value">8 Years</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-language"></i> Languages</span>
                                    <span class="info-value">English, Hindi</span>
                                </div>
                                <div class="info-row" style="margin-top: 15px;">
                                    <span class="info-label"
                                        style="font-size: 1.1rem; color: var(--text-main); font-weight: 600;">Consultation
                                        Fee</span>
                                    <span class="info-value"
                                        style="font-size: 1.2rem; color: var(--primary-color);">₹300</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <form action="BookServlet" method="post">
                                    <input type="hidden" name="lawyer" value="Family Lawyer">
                                    <button class="book-btn">
                                        <i class="fa-regular fa-calendar-plus"></i> Book Appointment
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Card 3 -->
                        <div class="card">
                            <div class="card-header">
                                <div class="lawyer-avatar">
                                    <i class="fa-solid fa-user-tie"></i>
                                </div>
                                <div class="lawyer-info">
                                    <h3>Adv. Vikram Singh</h3>
                                    <span class="lawyer-category">Corporate Lawyer</span>
                                    <div class="rating">
                                        <i class="fa-solid fa-star"></i> 4.8 <span>(210 reviews)</span>
                                    </div>
                                </div>
                                <span class="status-badge status-busy">Busy</span>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-briefcase"></i> Experience</span>
                                    <span class="info-value">12+ Years</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-language"></i> Languages</span>
                                    <span class="info-value">English</span>
                                </div>
                                <div class="info-row" style="margin-top: 15px;">
                                    <span class="info-label"
                                        style="font-size: 1.1rem; color: var(--text-main); font-weight: 600;">Consultation
                                        Fee</span>
                                    <span class="info-value"
                                        style="font-size: 1.2rem; color: var(--primary-color);">₹800</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <form action="BookServlet" method="post">
                                    <input type="hidden" name="lawyer" value="Corporate Lawyer">
                                    <button class="book-btn">
                                        <i class="fa-regular fa-calendar-plus"></i> Book Appointment
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Card 4 -->
                        <div class="card">
                            <div class="card-header">
                                <div class="lawyer-avatar">
                                    <i class="fa-solid fa-user-tie"></i>
                                </div>
                                <div class="lawyer-info">
                                    <h3>Adv. Priya Menon</h3>
                                    <span class="lawyer-category">Property Lawyer</span>
                                    <div class="rating">
                                        <i class="fa-solid fa-star"></i> 4.6 <span>(45 reviews)</span>
                                    </div>
                                </div>
                                <span class="status-badge status-available">Available Now</span>
                            </div>
                            <div class="card-body">
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-briefcase"></i> Experience</span>
                                    <span class="info-value">10 Years</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label"><i class="fa-solid fa-language"></i> Languages</span>
                                    <span class="info-value">English, Tamil, Hindi</span>
                                </div>
                                <div class="info-row" style="margin-top: 15px;">
                                    <span class="info-label"
                                        style="font-size: 1.1rem; color: var(--text-main); font-weight: 600;">Consultation
                                        Fee</span>
                                    <span class="info-value"
                                        style="font-size: 1.2rem; color: var(--primary-color);">₹600</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <form action="BookServlet" method="post">
                                    <input type="hidden" name="lawyer" value="Property Lawyer">
                                    <button class="book-btn">
                                        <i class="fa-regular fa-calendar-plus"></i> Book Appointment
                                    </button>
                                </form>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Dropdown functionality
                    window.toggleDropdown = function (id, event) {
                        event.stopPropagation();
                        const dropdown = document.getElementById(id);

                        // close all other dropdowns
                        document.querySelectorAll('.dropdown-menu').forEach(menu => {
                            if (menu.id !== id) menu.classList.remove('show');
                        });

                        dropdown.classList.toggle('show');
                    };

                    // Close dropdowns when clicking outside
                    document.addEventListener('click', function (e) {
                        document.querySelectorAll('.dropdown-menu').forEach(menu => {
                            menu.classList.remove('show');
                        });
                    });

                    const searchInput = document.querySelector('.search-bar input');
                    const filterBtns = document.querySelectorAll('.filter-btn');
                    const cards = document.querySelectorAll('.card');

                    // Search functionality
                    searchInput.addEventListener('input', function (e) {
                        const term = e.target.value.toLowerCase();
                        cards.forEach(card => {
                            const name = card.querySelector('h3').textContent.toLowerCase();
                            const category = card.querySelector('.lawyer-category').textContent.toLowerCase();

                            if (name.includes(term) || category.includes(term)) {
                                card.style.display = 'flex';
                            } else {
                                card.style.display = 'none';
                            }
                        });

                        // Reset category buttons
                        filterBtns.forEach(btn => btn.classList.remove('active'));
                        filterBtns[0].classList.add('active'); // All Categories
                    });

                    // Category filtering
                    filterBtns.forEach(btn => {
                        btn.addEventListener('click', function () {
                            // Active state
                            filterBtns.forEach(b => b.classList.remove('active'));
                            this.classList.add('active');

                            const category = this.textContent.trim();
                            searchInput.value = ''; // clear search

                            const baseCategory = category.replace(' Law', '').replace('All Categories', 'All');

                            cards.forEach(card => {
                                const cardCat = card.querySelector('.lawyer-category').textContent.trim();
                                if (baseCategory === 'All' || cardCat.includes(baseCategory)) {
                                    card.style.display = 'flex';
                                } else {
                                    card.style.display = 'none';
                                }
                            });
                        });
                    });
                });
            </script>
        </body>

        </html>