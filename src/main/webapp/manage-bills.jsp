<%@ page import="java.sql.*, java.text.DecimalFormat"%>
<%@ include file="includes/connect.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Bills</title>
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
            .modal-footer {
                display: none;
            }
        }

        /* Bill Styling */
        .bill-container {
            border: 1px solid #000;
            padding: 20px;
            max-width: 600px;
            margin: auto;
            background: #fff;
        }
        .bill-header {
            text-align: center;
            border-bottom: 2px solid #000;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .bill-body {
            font-size: 16px;
        }
        .bill-footer {
            text-align: right;
            margin-top: 20px;
            font-weight: bold;
        }
        .signature {
            margin-top: 30px;
        }
        .signature p {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Manage Bills</h2>

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Booking ID</th>
                    <th>User Name</th>
                    <th>Property Name</th>
                    <th>Booking Date</th>
                    <th>Status</th>
                    <th>Price</th>
                    <th>Total Amount</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>

            <%
                try {
                    String sql = "SELECT b.id AS booking_id, u.fullname AS user_name, p.title AS property_name, " +
                                 "b.booking_date, b.status, p.price " +
                                 "FROM bookings b " +
                                 "JOIN users u ON b.user_id = u.id " +
                                 "JOIN properties p ON b.property_id = p.id";

                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);
                    DecimalFormat df = new DecimalFormat("#,##0.00");

                    while (rs.next()) {
                        int bookingId = rs.getInt("booking_id");
                        String userName = rs.getString("user_name");
                        String propertyName = rs.getString("property_name");
                        String bookingDate = rs.getString("booking_date");
                        String status = rs.getString("status");
                        double price = rs.getDouble("price");
                        double totalAmount = price;
            %>
                <tr>
                    <td><%= bookingId %></td>
                    <td><%= userName %></td>
                    <td><%= propertyName %></td>
                    <td><%= bookingDate %></td>
                    <td><%= status %></td>
                    <td>Rs. <%= df.format(price) %></td>
                    <td>Rs. <%= df.format(totalAmount) %></td>
                    <td>
                        <button class="btn btn-primary generate-bill" 
                                data-booking-id="<%= bookingId %>" 
                                data-user-name="<%= userName %>" 
                                data-property-name="<%= propertyName %>" 
                                data-booking-date="<%= bookingDate %>" 
                                data-status="<%= status %>" 
                                data-price="<%= df.format(price) %>" 
                                data-total="<%= df.format(totalAmount) %>"
                                data-bs-toggle="modal" data-bs-target="#billModal">
                            Generate Bill
                        </button>
                    </td>
                </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <tr>
                    <td colspan="8" class="text-danger text-center">Error: <%= e.getMessage() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap Modal -->
    <div class="modal fade" id="billModal" tabindex="-1" aria-labelledby="billModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="billModalLabel">Bill Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="printArea">
                        <div class="bill-container">
                            <div class="bill-header">
                                <h3>Property M S Invoice</h3>
                                <p><strong>PMS</strong></p>
                                <p>123 JM Street, Modern, Pune</p>
                                <p>Email: propertyms@company.com | Phone: +123456789</p>
                            </div>
                            <div class="bill-body">
                                <p><strong>Booking ID:</strong> <span id="modalBookingId"></span></p>
                                <p><strong>User Name:</strong> <span id="modalUserName"></span></p>
                                <p><strong>Property Name:</strong> <span id="modalPropertyName"></span></p>
                                <p><strong>Booking Date:</strong> <span id="modalBookingDate"></span></p>
                                <p><strong>Status:</strong> <span id="modalStatus"></span></p>
                                <p><strong>Price:</strong> Rs. <span id="modalPrice"></span></p>
                                <p><strong>Total Amount:</strong> Rs. <span id="modalTotal"></span></p>
                            </div>
                            <div class="bill-footer">
                                <p>Total Due: Rs. <span id="modalTotal"></span></p>
                            </div>
                            <div class="signature">
                                <p>________________________</p>
                                <p>Authorized Signature</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button onclick="printBill()" class="btn btn-primary">Print Bill</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function(){
            $(".generate-bill").click(function(){
                $("#modalBookingId").text($(this).data("booking-id"));
                $("#modalUserName").text($(this).data("user-name"));
                $("#modalPropertyName").text($(this).data("property-name"));
                $("#modalBookingDate").text($(this).data("booking-date"));
                $("#modalStatus").text($(this).data("status"));
                $("#modalPrice").text($(this).data("price"));
                $("#modalTotal").text($(this).data("total"));
            });
        });

        function printBill() {
            window.print();
        }
    </script>

</body>
</html>
