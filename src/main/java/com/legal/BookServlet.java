package com.legal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String lawyer = request.getParameter("lawyer");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String user = (String) session.getAttribute("user");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/legal_db", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings(user_email, lawyer, lawyer_email) VALUES(?, ?, ?)");

            ps.setString(1, user);
            ps.setString(2, lawyer);
            ps.setString(3, "lawyer@email.com"); // temporary (we'll improve later)

            ps.executeUpdate();

            response.sendRedirect("dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error_msg", "Booking failed: " + e.getMessage());
            response.sendRedirect("dashboard.jsp?error=true");
        }
    }

}
