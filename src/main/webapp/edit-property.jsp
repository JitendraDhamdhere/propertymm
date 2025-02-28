<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ include file="../includes/connect.jsp"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM properties WHERE id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        response.sendRedirect("manage-properties.jsp?msg=error");
    }

    String title = rs.getString("title");
    String description = rs.getString("description");
    String type = rs.getString("type");
    double price = rs.getDouble("price");
    String location = rs.getString("location");
    int size = rs.getInt("size");
    int bedrooms = rs.getInt("bedrooms");
    int bathrooms = rs.getInt("bathrooms");
    String status = rs.getString("status");
    String image = rs.getString("image");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Property</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-4">
		<h2 class="text-center mb-4">Edit Property</h2>

		<form action="update-property.jsp" method="post">
			<input type="hidden" name="id" value="<%= id %>">

			<div class="mb-3">
				<label class="form-label">Title</label> <input type="text"
					name="title" class="form-control" value="<%= title %>" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Description</label>
				<textarea name="description" class="form-control" required><%= description %></textarea>
			</div>

			<div class="mb-3">
				<label class="form-label">Property Type</label> <select name="type"
					class="form-select" required>
					<option value="Apartment"
						<%= type.equals("Apartment") ? "selected" : "" %>>Apartment</option>
					<option value="House" <%= type.equals("House") ? "selected" : "" %>>House</option>
					<option value="Office"
						<%= type.equals("Office") ? "selected" : "" %>>Office</option>
					<option value="Land" <%= type.equals("Land") ? "selected" : "" %>>Land</option>
				</select>
			</div>

			<div class="mb-3">
				<label class="form-label">Price (₹)</label> <input type="number"
					name="price" class="form-control" value="<%= price %>" step="0.01"
					required>
			</div>

			<div class="mb-3">
				<label class="form-label">Location</label> <input type="text"
					name="location" class="form-control" value="<%= location %>"
					required>
			</div>

			<div class="row">
				<div class="col-md-4 mb-3">
					<label class="form-label">Size (sqft)</label> <input type="number"
						name="size" class="form-control" value="<%= size %>" required>
				</div>
				<div class="col-md-4 mb-3">
					<label class="form-label">Bedrooms</label> <input type="number"
						name="bedrooms" class="form-control" value="<%= bedrooms %>"
						required>
				</div>
				<div class="col-md-4 mb-3">
					<label class="form-label">Bathrooms</label> <input type="number"
						name="bathrooms" class="form-control" value="<%= bathrooms %>"
						required>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label">Status</label> <select name="status"
					class="form-select">
					<option value="Available"
						<%= status.equals("Available") ? "selected" : "" %>>Available</option>
					<option value="Sold" <%= status.equals("Sold") ? "selected" : "" %>>Sold</option>
					<option value="Rented"
						<%= status.equals("Rented") ? "selected" : "" %>>Rented</option>
				</select>
			</div>

			<div class="mb-3">
				<label class="form-label">Image URL</label> <input type="text"
					name="image" class="form-control" value="<%= image %>" required>
			</div>

			<div class="mb-3 text-center">
				<img src="<%= image %>" alt="Property Image" width="200"
					class="rounded">
			</div>

			<button type="submit" class="btn btn-primary w-100">Update
				Property</button>
		</form>
	</div>
</body>
</html>
