<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Booking" %>
<%@ page import="java.util.List,java.time.LocalDate,java.time.temporal.ChronoUnit" %>
<%
    boolean isPayed = false;
    if("payed".equals(request.getAttribute("payed"))){
        isPayed = true;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Offline Booking Payment</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .booking-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            width: 100%;
            max-width: 1200px;
        }

        .booking-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: transform 0.2s;
            border-left: 5px solid goldenrod;
        }

        .booking-card:hover {
            transform: translateY(-5px);
        }

        .customer-header {
            font-size: 1.4em;
            color: goldenrod;
            margin-bottom: 10px;
            font-weight: bold;
            text-align: center;
        }

        .booking-details {
            color: #666;
        }

        .detail {
            margin: 5px 0;
        }

        .price {
            font-size: 1.2em;
            color: goldenrod;
            font-weight: bold;
        }

        .button-container {
            margin-top: 15px;
            text-align: center;
        }

        .pay-checkout-button {
            padding: 10px 20px;
            font-size: 1em;
            font-weight: bold;
            color: #fff;
            background-color: goldenrod;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .pay-checkout-button:hover {
            background-color: grey;
        }
       .go-home-button {
	        display: inline-block;
	        background-color: #d4af37; /* Gold background */
	        color: white; /* White text */
	        padding: 10px 20px; /* Padding */
	        text-decoration: none; /* No underline */
	        border-radius: 5px; /* Rounded corners */
	        font-size: 18px; /* Font size */
	        transition: background-color 0.3s, transform 0.2s; /* Hover effects */
	        position: fixed; /* Fix position */
	        bottom: 20px; /* Distance from the bottom */
	        left: 43%; /* Center horizontally */
       }

        .go-home-button:hover {
            background-color: #c19a28; /* Darker gold on hover */
            transform: scale(1.05); /* Scale up on hover */
        }
    </style>
</head>
<body>
	<%
        if(isPayed) {
    %>
        <script type="text/javascript">
                alert("The Payment was done and checkout details updated successfully.");
                window.location.href = "OfflineBookingController";
        </script>
    <%
        }
    %>
<h2>Offline Bookings</h2>

		<%
		    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
		
		    if (bookings != null && !bookings.isEmpty()) {
		%>
		    <div class="booking-container">
		        <%
		            for (Booking booking : bookings) {
		                if (booking.getBookingStatus() == 1) {
		                	LocalDate checkin = booking.getCheckinDate().toLocalDate();
		                    double totalStayCost = ChronoUnit.DAYS.between(checkin, booking.getCheckoutDate().toLocalDate()) * booking.getPricepernight();
		                    Double totalBill = totalStayCost; // Assuming total bill is room price per night here
		        %>
		            <form action="BillingController" method="post" class="booking-card">
		                <div class="customer-header">
		                    <%= booking.getCustomer().getName() %>
		                </div>
		                <div class="booking-details">
		                    <p class="detail"><strong>Booking ID:</strong> <%= booking.getBookingId() %></p>
		                    <p class="detail"><strong>Room ID:</strong> <%= booking.getRoomId() %></p>
		                    <p class="detail"><strong>Room PricePerNight:</strong> ₹<%= booking.getPricepernight()%></p>
		                    <p class="detail"><strong>Check-in Date:</strong> <%= booking.getCheckinDate() %></p>
		                    <p class="detail"><strong>Check-out Date:</strong> <%= booking.getCheckoutDate() %></p>
		                    <p class="detail"><strong>Email:</strong> <%= booking.getCustomer().getEmail() %></p>
		                    <p class="detail"><strong>Phone Number:</strong> <%= booking.getCustomer().getPhoneNo() %></p>
		                    <p class="price"><strong>Room Price:</strong> ₹<%= totalBill %></p>
		                </div>
		                
		                <!-- Hidden fields to pass parameters to BillingController -->
		                <input type="hidden" name="customerId" value="<%=18%>">
		                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
		                <input type="hidden" name="totalBill" value="<%= totalBill %>">
		                
		                <div class="button-container">
		                    <button type="submit" class="pay-checkout-button">Pay & Checkout</button>
		                </div>
		            </form>
		        <%
		                }
		            }
		        %>
		    </div>
		<%
		    } else {
		%>
		    <p>No offline bookings available.</p>
		<%
		    }
		%>
		<div style="text-align: center; margin-top: 20px;">
	        <a href="receptionist.jsp" class="go-home-button">Go to Home Page</a>
	    </div>

</body>
</html>
