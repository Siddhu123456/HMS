<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Booking" %>
<%@ page session="true" %>
<%@ page import="java.time.LocalDate"%>

<%
    // Check if the user is logged in
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    LocalDate currentDate = LocalDate.now();
    
    boolean isBooked = false;
    if("success".equals(request.getAttribute("booking"))) {
    	isBooked = true;
    }
    boolean isOrdered = false;
    if("success".equals(request.getAttribute("foodorder"))) {
    	isBooked = true;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
         body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0; /* Light grey background */
            color: #333; /* Dark grey text */
        }
        header {
            background-color: #d4af37; /* Gold background */
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex; /* Use flexbox for alignment */
            align-items: center; /* Center items vertically */
            justify-content: space-between; /* Space between title and nav */
        }
        
        nav {
            display: flex; /* Use flexbox for nav items */
            align-items: center; /* Center items vertically */
        }
        nav a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            margin: 0 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        nav a:hover {
            background-color: rgba(255, 255, 255, 0.2); /* Lighten on hover */
        }
        .content {
            padding: 20px;
            background-color: white; /* White content area */
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .logout-button {
            background-color: #d4af37; /* Gold button */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-right: 20px; /* Space between logout button and nav links */
        }
        .logout-button:hover {
            background-color: #c19a28; /* Darker gold on hover */
        }
        
        .card {
            background-color: #fff; /* White background for the card */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            padding: 20px; /* Padding inside the card */
            text-align: center; /* Center text */
            width: 300px; /* Fixed width */
            margin: 5%;
            transition: transform 0.2s; /* Smooth scaling effect */
            display: inline-block; /* Make the card inline-block for centering */
        }

        .card:hover {
            transform: scale(1.05); /* Scale up on hover */
        }

        .card-title {
            font-size: 24px; /* Title font size */
            color: #d4af37; /* Gold color for title */
            margin: 0; /* No margin */
        }

        .card-description {
            margin: 10px 0; /* Margin for description */
            color: #555; /* Dark grey color for description */
        }

        .book-button {
            background-color: #d4af37; /* Gold background */
            color: white; /* White text */
            border: none; /* No border */
            padding: 15px 25px; /* Padding inside the button */
            border-radius: 5px; /* Rounded corners */
            font-size: 18px; /* Font size */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background-color 0.3s, transform 0.2s; /* Smooth hover effects */
            margin-top: 15px; /* Margin above the button */
        }

        .book-button:hover {
            background-color: #c19a28; /* Darker gold on hover */
            transform: scale(1.05); /* Slightly scale up on hover */
        }

        /* Styles for the input fields */
        input[type="date"] {
            padding: 10px; /* Padding for input */
            border: 1px solid #ccc; /* Light grey border */
            border-radius: 5px; /* Rounded corners */
            margin: 10px 0; /* Margin for spacing */
            font-size: 16px; /* Font size */
            width: 100%; /* Full width */
            box-sizing: border-box; /* Box sizing for width */
            transition: border-color 0.3s; /* Transition for border color */
        }

        input[type="date"]:focus {
            border-color: #d4af37; /* Gold border on focus */
            outline: none; /* Remove outline */
        }
        
        /* Container for all booking cards */
	    .booking-cards-container {
	        display: flex;
	        flex-wrap: wrap;
	        gap: 20px;
	    }
	    
	    /* Individual booking card styling */
	    .booking-card {
	        width: 300px;
	        border-radius: 10px;
	        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	        overflow: hidden;
	        background-color: #ffffff;
	        font-family: Arial, sans-serif;
	        transition: transform 0.3s ease;
	    }
	    
	    .booking-card:hover {
	        transform: scale(1.05);
	    }
	
	    /* Header section with status color-coding */
	    .card-header {
	        padding: 10px;
	        color: white;
	        font-weight: bold;
	        text-align: center;
	    }
	
	    .status-pending .card-header {
		    background-color: #ffebcc;
		    color: #cc8400;
		}
		
		.status-confirmed .card-header {
		    background-color: #cce5ff;
		    color: #0056b3;
		}
		
		.status-active .card-header {
		    background-color: #c6e6b3;
		    color: #388e3c;
		}
		
		.status-cancelled .card-header {
		    background-color: #f8d7da;
		    color: #721c24;
		}
		
		.status-completed .card-header {
		    background-color: #e2e3e5;
		    color: #6c757d;
		}
	
	    /* Body section of the card */
	    .card-body {
	        padding: 20px;
	        text-align: left;
	    }
	
	    /* Order button styling */
	    .order-button {
	        margin-top: 10px;
	        padding: 10px 20px;
	        border: none;
	        border-radius: 5px;
	        background-color: #4CAF50;
	        color: white;
	        font-size: 14px;
	        cursor: pointer;
	        transition: background-color 0.3s;
	    }
	
	    .order-button:hover {
	        background-color: #45a049;
	    }
    </style>
    <script>
	    function orderFood(bookingId, customerId, roomId) {
	        console.log("Booking ID:", bookingId, "Customer ID:", customerId, "Room ID:", roomId);
	        document.getElementById("bookingIdInput").value = bookingId;
	        document.getElementById("customerIdInput").value = customerId;
	        document.getElementById("roomIdInput").value = roomId;
	        document.getElementById("orderFoodForm").submit();
	    }
	    function submitFoodOrderForm() {
            document.getElementById("foodOrderForm").submit();
        }
	    function updateCheckoutMinDate() {
            // Get the selected check-in date value
            const checkinDate = document.getElementById("checkin_date").value;
            
            // Set the minimum value of the checkout date to be the day after the check-in date
            document.getElementById("checkout_date").min = checkinDate;
        }
    </script>
</head>
<body>
	<%
		if(isBooked) {
	%>
		<script type="text/javascript">
	        	alert("Your booking was successfull");
	        	window.location.href = "BookingController?action=login";
	    	</script>
	<% 	
		}
	%>	
	<%
		if(isOrdered) {
	%>
		<script type="text/javascript">
	        	alert("Your foodorder was successfull");
	        	window.location.href = "BookingController?action=login";
	    	</script>
	<% 	
		}
	%>	
    <header>
        <h2>Blissful Haven</h2>
        <nav>
            <a href="#">Home</a>
            <a href="FeedbackController?custId=<%=customer.getCustomerId()%>">SubmitFeedback</a>
            <a href="javascript:void(0);" onclick="submitFoodOrderForm()">View Your FoodOrders</a>
            
            <form action="LoginController" method="post" style="margin-right: 10px;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </nav>
    </header>

    <div class="content">
        <h2>Welcome, <%= customer.getName() %></h2>
        <p>Email: <%= customer.getEmail() %></p>
        <p>Phone No: <%= customer.getPhoneNo() %></p>
    </div>
    
    <!-- Card as a form for booking a room -->
    <form action="RoomsController" method="get" class="card">
        <input type="hidden" name="customer_id" value="<%= customer.getCustomerId() %>">
        
        <h2 class="card-title">Book Your Room</h2>
        
        <label for="checkin_date">Enter Check-in Date: </label>
        <input type="date" name="checkin_date" id="checkin_date" 
               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" 
               onchange="updateCheckoutMinDate()" required>
        
        <label for="checkout_date">Enter Check-out Date: </label>
        <input type="date" name="checkout_date" id="checkout_date" 
               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
        
        <button type="submit" class="book-button">Book Room</button>
    </form>
    
    <%-- Display User's Booked Rooms --%>
    <div class="content">
	    <h2>Your Booked Rooms</h2>
	    <%
	        List<Booking> userBookings = (List<Booking>) request.getAttribute("userBookings");
	        if (userBookings != null && !userBookings.isEmpty()) {
	            boolean hasActiveBookings = false;
	    %>
	
	        <!-- Active Bookings Section -->
	        <h3>Active Bookings</h3>
	        <div class="booking-cards-container">
	            <% for (Booking booking : userBookings) {
	                LocalDate checkinDate = booking.getCheckinDate().toLocalDate();
	                LocalDate checkoutDate = booking.getCheckoutDate().toLocalDate();
	                boolean isWithinStay = currentDate.isEqual(checkinDate) || (!currentDate.isBefore(checkinDate) && !currentDate.isAfter(checkoutDate));
	
	                // Show only active bookings in this section
	                if (booking.getBookingStatus() == 1 && isWithinStay) {
	                    hasActiveBookings = true;
	            %>
	                <div class="booking-card status-active">
	                    <div class="card-header">
	                        <strong>Status:</strong> Active
	                    </div>
	                    <div class="card-body">
	                        <p><strong>Room Number:</strong> <%= booking.getRoomId() %></p>
	                        <p><strong>Check-in Date:</strong> <%= checkinDate %></p>
	                        <p><strong>Check-out Date:</strong> <%= checkoutDate %></p>
	                        
	                        <!-- Show Food Order button for active bookings only -->
	                        <button onclick="orderFood(<%= booking.getBookingId() %>, <%= customer.getCustomerId() %>, <%= booking.getRoomId() %>)" class="order-button">Order Food</button>
	                    </div>
	                </div>
	            <% } } %>
	            <% if (!hasActiveBookings) { %>
	                <p>You have no active bookings.</p>
	            <% } %>
	        </div>
	
	        <!-- Other Bookings Section -->
	        <h3>All Bookings</h3>
	        <div class="booking-cards-container">
	            <% for (Booking booking : userBookings) { 
	                LocalDate checkinDate = booking.getCheckinDate().toLocalDate();
	                LocalDate checkoutDate = booking.getCheckoutDate().toLocalDate();
	                boolean isWithinStay = !currentDate.isBefore(checkinDate) && !currentDate.isAfter(checkoutDate);
	
	                // Skip active bookings in this section
	                if (booking.getBookingStatus() == 1 && isWithinStay) continue;
	
	                // Determine the appropriate CSS class based on booking status
	                String statusClass;
	                switch (booking.getBookingStatus()) {
	                    case 0:
	                        statusClass = "status-pending"; // Pending
	                        break;
	                    case 1:
	                        statusClass = "status-confirmed"; // Confirmed
	                        break;
	                    case 2:
	                        statusClass = "status-cancelled"; // Cancelled
	                        break;
	                    case 3:
	                        statusClass = "status-completed"; // Completed
	                        break;
	                    default:
	                        statusClass = "status-default"; // Default if unknown status
	                        break;
	                }
	            %>
	            <div class="booking-card <%= statusClass %>">
	                <div class="card-header">
	                    <strong>Status:</strong> 
	                    <%= booking.getBookingStatus() == 0 ? "Pending" : 
	                        (booking.getBookingStatus() == 1 ? "Confirmed" : 
	                        (booking.getBookingStatus() == 2 ? "Cancelled" : "Completed")) %>
	                </div>
	                <div class="card-body">
	                    <p><strong>Room Number:</strong> <%= booking.getRoomId() %></p>
	                    <p><strong>Check-in Date:</strong> <%= checkinDate %></p>
	                    <p><strong>Check-out Date:</strong> <%= checkoutDate %></p>
	                </div>
	            </div>
	            <% } %>
	        </div>
	    <%
	        } else {
	    %>
	        <p>You have no booked rooms.</p>
	    <%
	        }
	    %>
	</div>
    
    <form id="foodOrderForm" action="FoodOrderController" method="get" style="display: none;">
        <!-- Include any hidden fields here if needed -->
        <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
    </form>

<!-- Hidden form for submitting bookingId and customer_id to FoodController -->
<form id="orderFoodForm" action="FoodController" method="get" style="display:none;">
    <input type="hidden" name="bookingId" id="bookingIdInput">
    <input type="hidden" name="customer_id" id="customerIdInput">
    <input type="hidden" name="room_id" id="roomIdInput">
    <input type="hidden" name="action" value="dashboard">
</form>
</body>
</html>
