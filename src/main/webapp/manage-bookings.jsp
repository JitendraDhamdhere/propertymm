<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ include file="../includes/connect.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Booking</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid black;
        padding: 10px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>

    <div class="container mt-4">
        <h2 class="text-center mb-4">Manage Bookings</h2>

        <!-- Search Box -->
        <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search by ID, Property Name, User Name, Date, or Status...">

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Property Name</th>
                    <th>User Name</th>
                    <th>Booking Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="bookingTable">
                <%
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    // Join bookings, users, and properties tables to fetch names
                    String query = "SELECT b.id, p.title AS property_name, u.fullname AS user_name, b.booking_date, b.status " +
                                   "FROM bookings b " +
                                   "JOIN properties p ON b.property_id = p.id " +
                                   "JOIN users u ON b.user_id = u.id";
                                   
                    pst = conn.prepareStatement(query);
                    rs = pst.executeQuery();

                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("property_name") %></td>
                    <td><%= rs.getString("user_name") %></td>
                    <td><%= rs.getTimestamp("booking_date") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                %>
            </tbody>
        </table>
    </div>

    <!-- JavaScript for Live Search -->
    <script>
        $(document).ready(function () {
            $("#searchInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#bookingTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
