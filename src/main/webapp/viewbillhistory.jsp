<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Billing" %>
<%@ page import="com.model.Customer" %>
<%
    List<Billing> billHistory = (List<Billing>) request.getAttribute("billhistory");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .billing-card {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            margin: 10px auto;
            max-width: 700px;
            display: flex;
            flex-direction: column;
        }

        .booking-label {
            font-size: 1em;
            font-weight: bold;
            color: #fff;
            padding: 5px 10px;
            border-radius: 4px;
            text-align: center;
            margin-bottom: 10px;
        }

        .online {
            background-color: #007bff;
        }

        .offline {
            background-color: #ff6347;
        }

        .billing-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9em;
        }

        .customer-details, .payment-details {
            flex: 1;
            padding: 10px;
        }

        .customer-details h3 {
            font-size: 1.2em;
            margin: 0 0 5px;
        }

        .billing-details-info, .payment-details-info {
            font-size: 0.85em;
            color: #555;
            margin-top: 5px;
        }
        .centered-button-container {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            text-align: center;
        }
        .home-button {
	            padding: 10px 20px;
	            font-size: 16px;
	            background-color: #8c7c00;
	            color: white;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            text-decoration: none;
        }
        .home-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Billing History</h2>
    <%
        if (billHistory != null && !billHistory.isEmpty()) {
            for (Billing bill : billHistory) {
                Customer customer = bill.getCustomer();
                
                // Formatting the payment date and time
                java.sql.Timestamp paymentDateTime = bill.getPaymentDate();
                java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm:ss");
                
                String formattedDate = dateFormat.format(paymentDateTime);
                String formattedTime = timeFormat.format(paymentDateTime);

                // Determine booking type label and color class
                String bookingLabel = (bill.getCustId() == 18) ? "Offline Booking" : "Online Booking";
                String labelClass = (bill.getCustId() == 18) ? "offline" : "online";
    %>
                <div class="billing-card">
                    <!-- Booking Type Label -->
                    <div class="booking-label <%= labelClass %>"><%= bookingLabel %></div>

                    <div class="billing-details">
                        <!-- Customer Details -->
                        <div class="customer-details">
                            <h3><%= customer.getName() %></h3>
                            <div class="billing-details-info">
                                <p><strong>Email:</strong> <%= customer.getEmail() %></p>
                                <p><strong>Phone No:</strong> <%= customer.getPhoneNo() %></p>
                            </div>
                        </div>

                        <!-- Payment and Billing Details -->
                        <div class="payment-details">
                            <div class="payment-details-info">
                                <p><strong>Bill ID:</strong> <%= bill.getBillId() %></p>
                                <p><strong>Booking ID:</strong> <%= bill.getBookingId() %></p>
                                <p><strong>Total Bill:</strong> ₹<%= String.format("%.2f", bill.getTotalBill()) %></p>
                                <p><strong>Payment Date:</strong> <%= formattedDate %></p>
                                <p><strong>Payment Time:</strong> <%= formattedTime %></p>
                            </div>
                        </div>
                    </div>
                </div>
    <%
            }
        } else {
    %>
        <p>No billing records found.</p>
    <%
        }
    %>
    <div class="centered-button-container">
        <a href="RoomsController?action=manager" class="home-button">Go to Home</a>
    </div>
</body>
</html>
