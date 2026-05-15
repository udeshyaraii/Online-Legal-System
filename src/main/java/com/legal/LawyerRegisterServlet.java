package com.legal;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LawyerRegisterServlet")
public class LawyerRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String experience = request.getParameter("experience");
        String specialization = request.getParameter("specialization");
        String languages = request.getParameter("languages");
        String fee = request.getParameter("fee");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO lawyers(name, email, password, experience, specialization, languages, fee) VALUES(?, ?, ?, ?, ?, ?, ?)");

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, experience);
            ps.setString(5, specialization);
            ps.setString(6, languages);
            ps.setString(7, fee);

            ps.executeUpdate();
            response.sendRedirect("lawyer_login.jsp?msg=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("lawyer_register.jsp?error=true");
        }
    }
}
