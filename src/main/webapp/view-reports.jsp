<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.text.DecimalFormat"%>
<%@ include file="includes/connect.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Booking Reports</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <style>
        /* Print Styles */
        @media print {
            body * {
                visibility: hidden;
            }
            #printArea, #printArea * {
                visibility: visible;
            }
            #printArea {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
            }
            .no-print {
                display: none;
            }
        }

        /* Report Styling */
        .report-container {
            border: 1px solid #000;
            padding: 20px;
            max-width: 900px;
            margin: auto;
            background: #fff;
        }
        .report-header {
            text-align: center;
            border-bottom: 2px solid #000;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .report-body {
            font-size: 16px;
        }
        .report-footer {
            text-align: right;
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Booking Reports</h2>

        <!-- Date Filter Form -->
        <form method="GET" action="reports.jsp" class="no-print mb-4">
            <div class="row">
                <div class="col-md-4">
                    <label for="startDate">Start Date:</label>
                    <input type="date" class="form-control" name="startDate" required>
                </div>
                <div class="col-md-4">
                    <label for="endDate">End Date:</label>
                    <input type="date" class="form-control" name="endDate" required>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Generate Report</button>
                </div>
            </div>
        </form>

        <!-- Report Section -->
        <div id="printArea">
            <div class="report-container">
                <div class="report-header">
                    <h3>Booking Report</h3>
                    <p><strong>Company Name</strong></p>
                    <p>123 Main Street, City, Country</p>
                    <p>Email: contact@company.com | Phone: +123456789</p>
                </div>

                <div class="report-body">
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking ID</th>
                                <th>User ID</th>
                                <th>Property ID</th>
                                <th>Booking Date</th>
                                <th>Status</th>
                                <th>Price</th>
                                <th>Total Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Get date range from request
                                String startDate = request.getParameter("startDate");
                                String endDate = request.getParameter("endDate");
                                DecimalFormat df = new DecimalFormat("#,##0.00");

                                if (startDate != null && endDate != null) {
                                    try {
                                        String sql = "SELECT b.id AS booking_id, b.user_id, b.property_id, b.booking_date, b.status, p.price " +
                                                     "FROM bookings b " +
                                                     "JOIN properties p ON b.property_id = p.id " +
                                                     "WHERE b.booking_date BETWEEN ? AND ?";

                                        PreparedStatement pstmt = conn.prepareStatement(sql);
                                        pstmt.setString(1, startDate);
                                        pstmt.setString(2, endDate);
                                        ResultSet rs = pstmt.executeQuery();

                                        boolean hasData = false;
                                        while (rs.next()) {
                                            hasData = true;
                                            int bookingId = rs.getInt("booking_id");
                                            int userId = rs.getInt("user_id");
                                            int propertyId = rs.getInt("property_id");
                                            String bookingDate = rs.getString("booking_date");
                                            String status = rs.getString("status");
                                            double price = rs.getDouble("price");
                                            double totalAmount = price;
                            %>
                            <tr>
                                <td><%= bookingId %></td>
                                <td><%= userId %></td>
                                <td><%= propertyId %></td>
                                <td><%= bookingDate %></td>
                                <td><%= status %></td>
                                <td>$<%= df.format(price) %></td>
                                <td>$<%= df.format(totalAmount) %></td>
                            </tr>
                            <%
                                        }
                                        if (!hasData) {
                            %>
                            <tr>
                                <td colspan="7" class="text-center text-danger">No bookings found for the selected date range.</td>
                            </tr>
                            <%
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                            %>
                            <tr>
                                <td colspan="7" class="text-center text-danger">Error: <%= e.getMessage() %></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="report-footer">
                    <p>Date Generated: <%= new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></p>
                    <p>Generated By: System</p>
                </div>
            </div>
        </div>

        <!-- Print Button -->
        <div class="text-center mt-4 no-print">
            <button onclick="printReport()" class="btn btn-success">Print Report</button>
        </div>
    </div>

    <script>
        function printReport() {
            window.print();
        }
    </script>

</body>
</html>
