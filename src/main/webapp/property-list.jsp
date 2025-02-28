<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%
String loggedInUser = (String) session.getAttribute("username");
int userId = (int) session.getAttribute("userid"); // Assuming you store user ID in session
%>
<%@ include file="includes/connect.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Bookings</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Arial', sans-serif;
}

.booking-card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s, box-shadow 0.3s;
	margin-bottom: 30px;
	background-color: #fff;
}

.booking-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.booking-card img {
	width: 100%;
	height: 250px;
	object-fit: cover;
}

.booking-card .card-body {
	padding: 20px;
}

.booking-card .card-title {
	font-size: 1.25rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.booking-card .card-text {
	font-size: 0.9rem;
	color: #666;
	margin-bottom: 5px;
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

	<!-- Navigation Bar -->
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark fixed-top"
			style="background-color: #212529;">
			<div class="container">
				<a class="navbar-brand" href="#"> <img
					src="image/property-logo.png" alt="Property Management System Logo"
					style="width: 100px; border-radius: 50%;">
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
						<li class="nav-item"><a class="nav-link" href="#about">About
								Us</a></li>
						<li class="nav-item"><a class="nav-link" href="#properties">Properties</a></li>
						<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact
								Us</a></li>
						<li class="nav-item"><a class="nav-link" href="gallery.jsp">Gallery</a></li>

						<% if (loggedInUser != null) { %>
						<li class="nav-item"><a class="nav-link"
							href="property-list.jsp">My Properties</a></li>
						<li class="nav-item"><a class="nav-link text-white fw-bold">Welcome,
								<%= loggedInUser %></a></li>
						<li class="nav-item"><a
							class="nav-link btn btn-danger text-white px-3" href="logout.jsp">Logout</a></li>
						<% } else { %>
						<li class="nav-item"><a class="nav-link" href="template.jsp">Properties</a></li>
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
		<h2 class="mb-4">My Bookings</h2>
		<div class="row">
			<%
			try {
				String sql = "SELECT b.id AS booking_id, b.booking_date, b.status, p.* " +
							"FROM bookings b " +
							"JOIN properties p ON b.property_id = p.id " +
							"WHERE b.user_id = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, userId);
				ResultSet rs = pstmt.executeQuery();

				while (rs.next()) {
					int bookingId = rs.getInt("booking_id");
					String bookingDate = rs.getString("booking_date");
					String bookingStatus = rs.getString("status");
					String propertyTitle = rs.getString("title");
					String propertyDescription = rs.getString("description");
					String propertyType = rs.getString("type");
					double propertyPrice = rs.getDouble("price");
					String propertyLocation = rs.getString("location");
					String propertySize = rs.getString("size");
					int propertyBedrooms = rs.getInt("bedrooms");
					int propertyBathrooms = rs.getInt("bathrooms");
					String propertyStatus = rs.getString("status");
					String propertyImage = rs.getString("image");
			%>
			<div class="col-lg-4 col-md-6 col-sm-12 mb-4">
				<div class="card booking-card">
					<img src="<%= propertyImage %>" alt="<%= propertyTitle %>"
						class="img-fluid">
					<div class="card-body">
						<h5 class="card-title"><%= propertyTitle %></h5>
						<p class="card-text"><%= propertyDescription %></p>
						<p class="card-text">
							<strong>Type:</strong>
							<%= propertyType %></p>
						<p class="card-text">
							<strong>Price:</strong> $<%= propertyPrice %></p>
						<p class="card-text">
							<strong>Location:</strong>
							<%= propertyLocation %></p>
						<p class="card-text">
							<strong>Size:</strong>
							<%= propertySize %>
							sq. ft.
						</p>
						<p class="card-text">
							<strong>Bedrooms:</strong>
							<%= propertyBedrooms %></p>
						<p class="card-text">
							<strong>Bathrooms:</strong>
							<%= propertyBathrooms %></p>
						<p class="card-text">
							<strong>Booking Date:</strong>
							<%= bookingDate %></p>
						<p class="card-text">
							<strong>Booking Status:</strong>
							<%= bookingStatus %></p>
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

	<!-- Footer Section -->
	<footer class="bg-dark text-white pt-5 pb-4">
		<div class="container text-center text-md-start">
			<div class="row">
				<!-- About Section -->
				<div class="col-md-4 col-lg-4 col-xl-4 mx-auto mb-4">
					<h5 class="text-uppercase fw-bold mb-4">
						<img src="image/property-logo.png" alt="Logo"
							style="width: 100px; height: 100px; align: center; margin-right: 10px;">
					</h5>
					<p style="font-size: 1.1em;">Your trusted partner in finding
						the perfect property.</p>
				</div>

				<!-- Quick Links -->
				<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
					<h5 class="text-uppercase fw-bold mb-4">Quick Links</h5>
					<ul class="list-unstyled" style="font-size: 1.1em;">
						<li><a href="index.jsp"
							class="text-white text-decoration-none">Home</a></li>
						<li><a href="#about" class="text-white text-decoration-none">About
								Us</a></li>
						<li><a href="#properties"
							class="text-white text-decoration-none">Properties</a></li>
						<li><a href="gallery.jsp"
							class="text-white text-decoration-none">Gallery</a></li>
						<li><a href="contact.jsp"
							class="text-white text-decoration-none">Contact Us</a></li>
					</ul>
				</div>

				<!-- Contact Information -->
				<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-4">
					<h5 class="text-uppercase fw-bold mb-4">Get In Touch</h5>
					<p style="font-size: 1.1em;">
						123 Property Street,<br> City Center,<br> Country -
						12345
					</p>
					<p style="font-size: 1.1em;">
						<i class="bi bi-telephone-fill"></i> +91-1020304050
					</p>
					<p style="font-size: 1.1em;">
						<i class="bi bi-envelope-fill"></i> info@propertymanagement.com
					</p>
				</div>

				<!-- Social Links -->
				<div class="col-md-3 col-lg-3 col-xl-3 mx-auto mb-4">
					<h5 class="text-uppercase fw-bold mb-4">Follow Us</h5>
					<div class="mt-3">
						<a href="#" class="text-white me-3 fs-4"><i
							class="bi bi-facebook"></i></a> <a href="#"
							class="text-white me-3 fs-4"><i class="bi bi-instagram"></i></a>
						<a href="#" class="text-white me-3 fs-4"><i
							class="bi bi-linkedin"></i></a> <a href="#" class="text-white fs-4"><i
							class="bi bi-youtube"></i></a>
					</div>
				</div>
			</div>
		</div>
		<div class="text-center p-3"
			style="background-color: rgba(0, 0, 0, 0.2); font-size: 1.1em;">
			© 2025 Property Management System | All Rights Reserved</div>
	</footer>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>