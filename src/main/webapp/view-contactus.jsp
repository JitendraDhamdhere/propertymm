<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="../includes/connect.jsp"%>
<!-- Include DB connection -->

<%@ page session="true"%>
<%
String isAdminLoggedIn = (String) session.getAttribute("adminLoggedIn");
if (isAdminLoggedIn == null) {
    response.sendRedirect("index.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Contact Us Submissions | Admin Panel</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <div class="container mt-4">
        <h2 class="text-center mb-4">Contact Us Submissions</h2>

        <!-- Search Box -->
        <div class="mb-3">
            <input type="text" id="searchInput" class="form-control" placeholder="Search by Name, Email, Phone, or Message...">
        </div>

        <div class="card">
            <div class="card-body">
                <table class="table table-bordered mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Message</th>
                        </tr>
                    </thead>
                    <tbody id="contactTable">
                        <%
                        // Fetch data from the "contact" table
                        try {
                            String sql = "SELECT * FROM contact"; 
                            PreparedStatement preparedStatement = conn.prepareStatement(sql);
                            ResultSet resultSet = preparedStatement.executeQuery();

                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String name = resultSet.getString("name");
                                String email = resultSet.getString("email");
                                String phone = resultSet.getString("phone");
                                String message = resultSet.getString("message");
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td><%= phone %></td>
                            <td><%= message %></td>
                        </tr>
                        <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Logout Functionality -->
    <%
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("login.jsp");
    }
    %>

    <!-- JavaScript for Live Search -->
    <script>
        $(document).ready(function () {
            $("#searchInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#contactTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
