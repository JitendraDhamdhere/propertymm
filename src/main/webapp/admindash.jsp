<!-- ADMIN DASH -->
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page session="true"%>
<%@ include file="../includes/connect.jsp"%>

<%
String isAdminLoggedIn = (String) session.getAttribute("adminLoggedIn");
if (isAdminLoggedIn == null) {
	response.sendRedirect("index.jsp");
}

int totalProperties = 0, totalBookings = 0, pendingApprovals = 0, activeUsers = 0;
double totalRevenue = 0.0;

try {
	// Fetch Total Properties
	String sql = "SELECT COUNT(*) AS total FROM properties";
	PreparedStatement ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	if (rs.next()) {
		totalProperties = rs.getInt("total");
	}

	// Fetch Total Bookings
	sql = "SELECT COUNT(*) AS total FROM bookings";
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	if (rs.next()) {
		totalBookings = rs.getInt("total");
	}

	// Fetch Total Revenue
	sql = "SELECT COALESCE(SUM(price), 0) AS revenue FROM properties WHERE status = 'Sold'";
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	if (rs.next()) {
		totalRevenue = rs.getDouble("revenue"); // Ensures a valid number is returned
	}	

	// Fetch Pending Approvals
	sql = "SELECT COUNT(*) AS total FROM properties WHERE status='pending'";
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	if (rs.next()) {
		pendingApprovals = rs.getInt("total");
	}

	// Fetch Active Users
	sql = "SELECT COUNT(*) AS total FROM users";
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	if (rs.next()) {
		activeUsers = rs.getInt("total");
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/a076d05399.js"
	crossorigin="anonymous"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
}

.dashboard-container {
	padding: 30px;
}

.card {
	border: none;
	border-radius: 10px;
	transition: 0.3s;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
}

.icon {
	font-size: 2rem;
}

.bg-blue {
	background: #007bff;
	color: white;
}

.bg-green {
	background: #28a745;
	color: white;
}

.bg-orange {
	background: #fd7e14;
	color: white;
}

.bg-red {
	background: #dc3545;
	color: white;
}

.bg-purple {
	background: #6f42c1;
	color: white;
}
</style>
</head>
<body>
	<div class="container dashboard-container">
		<h2 class="mb-4">Admin Dashboard</h2>
		<div class="row">
			<!-- Total Properties -->
			<div class="col-md-4">
				<div class="card bg-blue text-white shadow p-3">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<h5>Total Properties</h5>
							<h3><%=totalProperties%></h3>
						</div>
						<i class="fas fa-building icon"></i>
					</div>
				</div>
			</div>

			<!-- Total Bookings -->
			<div class="col-md-4">
				<div class="card bg-green text-white shadow p-3">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<h5>Total Bookings</h5>
							<h3><%=totalBookings%></h3>
						</div>
						<i class="fas fa-calendar-check icon"></i>
					</div>
				</div>
			</div>

			<!-- Total Revenue -->
			<div class="col-md-4">
				<div class="card bg-orange text-white shadow p-3">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<h5>Total Revenue</h5>
							<h3>
								₹
								<%=String.format("%.2f", totalRevenue)%></h3>
						</div>
						<i class="fas fa-rupee-sign icon"></i>
					</div>
				</div>
			</div>

			<!-- Pending Approvals -->
			<div class="col-md-4 mt-3">
				<div class="card bg-red text-white shadow p-3">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<h5>Pending Approvals</h5>
							<h3><%=pendingApprovals%></h3>
						</div>
						<i class="fas fa-exclamation-circle icon"></i>
					</div>
				</div>
			</div>

			<!-- Active Users -->
			<div class="col-md-4 mt-3">
				<div class="card bg-purple text-white shadow p-3">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<h5>Active Users</h5>
							<h3><%=activeUsers%></h3>
						</div>
						<i class="fas fa-users icon"></i>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap & jQuery -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>