<%@ page import="com.model.Booking, com.model.FoodOrder, com.model.Customer, java.util.List" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.stream.Collectors" %>
<%
    boolean isPayed = false;
    if("payed".equals(request.getAttribute("payed"))){
        isPayed = true;
    }
%>
<html>
<head>
    <title>Online Bookings payments Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eaeaea; /* Light grey background */
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px; /* Set a max width for the container */
            margin: 0 auto; /* Center align the container */
            padding: 20px;
        }
        .card {
            background-color: #ffffff; /* White for the card */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin: 20px 0; /* Space between cards */
            padding: 20px;
            text-align: left;
            color: #333;
            display: flex;
            flex-direction: column; /* Stack items vertically */
            width: 100%; /* Full width of container */
            border-left: 6px solid #ffcc00; /* Gold highlight on left border */
            position: relative;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .customer-name {
            font-size: 24px; /* Larger font size for customer name */
            color: #6A5ACD; /* Slate Blue color for name */
            margin: 10px 0; /* Space above and below */
        }
        .booking-id {
            font-size: 20px; /* Medium font size for booking ID */
            color: #b8860b; /* Dark golden rod color */
            font-weight: bold;
        }
        .booking-info {
            display: flex; /* Align items in a row */
		    justify-content: space-between; /* Distribute space between items */
		    gap: 20px; /* Space between each section */
		    width: 100%; /* Full width */
        }
        .booking-detail {
            flex: 1; /* Each section takes up equal space */
		    min-width: 250px; /* Minimum width for each section */
		    margin: 0; /* Remove extra margin */
		    padding: 10px;
		    background-color: #f8f8f8; /* Light background for details */
		    border-radius: 6px;
        }
        .card h3 {
            color: #4b0082; /* Indigo color for headings */
            margin-bottom: 10px; /* Space below heading */
        }
        .card p {
            margin: 5px 0;
        }
        .card hr {
            border: 0;
            border-top: 1px solid #ddd;
            margin: 10px 0;
        }
        .food-order {
            background-color: #f8f8f8;
	        padding: 10px;
	        border-radius: 6px;
	        margin-top: 10px;
	        display: flex; /* Flex for inline arrangement */
	        flex-wrap: wrap; /* Allow wrapping if too many orders */
	        gap: 10px; /* Space between orders */
        }
        .food-order div {
            flex: 1 1 30%; /* Each order takes up to 30% of the width */
	        background-color: #ffffff; /* White background for each order */
	        border-radius: 6px;
	        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for each order box */
	        padding: 10px;
	        min-width: 150px; /* Minimum width to avoid overly small boxes */
        }
        .price {
            font-weight: bold;
            color: #4b0082; /* Indigo for price */
        }
        .highlight {
            color: #4b0082; /* Indigo for highlights */
            font-weight: bold;
        }
        .no-food-orders {
            color: #888;
            font-style: italic;
            margin-top: 10px;
        }
        .total-bill {
            font-weight: bold;
            color: #6A5ACD; /* Slate Blue for total bill */
            margin-top: 20px; /* Space above total bill */
        }
        .pay-checkout-btn {
	            background-color: #ffcc00; /* Gold color */
	            color: #fff;
	            padding: 10px 20px;
	            font-size: 16px;
	            font-weight: bold;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            position: absolute; /* Position at bottom-right */
	            bottom: 20px;
	            right: 20px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	        }
	
	     .pay-checkout-btn:hover {
	            background-color: #b8860b; /* Darker gold on hover */
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
	        left: 45%; /* Center horizontally */
       }

        .go-home-button:hover {
            background-color: #c19a28; /* Darker gold on hover */
            transform: scale(1.05); /* Scale up on hover */
        }
    </style>
    <script>
    function filterBookings() {
        const searchInput = document.getElementById("searchInput").value.toLowerCase();
        const bookingCards = document.getElementsByClassName("card");
        
        Array.from(bookingCards).forEach(card => {
            
            const bookingId = card.getAttribute("data-booking-id").toLowerCase();
            const customerName = card.getAttribute("data-customer-name").toLowerCase();
            const customerId = card.getAttribute("data-customer-id").toLowerCase();
            const roomId = card.getAttribute("data-room-id").toLowerCase();

            if (
                bookingId.includes(searchInput) ||
                customerId.includes(searchInput) ||
                customerName.includes(searchInput) ||
                roomId.includes(searchInput)
            ) {
                card.style.display = "block"; 
            } else {
                card.style.display = "none";
            }
        });
    }

	</script>
</head>
<body>
<%
        if(isPayed) {
    %>
        <script type="text/javascript">
                alert("The Payment was done and checkout details updated successfully.");
                window.location.href = "ReceptionistpayController";
        </script>
    <%
        }
    %>
<h1 style="text-align: center; color: #4b0082;">Booking Details</h1>
<div class="container">


	<div style="margin-bottom: 20px;margin-left : 28.5%;">
        <input type="text" id="searchInput" onkeyup="filterBookings()" placeholder="Search by Booking ID, CustomerId, Customer Name, or Room ID" style="width: 140%; max-width: 500px; padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 5px;">
    </div>
    
    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
        // Get today's date
        LocalDate today = LocalDate.now();
        
     // Filter bookings that are scheduled for checkout today and have bookingStatus 1
        List<Booking> todaysCheckouts = bookings.stream()
            .filter(booking -> booking.getCheckoutDate().toLocalDate().isEqual(today) && booking.getBookingStatus() == 1)
            .collect(Collectors.toList());

        // Filter bookings that are not scheduled for checkout today and have bookingStatus 1
        List<Booking> otherBookings = bookings.stream()
            .filter(booking -> !booking.getCheckoutDate().toLocalDate().isEqual(today) && booking.getBookingStatus() == 1)
            .collect(Collectors.toList());
    %>

    <!-- Display today's checkouts -->
    <h3 style="color: #4b0082;">Bookings Scheduled for Completion Today</h3>
    <div class="container">
        <% if (!todaysCheckouts.isEmpty()) { 
            for (Booking booking : todaysCheckouts) {
                LocalDate checkin = booking.getCheckinDate().toLocalDate();
                double totalStayCost = ChronoUnit.DAYS.between(checkin, today) * booking.getPricepernight();
                double totalFoodCost = 0; // Initialize total food cost
                
                // Calculate total food order cost
                if (booking.getFoodorder() != null) {
                    for (FoodOrder order : booking.getFoodorder()) {
                        totalFoodCost += order.getOrderTotalPrice();
                    }
                }
                
                // Calculate total bill
                double totalBill = totalStayCost + totalFoodCost;
        %>
        <div class="card"
        	 data-booking-id="<%= booking.getBookingId() %>"
		     data-customer-id="<%= booking.getCustId() %>"
		     data-customer-name="<%= booking.getCustomer().getName() %>"
		     data-room-id="<%= booking.getRoomId() %>"
        >
            <div class="header">
                <p class="customer-name"><%= booking.getCustomer().getName() %></p>
                <h2 class="booking-id">Booking ID: <%= booking.getBookingId() %></h2>
            </div>

            <div class="booking-info">
                <div class="booking-detail">
                    <h3>Customer Info</h3>
                    <p><span class="highlight">Customer ID:</span> <%= booking.getCustId() %></p>
                    <p><span class="highlight">Email:</span> <%= booking.getCustomer().getEmail() %></p>
                    <p><span class="highlight">Phone No:</span> <%= booking.getCustomer().getPhoneNo() %></p>
                </div>
                <div class="booking-detail">
                    <h3>Booking Details</h3>
                    <p><span class="highlight">Room ID:</span> <%= booking.getRoomId() %></p>
                    <p><span class="highlight">Check-in Date:</span> <%= booking.getCheckinDate() %></p>
                    <p><span class="highlight">Check-out Date:</span> <%= booking.getCheckoutDate() %></p>
                </div>
                <div class="booking-detail">
                    <h3>Cost Summary</h3>
                    <p><span class="highlight">Price per Night:</span> <span class="price"><%= booking.getPricepernight() %></span></p>
                    <p><span class="highlight">Total Cost:</span> <span class="price"><%= totalStayCost %></span></p>
                </div>
            </div>

            <hr>

            <h3 style="color: #4b0082;">Food Orders</h3>
            <% if (booking.getFoodorder() != null && !booking.getFoodorder().isEmpty()) { %>
                <div class="food-order">
                    <% for (FoodOrder order : booking.getFoodorder()) { %>
                        <div>
                            <p>Order ID: <%= order.getOrderId() %></p>
                            <p>Order Date: <%= order.getOrderDate() %></p>
                            <p>Total Price: <span class="price"><%= order.getOrderTotalPrice() %></span></p>
                            <p>Order Status: <%= order.isOrderStatus() ? "Completed" : "Pending" %></p>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <p class="no-food-orders">No food orders were placed by this customer.</p>
            <% } %>

            <p class="total-bill">Total Bill: <%= totalBill %></p>
            <form action="BillingController" method="post" style="display: inline;">
                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                <input type="hidden" name="customerId" value="<%= booking.getCustId() %>">
                <input type="hidden" name="totalBill" value="<%= totalBill %>">
                <button type="submit" class="pay-checkout-btn">Pay & Checkout</button>
            </form>
        </div>
        <% 
            } 
        } else { 
        %>
            <p class="no-food-orders">No bookings scheduled for completion today.</p>
        <% 
        } 
        %>
    </div>

    <!-- Display other bookings -->
    <h3 style="color: #4b0082;">Other Bookings</h3>
    <div class="container">
        <% for (Booking booking : otherBookings) {
            LocalDate checkin = booking.getCheckinDate().toLocalDate();
            double totalStayCost = ChronoUnit.DAYS.between(checkin, booking.getCheckoutDate().toLocalDate()) * booking.getPricepernight();
            double totalFoodCost = 0; // Initialize total food cost
            
            // Calculate total food order cost
            if (booking.getFoodorder() != null) {
                for (FoodOrder order : booking.getFoodorder()) {
                    totalFoodCost += order.getOrderTotalPrice();
                }
            }
            
            // Calculate total bill
            double totalBill = totalStayCost + totalFoodCost;
        %>
        <div class="card"
          	 data-booking-id="<%= booking.getBookingId() %>"
		     data-customer-id="<%= booking.getCustId() %>"
		     data-customer-name="<%= booking.getCustomer().getName() %>"
		     data-room-id="<%= booking.getRoomId() %>"     
        >
            <div class="header">
                <p class="customer-name"><%= booking.getCustomer().getName() %></p>
                <h2 class="booking-id">Booking ID: <%= booking.getBookingId() %></h2>
            </div>

            <div class="booking-info">
                <div class="booking-detail">
                    <h3>Customer Info</h3>
                    <p><span class="highlight">Customer ID:</span> <%= booking.getCustId() %></p>
                    <p><span class="highlight">Email:</span> <%= booking.getCustomer().getEmail() %></p>
                    <p><span class="highlight">Phone No:</span> <%= booking.getCustomer().getPhoneNo() %></p>
                </div>
                <div class="booking-detail">
                    <h3>Booking Details</h3>
                    <p><span class="highlight">Room ID:</span> <%= booking.getRoomId() %></p>
                    <p><span class="highlight">Check-in Date:</span> <%= booking.getCheckinDate() %></p>
                    <p><span class="highlight">Check-out Date:</span> <%= booking.getCheckoutDate() %></p>
                </div>
                <div class="booking-detail">
                    <h3>Cost Summary</h3>
                    <p><span class="highlight">Price per Night:</span> <span class="price"><%= booking.getPricepernight() %></span></p>
                    <p><span class="highlight">Total Cost:</span> <span class="price"><%= totalStayCost %></span></p>
                </div>
            </div>

            <hr>

            <h3 style="color: #4b0082;">Food Orders</h3>
            <% if (booking.getFoodorder() != null && !booking.getFoodorder().isEmpty()) { %>
                <div class="food-order">
                    <% for (FoodOrder order : booking.getFoodorder()) { %>
                        <div>
                            <p>Order ID: <%= order.getOrderId() %></p>
                            <p>Order Date: <%= order.getOrderDate() %></p>
                            <p>Total Price: <span class="price"><%= order.getOrderTotalPrice() %></span></p>
                            <p>Order Status: <%= order.isOrderStatus() ? "Completed" : "Pending" %></p>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <p class="no-food-orders">No food orders were placed by this customer.</p>
            <% } %>

            <p class="total-bill">Total Bill: <%= totalBill %></p>
            <form action="BillingController" method="post" style="display: inline;">
                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                <input type="hidden" name="customerId" value="<%= booking.getCustId() %>">
                <input type="hidden" name="totalBill" value="<%= totalBill %>">
                <button type="submit" class="pay-checkout-btn">Pay & Checkout</button>
            </form>
        </div>
        <% 
            } 
        %>
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
        <a href="receptionist.jsp" class="go-home-button">Go to Home Page</a>
    </div>
</div>
</body>
</html>
