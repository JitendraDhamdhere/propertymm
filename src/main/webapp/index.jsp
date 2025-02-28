<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String loggedInUser = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Property Management System - Home</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>

<body>

	<!-- Navigation Bar -->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: #f8f9fa; border-bottom: 1px solid #ddd;">
        <div class="container">
            <a class="navbar-brand" href="#"> 
                <img src="image/property-logo.png" alt="Property Management System Logo" style="width: 100px; border-radius: 50%;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon" style="background-color: #007bff;"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp" style="color: #333; font-weight: 500;">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about" style="color: #333; font-weight: 500;">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp" style="color: #333; font-weight: 500;">Contact Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="gallery.jsp" style="color: #333; font-weight: 500;">Properties</a></li>

                    <%-- Show the "Properties" link based on login status --%>
                    <% 
                    if (loggedInUser != null) {
                    %>
                        <li class="nav-item"><a class="nav-link" href="property-list.jsp" style="color: #333; font-weight: 500;">My Properties</a></li>
                        <!-- Show for logged-in users -->
                        <li class="nav-item"><a class="nav-link text-dark" style="font-weight: 500;">Welcome, <%= loggedInUser %></a></li>
                        <li class="nav-item"><a class="nav-link btn btn-danger text-white px-3" href="logout.jsp" style="border-radius: 20px;">Logout</a></li>
                    <% 
                    } else {
                    %>
<!--                         <li class="nav-item"><a class="nav-link" href="template.jsp" style="color: #333; font-weight: 500;">Properties</a></li>
 -->                        <!-- Show for non-logged-in users -->
                        <li class="nav-item"><a class="nav-link btn btn-primary text-white px-3" href="login.jsp" style="border-radius: 20px;">Login</a></li>
                    <% 
                    }
                    %>

                    <li class="nav-item"><a class="nav-link" href="adminlogin.jsp" style="color: #333; font-weight: 500;">Admin</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>


	<section class="hero-section" style="background: url('image/property1.jpg') no-repeat center center/cover; height: 100vh; display: flex; justify-content: center; align-items: center; text-align: center; color: white;">
    <div class="hero-content" style="background: rgba(0, 0, 0, 0.5); padding: 20px; border-radius: 10px;">
        <h1>Welcome to Our Property Management System</h1>
        <p>Find Your Dream Property Today!</p>
        <a href="#properties" class="btn btn-primary">Explore Properties</a>
    </div>
</section>

	<!-- About Us Section -->
	<section class="container my-5" id="about">
		<h2 class="text-center mb-4"
			style="font-size: 2.5em; font-weight: bold; padding-bottom: 80px">About Us</h2>
		<div class="row">
			<div class="col-md-6" style="padding-top: 30px">
				<img src="image/about-property.jpg" class="img-fluid rounded mb-4 ms-3"
					alt="Property Management System"
					style="width: 100%; height: 450px; object-fit: cover; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
			</div>
			<div class="col-md-6" style="padding-left: 80px;">
				<h3 style="font-size: 2em;">Welcome to Our Property Management System</h3>
				<p style="font-size: 1.2em;">We are dedicated to helping you find the perfect property for your needs. Whether you're looking to buy, rent, or sell, we provide a seamless experience with a wide range of properties to choose from.</p>
				<h4 style="font-size: 1.5em;">Why Choose Us?</h4>
				<ul style="font-size: 1.2em;">
					<li><strong>Wide Range of Properties:</strong> From apartments to villas, we have it all.</li>
					<li><strong>Expert Agents:</strong> Our team of professionals is here to guide you.</li>
					<li><strong>Secure Transactions:</strong> Your safety and privacy are our top priorities.</li>
					<li><strong>24/7 Support:</strong> We are always here to assist you.</li>
					<li><strong>Affordable Prices:</strong> Find properties that fit your budget.</li>
				</ul>
				<p style="font-size: 1.2em;">Our mission is to make property management easy and accessible for everyone. Start your journey with us today!</p>
			</div>
		</div>
	</section>

	<!-- Featured Properties Section -->
	<section class="container my-5" id="properties">
		<h2 class="text-center mb-4"
			style="font-size: 4em; font-weight: bold; padding-top: 10px; padding-bottom: 70px;">
			Featured Properties</h2>
		<div class="row justify-content-center">
			<div class="col-lg-3 col-md-6 mb-5">
				<div class="card property-card border-0 shadow-lg"
					style="height: 550px;">
					<img src="image/property1.jpg"
						class="card-img-top rounded-top"
						style="height: 350px; object-fit: cover;" alt="Luxury Apartment">
					<div
						class="card-img-overlay d-flex align-items-center justify-content-center"
						style="background: rgba(0, 0, 0, 0.5); border-radius: 10px 10px 0 0;">
						<h5 class="card-title text-white text-center fw-bold"
							style="font-size: 1.8em;">Luxury Apartment</h5>
					</div>
					<div class="card-body text-center">
						<p class="card-text" style="font-size: 1.2em;">A modern 3-bedroom apartment in the heart of the city.</p>
						<p class="price" style="font-size: 1.5em; font-weight: bold;">Rs.500,000</p>
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6 mb-5">
				<div class="card property-card border-0 shadow-lg"
					style="height: 550px;">
					<img src="image/property2.jpg" class="card-img-top rounded-top"
						style="height: 350px; object-fit: cover;" alt="Beach House">
					<div
						class="card-img-overlay d-flex align-items-center justify-content-center"
						style="background: rgba(0, 0, 0, 0.5); border-radius: 10px 10px 0 0;">
						<h5 class="card-title text-white text-center fw-bold"
							style="font-size: 1.8em;">Beach House</h5>
					</div>
					<div class="card-body text-center">
						<p class="card-text" style="font-size: 1.2em;">A stunning beachfront property with ocean views.</p>
						<p class="price" style="font-size: 1.5em; font-weight: bold;">Rs.1,200,000</p>
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6 mb-5">
				<div class="card property-card border-0 shadow-lg"
					style="height: 550px;">
					<img src="image/property3.jpg" class="card-img-top rounded-top"
						style="height: 350px; object-fit: cover;" alt="Country Villa">
					<div
						class="card-img-overlay d-flex align-items-center justify-content-center"
						style="background: rgba(0, 0, 0, 0.5); border-radius: 10px 10px 0 0;">
						<h5 class="card-title text-white text-center fw-bold"
							style="font-size: 1.8em;">Country Villa</h5>
					</div>
					<div class="card-body text-center">
						<p class="card-text" style="font-size: 1.2em;">A spacious villa surrounded by nature.</p>
						<p class="price" style="font-size: 1.5em; font-weight: bold;">Rs.850,000</p>
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6 mb-5">
				<div class="card property-card border-0 shadow-lg"
					style="height: 550px;">
					<img src="image/property4.jpg" class="card-img-top rounded-top"
						style="height: 350px; object-fit: cover;" alt="City Loft">
					<div
						class="card-img-overlay d-flex align-items-center justify-content-center"
						style="background: rgba(0, 0, 0, 0.5); border-radius: 10px 10px 0 0;">
						<h5 class="card-title text-white text-center fw-bold"
							style="font-size: 1.8em;">City Loft</h5>
					</div>
					<div class="card-body text-center">
						<p class="card-text" style="font-size: 1.2em;">A stylish loft in the bustling city center.</p>
						<p class="price" style="font-size: 1.5em; font-weight: bold;">Rs.650,000</p>
					</div>
				</div>
			</div>
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
					<p style="font-size: 1.1em;">Your trusted partner in finding the perfect property.</p>
				</div>

				<!-- Quick Links -->
				<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
					<h5 class="text-uppercase fw-bold mb-4">Quick Links</h5>
					<ul class="list-unstyled" style="font-size: 1.1em;">
						<li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
						<li><a href="#about" class="text-white text-decoration-none">About Us</a></li>
						<li><a href="#properties" class="text-white text-decoration-none">Properties</a></li>
						<li><a href="gallery.jsp" class="text-white text-decoration-none">Gallery</a></li>
						<li><a href="contact.jsp" class="text-white text-decoration-none">Contact Us</a></li>
					</ul>
				</div>

				<!-- Contact Information -->
				<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-4">
					<h5 class="text-uppercase fw-bold mb-4">Get In Touch</h5>
					<p style="font-size: 1.1em;">
						123 Property Street,<br> City Center,<br> Country - 12345
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
						<a href="#" class="text-white me-3 fs-4"><i class="bi bi-facebook"></i></a>
						<a href="#" class="text-white me-3 fs-4"><i class="bi bi-instagram"></i></a>
						<a href="#" class="text-white me-3 fs-4"><i class="bi bi-linkedin"></i></a>
						<a href="#" class="text-white fs-4"><i class="bi bi-youtube"></i></a>
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
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html> 