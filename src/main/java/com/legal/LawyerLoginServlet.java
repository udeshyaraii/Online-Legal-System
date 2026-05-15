package com.legal;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LawyerLoginServlet")
public class LawyerLoginServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/legal_db", "root", "root");

    PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM lawyers WHERE email=? AND password=?");

    ps.setString(1, email);
    ps.setString(2, password);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        HttpSession session = request.getSession();
        session.setAttribute("lawyer", email);
        response.sendRedirect("lawyer_dashboard.jsp");
    } else {
        response.sendRedirect("lawyer_login.jsp");
    }

} catch(Exception e){
    e.printStackTrace();
}

}
}
