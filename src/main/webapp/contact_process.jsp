<%@ page import="java.sql.*" %>
<%@ include file="includes/connect.jsp" %>
<%
    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String message = request.getParameter("message");

    // SQL Insert Statement
    String sql = "INSERT INTO contact (name, email, phone, message) VALUES (?, ?, ?, ?)";
    PreparedStatement stmt = null;

    try {
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, phone);
        stmt.setString(4, message);

        int rowsInserted = stmt.executeUpdate();
        if (rowsInserted > 0) {
            out.println("<script>alert('Your message has been sent successfully!'); window.location='contact.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to send message. Please try again.'); window.location='contact.jsp';</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
