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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/legal_db", "root", "root");

        PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name, email, password) VALUES(?, ?, ?)");

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);

        ps.executeUpdate();

        response.sendRedirect("login.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}

}
