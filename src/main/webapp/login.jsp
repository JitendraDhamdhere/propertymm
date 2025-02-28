<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="includes/connect.jsp"%>
<%@ page import="java.sql.*"%>
<%
String loggedInUser = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | Property Management System</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<style>
body {
	background: url('image/theme-park-bg.jpg') no-repeat center center fixed;
	background-size: cover;
}

.nav-link {
	font-size: 1.2em;
}

.card {
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.card-title {
	font-weight: bold;
	color: #333;
}

.btn-primary {
	background-color: #28a745;
	border: none;
}

.btn-primary:hover {
	background-color: #218838;
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

						<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact
								Us</a></li>

						<% 
						if (loggedInUser != null) {
					%>
						<li class="nav-item"><a class="nav-link"
							href="property-list.jsp">My Properties</a></li>
						<!-- Show for logged-in users -->
						<li class="nav-item"><a class="nav-link text-white fw-bold">Welcome,
								<%= loggedInUser %></a></li>
						<li class="nav-item"><a
							class="nav-link btn btn-danger text-white px-3" href="logout.jsp">Logout</a></li>
						<% 
						} else {
					%>

						<li class="nav-item"><a
							class="nav-link btn btn-primary text-white px-3" href="login.jsp">Login</a></li>
						<% 
						}
					%>

						<li class="nav-item"><a class="nav-link"
							href="adminlogin.jsp">Admin</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>


	<div
		class="container d-flex justify-content-center align-items-center vh-100">
		<div class="card p-4" style="width: 100%; max-width: 500px;">
			<h2 class="card-title text-center mb-4">Login to Property
				Management System</h2>
			<form method="post">
				<div class="mb-3">
					<label for="username" class="form-label">Username</label> <input
						type="text" class="form-control" name="username" required>
				</div>
				<div class="mb-3">
					<label for="password" class="form-label">Password</label> <input
						type="password" class="form-control" name="password" required>
				</div>
				<button type="submit" class="btn btn-primary w-100">Login</button>
				<a href="register.jsp" class="btn btn-link w-100 text-center">New
					User? Register</a>
			</form>

			<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement("SELECT id, username FROM users WHERE username = ? AND password = SHA2(?, 256)");
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id"); // Retrieve user ID from the database
                session.setAttribute("userid", userId); // Store userid in session
                session.setAttribute("username", username); // Store username in session
                
                out.print("<div class='alert alert-success mt-3'>Login Successful! Redirecting...</div>");
                response.setHeader("Refresh", "2; URL=index.jsp");
            } else {
                out.print("<div class='alert alert-danger mt-3'>Invalid Username or Password</div>");
            }
        } catch (Exception e) {
            out.print("<div class='alert alert-danger mt-3'>Error: " + e.getMessage() + "</div>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
        }
    }
%>

		</div>
	</div>
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
