<!--AUTh
  -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Hardcoded admin credentials (for testing purposes)
    String adminUsername = "admin";
    String adminPassword = "admin";

    if (username.equals(adminUsername) && password.equals(adminPassword)) {
        session.setAttribute("adminLoggedIn", "true");
        response.sendRedirect("admin-dashboard.jsp");
    } else {
        out.println("<script>alert('Invalid Username or Password!'); location.href='adminlogin.jsp';</script>");
    }
%>
