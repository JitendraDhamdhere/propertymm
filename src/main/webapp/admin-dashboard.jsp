<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page session="true"%>
<%@ include file="../includes/connect.jsp"%>

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
<title>Admin Dashboard | Property Management System</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="adminstyle.css">
<script src="https://kit.fontawesome.com/a076d05399.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
body {
	display: flex;
	min-height: 100vh;
}

/* Sidebar */
.sidebar {
	width: 250px;
	background-color: #343a40;
	color: white;
	transition: all 0.3s;
	position: fixed;
	height: 100%;
	overflow-y: auto;
}

.sidebar.small {
	width: 80px;
}

.sidebar .nav-link {
	color: white;
	padding: 10px;
}

.sidebar .nav-link:hover {
	background-color: #495057;
}

.sidebar .menu-text {
	display: inline;
}

.sidebar.small .menu-text {
	display: none;
}

/* Header Panel */
.header-panel {
	position: fixed;
	left: 250px;
	width: calc(100% - 250px);
	height: 60px;
	background: #f8f9fa;
	display: flex;
	align-items: center;
	padding: 0 20px;
	transition: all 0.3s;
	border-bottom: 2px solid #ddd;
}

.sidebar.small ~ .header-panel {
	left: 80px;
	width: calc(100% - 80px);
}

/* Main Panel */
.main-panel {
	margin-left: 250px;
	margin-top: 60px;
	padding: 20px;
	width: calc(100% - 250px);
	transition: all 0.3s;
}

.sidebar.small ~ .main-panel {
	margin-left: 80px;
	width: calc(100% - 80px);
}

.toggle-btn {
	cursor: pointer;
	font-size: 20px;
	margin-right: 15px;
}
</style>
</head>
<body>
	<!-- Sidebar -->
	<nav class="sidebar large" id="sidebar">
		<h4 class="text-center my-4">Admin Panel</h4>
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('admindash.jsp', 'Dashboard')"> <i
					class="fas fa-home"></i> <span class="menu-text">Dashboard</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('add-property.jsp', 'Add Property')"> <i
					class="fas fa-home"></i> <span class="menu-text">Add
						Property</span>
			</a></li>

			
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('manage-properties.jsp', 'Manage Properties')">
					<i class="fas fa-tasks"></i> <span class="menu-text">Manage
						Properties</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('manage-bookings.jsp', 'Manage Bookings')"> <i
					class="fas fa-calendar-check"></i> <span class="menu-text">Manage
						Bookings</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('view-reports.jsp', 'View Reports')"> <i
					class="fas fa-chart-line"></i> <span class="menu-text">View
						Reports</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('manage-bills.jsp', 'Manage Bills')"> <i
					class="fas fa-file-invoice"></i> <span class="menu-text">Manage
						Bills</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				onclick="loadPage('view-contactus.jsp', 'View Contact us')"> <i
					class="fas fa-file-invoice"></i> <span class="menu-text">
						View Contact us</span>
			</a></li>
			<li class="nav-item"><a class="nav-link text-danger"
				href="index.jsp"> <i class="fas fa-sign-out-alt"></i> <span
					class="menu-text">Logout</span>
			</a></li>
		</ul>
	</nav>

	<!-- Header Panel -->
	<header class="header-panel" id="header-panel">
		<span class="toggle-btn" onclick="toggleSidebar()"> <i
			class="fas fa-bars"></i>
		</span>
		<h4 id="page-title">Dashboard</h4>
	</header>

	<!-- Main Panel -->
	<main class="main-panel" id="main-panel">
		<h2>Welcome to Admin Dashboard</h2>
		<p>Manage your property listings, bookings, reports, and billing
			here.</p>
	</main>

	<script>
		function toggleSidebar() {
			let sidebar = document.getElementById("sidebar");
			let headerPanel = document.getElementById("header-panel");
			let mainPanel = document.getElementById("main-panel");

			if (sidebar.classList.contains("large")) {
				sidebar.classList.remove("large");
				sidebar.classList.add("small");
			} else {
				sidebar.classList.remove("small");
				sidebar.classList.add("large");
			}
		}

		function deleteProperty(propertyId) {
			if (confirm("Are you sure you want to delete this property?")) {
				$
						.ajax({
							url : "delete-property.jsp",
							type : "POST",
							data : {
								id : propertyId
							},
							success : function(response) {
								if (response.trim() === "success") {
									alert("Property deleted successfully!");
									loadPage('manage-properties.jsp',
											'Manage Properties'); // Reload only the table
								} else {
									alert("Failed to delete property. Please try again.");
								}
							},
							error : function() {
								alert("Error occurred. Try again.");
							}
						});
			}
		}

		function loadPage(page, title) {
			document.getElementById("page-title").innerText = title;
			$("#main-panel").load(page);
		}

		// Load 'admindash.jsp' by default when the page is loaded
		$(document).ready(function() {
			loadPage('admindash.jsp', 'Dashboard');
		});
	</script>
</body>
</html>
