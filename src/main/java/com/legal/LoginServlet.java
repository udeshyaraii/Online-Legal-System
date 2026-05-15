package com.legal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/legal_db", "root", "root");

        PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?");

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);

            response.sendRedirect("dashboard.jsp");
        }else {
            response.getWriter().println("Invalid credentials");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}

}
