package com.legal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/legal_db", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM bookings WHERE id=?");

            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("viewBookings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error_msg", "Delete failed: " + e.getMessage());
            response.sendRedirect("viewBookings.jsp?error=true");
        }
    }

}
