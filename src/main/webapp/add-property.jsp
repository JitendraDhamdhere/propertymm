<!-- ADMIN property -->

<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Property</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-4">
		<h3 class="text-center mb-4">Add Property</h3>

		<form action="save_property.jsp" method="post">
			<div class="mb-3">
				<label class="form-label">Property Title</label> <input type="text"
					name="title" class="form-control" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Description</label>
				<textarea name="description" class="form-control" rows="3" required></textarea>
			</div>

			<div class="mb-3">
				<label class="form-label">Property Type</label> <select name="type"
					class="form-select" required>
					<option value="Apartment">Apartment</option>
					<option value="House">House</option>
					<option value="Office">Office</option>
					<option value="Land">Land</option>
				</select>
			</div>

			<div class="mb-3">
				<label class="form-label">Price (₹)</label> <input type="number"
					name="price" class="form-control" step="0.01" required>
			</div>

			<div class="mb-3">
				<label class="form-label">Location</label> <input type="text"
					name="location" class="form-control" required>
			</div>

			<div class="row">
				<div class="col-md-4 mb-3">
					<label class="form-label">Size (sqft)</label> <input type="number"
						name="size" class="form-control" required>
				</div>
				<div class="col-md-4 mb-3">
					<label class="form-label">Bedrooms</label> <input type="number"
						name="bedrooms" class="form-control" required>
				</div>
				<div class="col-md-4 mb-3">
					<label class="form-label">Bathrooms</label> <input type="number"
						name="bathrooms" class="form-control" required>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label">Status</label> <select name="status"
					class="form-select">
					<option value="Available">Available</option>
					<option value="Sold">Sold</option>
					<option value="Rented">Rented</option>
				</select>
			</div>

			<div class="mb-3">
				<label class="form-label">Upload Property Image</label> <input
					type="file" name="image" class="form-control" accept="image/*"
					required>
			</div>

			<button type="submit" class="btn btn-primary w-100">Add
				Property</button>
		</form>
	</div>
</body>
</html>
