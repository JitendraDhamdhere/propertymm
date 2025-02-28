<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%
String loggedInUser = (String) session.getAttribute("username");
%>
<%@ include file="includes/connect.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gallery</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<!-- Custom CSS -->
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Arial', sans-serif;
}

.gallery-card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s, box-shadow 0.3s;
	margin-bottom: 30px;
	background-color: #fff;
}

.gallery-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.gallery-card img {
	width: 100%;
	height: 250px;
	object-fit: cover;
}

.gallery-card .card-body {
	padding: 20px;
	text-align: center;
}

.gallery-card .card-title {
	font-size: 1.25rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.gallery-card .card-text {
	font-size: 0.9rem;
	color: #666;
	margin-bottom: 5px;
}

.modal-content {
	border-radius: 15px;
}

.modal-header {
	background-color: #212529;
	color: #fff;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

.modal-header .btn-close {
	filter: invert(1);
}

.modal-body img {
	width: 100%;
	height: 300px;
	object-fit: cover;
	border-radius: 10px;
	margin-bottom: 20px;
}

.modal-body p {
	font-size: 1rem;
	color: #333;
	margin-bottom: 10px;
}

.modal-footer {
	justify-content: space-between;
	border-bottom-left-radius: 15px;
	border-bottom-right-radius: 15px;
}

.btn-primary {
	background-color: #007bff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-success {
	background-color: #28a745;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
}

.btn-success:hover {
	background-color: #218838;
}

.btn-danger {
	background-color: #dc3545;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
}

.btn-danger:hover {
	background-color: #c82333;
}

.navbar {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.navbar-brand img {
	width: 100px;
	border-radius: 50%;
}

.navbar-nav .nav-link {
	font-size: 1rem;
	color: #fff;
	margin-left: 15px;
}

.navbar-nav .nav-link:hover {
	color: #007bff;
}

.navbar-nav .btn {
	margin-left: 15px;
}
</style>
</head>
<body>

	<header>
		<nav class="navbar navbar-expand-lg navbar-dark fixed-top"
			style="background-color: #212529;">
			<div class="container">
				<a class="navbar-brand" href="#"> <img
					src="image/property-logo.png" alt="Property Logo">
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>

						<li class="nav-item"><a class="nav-link" href="gallery.jsp">Gallery</a></li>

						<% if (loggedInUser != null) { %>
						<li class="nav-item"><a class="nav-link"
							href="property-list.jsp">My Properties</a></li>
						<li class="nav-item"><a class="nav-link text-white fw-bold">Welcome,
								<%= loggedInUser %></a></li>
						<li class="nav-item"><a
							class="nav-link btn btn-danger text-white px-3" href="logout.jsp">Logout</a></li>
						<% } else { %>
						<li class="nav-item"><a
							class="nav-link btn btn-primary text-white px-3" href="login.jsp">Login</a></li>
						<% } %>

						<li class="nav-item"><a class="nav-link"
							href="adminlogin.jsp">Admin</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>

	<section class="container my-5 pt-5">
		<div class="row">
			<%
		try {
			String sql = "SELECT id, title, type, price, location, size, bedrooms, bathrooms, status, image FROM properties";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String type = rs.getString("type");
				double price = rs.getDouble("price");
				String location = rs.getString("location");
				String size = rs.getString("size");
				int bedrooms = rs.getInt("bedrooms");
				int bathrooms = rs.getInt("bathrooms");
				String status = rs.getString("status");
				String imageUrl = rs.getString("image");
				String finalImageUrl = (imageUrl == null || imageUrl.trim().isEmpty()) ? "../image/dummyimg.jpg" : imageUrl;
		%>
			<div class="col-lg-4 col-md-6 col-sm-12 mb-4">
				<div class="card gallery-card">
					<img src="<%= finalImageUrl %>" alt="<%= title %>"
						class="img-fluid"
						onerror="this.onerror=null; this.src='image/dummyimg.jpg';">
					<div class="card-body">
						<h5 class="card-title"><%= title %></h5>
						<p class="card-text">
							<strong>Type:</strong>
							<%= type %></p>
						<p class="card-text">
							<strong>Price:</strong> Rs.<%= price %></p>
						<p class="card-text">
							<strong>Location:</strong>
							<%= location %></p>

						<% if (loggedInUser != null) { %>
						<button class="btn btn-info" data-bs-toggle="modal"
							data-bs-target="#propertyModal<%= id %>">View Details</button>
						<% } %>
					</div>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="propertyModal<%= id %>" tabindex="-1"
				aria-labelledby="propertyModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="propertyModalLabel"><%= title %></h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<img src="<%= finalImageUrl %>" alt="<%= title %>"
								class="img-fluid"
								onerror="this.onerror=null; this.src='image/dummyimg.jpg';">

							<div class="row mt-4">
								<div class="col-md-6">
									<p>
										<strong>Type:</strong>
										<%= type %></p>
									<p>
										<strong>Price:</strong> Rs.<%= price %></p>
									<p>
										<strong>Location:</strong>
										<%= location %></p>
								</div>
								<div class="col-md-6">
									<p>
										<strong>Size:</strong>
										<%= size %>
										sq. ft.
									</p>
									<p>
										<strong>Bedrooms:</strong>
										<%= bedrooms %></p>
									<p>
										<strong>Bathrooms:</strong>
										<%= bathrooms %></p>
									<p>
										<strong>Status:</strong>
										<%= status %></p>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<% if ("Available".equalsIgnoreCase(status) && loggedInUser != null) { %>
							<a href="book-property.jsp?id=<%= id %>" class="btn btn-success">Book
								Now</a>
							<% } %>
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" id="propertyModal<%= id %>" tabindex="-1"
				aria-labelledby="propertyModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="propertyModalLabel"><%= title %></h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<img src="<%= finalImageUrl %>" alt="<%= title %>"
								class="img-fluid"
								onerror="this.onerror=null; this.src='image/dummyimg.jpg';">

							<div class="row mt-4">
								<div class="col-md-6">
									<p>
										<strong>Type:</strong>
										<%= type %></p>
									<p>
										<strong>Price:</strong> Rs.<%= price %></p>
									<p>
										<strong>Location:</strong>
										<%= location %></p>
								</div>
								<div class="col-md-6">
									<p>
										<strong>Size:</strong>
										<%= size %>
										sq. ft.
									</p>
									<p>
										<strong>Bedrooms:</strong>
										<%= bedrooms %></p>
									<p>
										<strong>Bathrooms:</strong>
										<%= bathrooms %></p>
									<p>
										<strong>Status:</strong>
										<%= status %></p>
								</div>
							</div>

							<% if ("Available".equalsIgnoreCase(status) && loggedInUser != null) { %>
							<form action="book-property.jsp" method="post">
								<input type="hidden" name="property_id" value="<%= id %>">
								<input type="hidden" name="user_id"
									value="<%= session.getAttribute("userId") %>">

								<div class="form-group">
									<label for="booking_date">Booking Date</label> <input
										type="date" class="form-control" id="booking_date"
										name="booking_date" required>
								</div>

								<div class="form-group">
									<label for="status">Status</label> <select class="form-control"
										id="status" name="status" required>
										<option value="Pending" selected>Pending</option>
										<option value="Confirmed">Confirmed</option>
										<option value="Cancelled">Cancelled</option>
									</select>
								</div>

								<button type="submit" class="btn btn-success mt-3">Book
									Now</button>
							</form>

							<% } %>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			conn.close();
		} catch (Exception e) {
		%>
			<p class="text-danger">
				Error:
				<%= e.getMessage() %></p>
			<%
		}
		%>
		</div>
	</section>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>