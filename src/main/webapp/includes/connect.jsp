<%@ page import="java.sql.*" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/propertydb";
    String dbUser = "root";
    String dbPassword = "";
    
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        //out.println("DB Connected Successfully!"); // REMOVE this in production
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Database Connection Failed: " + e.getMessage());
    }
    pageContext.setAttribute("conn", conn, PageContext.APPLICATION_SCOPE);
%>
