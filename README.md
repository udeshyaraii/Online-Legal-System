# Online-Legal-System
A Java JSP/Servlet based Legal Consultation System that connects users with lawyers for online appointment booking, chat, and consultation management using MySQL and Apache Tomcat.
# Legal Consultation System

An online legal consultation platform developed using Java JSP, Servlets, and MySQL that allows users to connect with lawyers, book appointments, and manage consultations efficiently.

---

## Features

### User Module
- User Registration
- User Login/Logout
- Session Management
- View Lawyers
- Book Appointments
- View Bookings
- Chat Interface
- User Profile Management

### Lawyer Module
- Lawyer Registration
- Lawyer Login
- Lawyer Dashboard
- View Clients
- View Appointments
- Earnings Section
- Lawyer Profile Management

---

## Technologies Used

| Technology | Purpose |
|------------|---------|
| Java | Backend Logic |
| JSP | Frontend Pages |
| Servlets | Request Handling |
| MySQL | Database |
| JDBC | Database Connectivity |
| Apache Tomcat | Web Server |
| HTML/CSS | UI Design |
| Eclipse IDE | Development Environment |

---

## Project Structure

```text
src/
 └── com/legal/
      ├── BookServlet.java
      ├── DeleteServlet.java
      ├── LawyerLoginServlet.java
      ├── LawyerRegisterServlet.java
      ├── LoginServlet.java
      ├── LogoutServlet.java
      └── RegisterServlet.java

WebContent/
 ├── index.jsp
 ├── login.jsp
 ├── register.jsp
 ├── dashboard.jsp
 ├── profile.jsp
 ├── settings.jsp
 ├── chat.jsp
 ├── lawyer_dashboard.jsp
 ├── lawyer_login.jsp
 ├── lawyer_register.jsp
 ├── lawyer_profile.jsp
 ├── lawyer_clients.jsp
 ├── lawyer_appointments.jsp
 ├── lawyer_chat.jsp
 ├── lawyer_earnings.jsp
 └── viewBookings.jsp
```

---

## Database Configuration

Database Name:

```sql
legal_db
```

Default JDBC Configuration:

```java
jdbc:mysql://localhost:3306/legal_db
Username: root
Password: root
```

---

## Modules Overview

### Authentication Module
Handles registration, login, logout, and session management for both users and lawyers.

### Appointment Booking Module
Allows users to book lawyers and manage appointments.

### Lawyer Management Module
Provides lawyers with dashboards, appointment details, client information, and earnings tracking.

### Chat Module
Provides communication interface between lawyers and users.

---

## Setup Instructions

### 1. Clone Repository

```bash
git clone https://github.com/your-username/Legal-Consultation-System.git
```

### 2. Import Project
Import the project into Eclipse IDE.

### 3. Configure Apache Tomcat
- Install Apache Tomcat
- Add Tomcat Server in Eclipse

### 4. Configure MySQL
- Create database:
  
```sql
CREATE DATABASE legal_db;
```

- Import the SQL file into MySQL.

### 5. Add JDBC Driver
Add:
```text
mysql-connector-j-9.7.0.jar
```

to project libraries.

### 6. Run Project
Run the project on Apache Tomcat Server.

---

## Future Enhancements

- Real-time Chat System
- Video Consultation
- Payment Gateway Integration
- Lawyer Rating System
- Admin Panel
- Case Tracking System
- Email Notifications

---

## Learning Outcomes

- JSP and Servlet Development
- JDBC Connectivity
- Session Management
- CRUD Operations
- MVC Architecture Basics
- Database Design
- Web Application Deployment

---

## Author

Prateek

---

## License

This project is developed for educational purposes.
