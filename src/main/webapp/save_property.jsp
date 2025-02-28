<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ include file="../includes/connect.jsp"%>

<%
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String type = request.getParameter("type");
    double price = Double.parseDouble(request.getParameter("price"));
    String location = request.getParameter("location");
    int size = Integer.parseInt(request.getParameter("size"));
    int bedrooms = Integer.parseInt(request.getParameter("bedrooms"));
    int bathrooms = Integer.parseInt(request.getParameter("bathrooms"));
    String status = request.getParameter("status");
    String image = request.getParameter("image");

    PreparedStatement ps = conn.prepareStatement("INSERT INTO properties (title, description, type, price, location, size, bedrooms, bathrooms, status, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    ps.setString(1, title);
    ps.setString(2, description);
    ps.setString(3, type);
    ps.setDouble(4, price);
    ps.setString(5, location);
    ps.setInt(6, size);
    ps.setInt(7, bedrooms);
    ps.setInt(8, bathrooms);
    ps.setString(9, status);
    ps.setString(10, image);
    ps.executeUpdate();
    
    response.sendRedirect("manage-properties.jsp?msg=success");
%>
