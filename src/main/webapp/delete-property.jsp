<%-- <%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/connect.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM properties WHERE id=?");
        ps.setInt(1, id);

        int rowsDeleted = ps.executeUpdate();

        if (rowsDeleted > 0) {
            response.sendRedirect("manage-properties.jsp?msg=deleted");
        } else {
            response.sendRedirect("manage-properties.jsp?msg=error");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manage-properties.jsp?msg=error");
    }
%>
 --%>
 
 
 <%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/connect.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM properties WHERE id=?");
        ps.setInt(1, id);

        int rowsDeleted = ps.executeUpdate();

        if (rowsDeleted > 0) {
            out.print("success");  // Send success response to AJAX
        } else {
            out.print("error");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("error");
    }
%>
 