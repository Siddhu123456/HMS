<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Booking" %>
<%@ page import="com.model.Customer" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receptionist booking requests Management</title>
<style>
    /* Page Layout */
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
        color: #333;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    h1 {
        font-size: 36px;
        color: goldenrod;
        margin: 20px 0;
        text-align: center;
    }
    h2 {
        font-size: 24px;
        color: #555;
        margin: 20px 0;
        text-align: left;
        width: 90%;
        max-width: 800px;
        border-bottom: 2px solid #ddd;
        padding-bottom: 5px;
    }

    /* Booking Container */
    .bookingContainer {
        display: flex;
        flex-direction: column;
        gap: 15px;
        width: 90%;
        max-width: 800px;
        margin: auto;
    }

    /* Booking Card */
    .bookingCard {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-left: 5px solid;
        border-color: goldenrod;
    }
    .bookingCard.acceptedRooms { border-color: #2196F3; }
    .bookingCard.canceledRooms { border-color: #f44336; }

    .bookingDetails, .customerDetails {
        flex: 1;
        font-size: 14px;
        color: #555;
    }
    .bookingDetails p, .customerDetails p {
        margin: 2px 0;
    }
    .customerDetails span, .bookingDetails span {
        font-weight: bold;
    }

    /* Action Buttons */
    .action-buttons {
        display: flex;
        gap: 5px;
        align-items: center;
    }
    .action-buttons button {
        padding: 8px 12px;
        font-size: 18px;
        cursor: pointer;
        border: none;
        border-radius: 5px;
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .accept-button {
        background-color: #4CAF50;
    }
    .reject-button {
        background-color: #f44336;
    }
    .no-canceled-rooms { text-align: center; font-style: italic; color: #777; }
    
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
<script type="text/javascript">
	function filterBookings() {
	    const searchInput = document.getElementById("searchInput").value.toLowerCase();
	    const bookingCards = document.getElementsByClassName("bookingCard");
	    
	    Array.from(bookingCards).forEach(card => {
	        const bookingId = card.getAttribute("data-booking-id").toLowerCase();
	        const customerName = card.getAttribute("data-customer-name").toLowerCase();
	        const roomId = card.getAttribute("data-room-id").toLowerCase();
	
	        if (bookingId.includes(searchInput) || customerName.includes(searchInput) || roomId.includes(searchInput)) {
	            card.style.display = "flex"; // Show card if it matches
	        } else {
	            card.style.display = "none"; // Hide card if it doesn't match
	        }
	    });
	}
</script>
</head>
<body>
    <h1>Blissful Haven</h1>
    
    <div style="margin-bottom: 20px;margin-left : -15%;">
        <input type="text" id="searchInput" onkeyup="filterBookings()" placeholder="Search by Booking ID, Customer Name, or Room ID" style="width: 190%; max-width: 800px; padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 5px;">
    </div>

    <div class="bookingContainer">
        <!-- Pending Booked Rooms -->
        <h2>Pending Bookings</h2>
        <%
            ArrayList<Booking> bookingList = (ArrayList<Booking>) request.getAttribute("bookingList");
            ArrayList<Customer> customerDetails = (ArrayList<Customer>) request.getAttribute("customerDetails");
			
            boolean hasPendingBookings = false;
            for (int i = 0; i < bookingList.size(); i++) {
                Booking booking = bookingList.get(i);
                Customer customer = customerDetails.get(i);

                if (booking.getBookingStatus() == 0) {
                	hasPendingBookings = true;
        %>
                    <div class="bookingCard" 
                         data-booking-id="<%= booking.getBookingId() %>"
                         data-customer-name="<%= customer.getName() %>"
                         data-room-id="<%= booking.getRoomId() %>">
                        <div class="bookingDetails">
                            <p><span>Booking ID:</span> <%= booking.getBookingId() %></p>
                            <p><span>Room ID:</span> <%= booking.getRoomId() %></p>
                            <p><span>Check-In:</span> <%= booking.getCheckinDate() %></p>
                            <p><span>Check-Out:</span> <%= booking.getCheckoutDate() %></p>
                        </div>
                        <div class="customerDetails">
                            <p><span>Name:</span> <%= customer.getName() %></p>
                            <p><span>Email:</span> <%= customer.getEmail() %></p>
                            <p><span>Phone:</span> <%= customer.getPhoneNo() %></p>
                        </div>
                        <div class="action-buttons">
                            <form action="BookingController" method="post">
                                <input type="hidden" name="action" value="receptionist">
                                <input type="hidden" name="booking_id" value="<%= booking.getBookingId() %>">
                                <input type="hidden" name="booking_status" value="1">
                                <button type="submit" class="accept-button">✔</button>
                            </form>
                            <form action="BookingController" method="post">
                                <input type="hidden" name="action" value="receptionist">
                                <input type="hidden" name="booking_id" value="<%= booking.getBookingId() %>">
                                <input type="hidden" name="booking_status" value="2">
                                <button type="submit" class="reject-button">✖</button>
                            </form>
                        </div>
                    </div>
        <%
                }
            }
            if (!hasPendingBookings) {
        %>
                <div class="no-canceled-rooms">
                    <p>No bookings are pending.</p>
                </div>
        <%
            }
        %>

        <!-- Accepted Bookings -->
        <h2>Accepted Bookings</h2>
        <%	
        	boolean hasAcceptedBookings = false;
            for (int i = 0; i < bookingList.size(); i++) {
                Booking booking = bookingList.get(i);
                Customer customer = customerDetails.get(i);

                if (booking.getBookingStatus() == 1) {
                	hasAcceptedBookings = true;
        %>
                    <div class="bookingCard acceptedRooms" 
                         data-booking-id="<%= booking.getBookingId() %>"
                         data-customer-name="<%= customer.getName() %>"
                         data-room-id="<%= booking.getRoomId() %>">
                        <div class="bookingDetails">
                            <p><span>Booking ID:</span> <%= booking.getBookingId() %></p>
                            <p><span>Room ID:</span> <%= booking.getRoomId() %></p>
                            <p><span>Check-In:</span> <%= booking.getCheckinDate() %></p>
                            <p><span>Check-Out:</span> <%= booking.getCheckoutDate() %></p>
                        </div>
                        <div class="customerDetails">
                            <p><span>Name:</span> <%= customer.getName() %></p>
                            <p><span>Email:</span> <%= customer.getEmail() %></p>
                            <p><span>Phone:</span> <%= customer.getPhoneNo() %></p>
                        </div>
                    </div>
        <%
                }
            }
            if (!hasAcceptedBookings) {
        %>
                <div class="no-canceled-rooms">
                    <p>No bookings were Accepted.</p>
                </div>
        <%
            }
        %>

        <!-- Canceled Bookings -->
        <h2>Canceled Bookings</h2>
        <%
            boolean hasCanceledBookings = false;
            for (int i = 0; i < bookingList.size(); i++) {
                Booking booking = bookingList.get(i);
                Customer customer = customerDetails.get(i);

                if (booking.getBookingStatus() == 2) {
                    hasCanceledBookings = true;
        %>
                    <div class="bookingCard canceledRooms" 
                         data-booking-id="<%= booking.getBookingId() %>"
                         data-customer-name="<%= customer.getName() %>"
                         data-room-id="<%= booking.getRoomId() %>">
                        <div class="bookingDetails">
                            <p><span>Booking ID:</span> <%= booking.getBookingId() %></p>
                            <p><span>Room ID:</span> <%= booking.getRoomId() %></p>
                            <p><span>Check-In:</span> <%= booking.getCheckinDate() %></p>
                            <p><span>Check-Out:</span> <%= booking.getCheckoutDate() %></p>
                        </div>
                        <div class="customerDetails">
                            <p><span>Name:</span> <%= customer.getName() %></p>
                            <p><span>Email:</span> <%= customer.getEmail() %></p>
                            <p><span>Phone:</span> <%= customer.getPhoneNo() %></p>
                        </div>
                     </div>
        <%
                }
            }
            if (!hasCanceledBookings) {
        %>
                <div class="no-canceled-rooms">
                    <p>No bookings were canceled.</p>
                </div>
        <%
            }
        %>
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
        <a href="receptionist.jsp" class="go-home-button">Go to Home Page</a>
    </div>
</body>
</html>
