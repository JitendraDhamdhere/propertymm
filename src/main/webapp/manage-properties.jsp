<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ include file="../includes/connect.jsp"%>

<%
    // Fetch all properties
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM properties");
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Properties</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

</head>
<body>

    <div class="container mt-4">
        <h2 class="text-center mb-4">Manage Properties</h2>

        <!-- Search Box -->
        <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search by any field...">

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th>Price (₹)</th>
                    <th>Location</th>
                    <th>Size (sqft)</th>
                    <th>Bedrooms</th>
                    <th>Bathrooms</th>
                    <th>Status</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="propertyTable">
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getString("type") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><%= rs.getString("location") %></td>
                    <td><%= rs.getInt("size") %></td>
                    <td><%= rs.getInt("bedrooms") %></td>
                    <td><%= rs.getInt("bathrooms") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td><img src="<%= rs.getString("image") %>" alt="Property Image" width="100"></td>
                    <td>
                        <a href="#" class="btn btn-warning btn-sm"
                            onclick="loadPage('edit-property.jsp?id=<%= rs.getInt("id") %>', 'Edit Property')">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <button class="btn btn-danger btn-sm" onclick="deleteProperty(<%= rs.getInt("id") %>)">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- JavaScript for Live Search -->
    <script>
        $(document).ready(function () {
            $("#searchInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#propertyTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
