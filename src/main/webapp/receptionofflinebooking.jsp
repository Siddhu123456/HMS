<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Rooms" %>
<%@ page import="com.controler.RoomsController" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reception Offline Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            color: #333;
        }

        h1 {
            color: #4CAF50;
            text-align: center;
        }

        .room-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .room {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-bottom: 15px;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .room-info {
            display: flex;
            align-items: center;
            width: 100%;
        }

        .room img {
            border-radius: 5px;
            margin-right: 20px;
        }

        .room-info h2 {
            font-size: 20px;
            color: #333;
            margin: 0;
        }

        .room-info p {
            margin: 5px 0;
            color: #666;
        }

        .room-price {
            font-size: 16px;
            color: #4CAF50;
            font-weight: bold;
        }

        .book-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            margin-top: 10px;
        }

        .book-button:hover {
            background-color: #45a049;
        }

        .booking-form {
            display: none;
            width: 100%;
            margin-top: 20px;
            padding: 15px;
            background-color: #f1f1f1;
            border-radius: 5px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .booking-form label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
        }

        .booking-form input, .booking-form select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .submit-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .submit-button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function showBookingForm(roomId) {
            const form = document.getElementById('booking-form-' + roomId);
            form.style.display = form.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</head>
<body>
    <div class="room-container">
        <h1>Available Rooms For Offline Bookings</h1>
        <% 
            ArrayList<Rooms> roomList = (ArrayList<Rooms>)request.getAttribute("roomList");
        	Integer custId = (Integer) request.getAttribute("custId");
        	String checkinDate = (String) request.getAttribute("checkindate");
            String checkoutDate = (String) request.getAttribute("checkoutdate");
            
            for (Rooms room : roomList) {
        %>
        <div class="room">
            <div class="room-info">
                <img src="<%= room.getRoomImage() %>" alt="<%= room.getRoomType() %>" width="100" height="100" />
                <div>
                    <h2><%= room.getRoomType() %></h2>
                    <p><%= room.getRoomDescription() %></p>
                    <p class="room-price">$<%= room.getRoomPrice() %> per night</p>
                </div>
            </div>
            <button class="book-button" onclick="showBookingForm(<%= room.getRoomId() %>)">Book Room</button>
            
            <!-- Booking Form -->
            <div class="booking-form" id="booking-form-<%= room.getRoomId() %>">
                <form action="OfflineBookingController" method="post">
                    
                    <input type="hidden" name="action" value="bookroom">
                    
                    <label for="name">Name of the Customer:</label>
                    <input type="text" id="name" name="name" required>
                    
                    <label for="email">Email Id of Customer:</label>
                    <input type="email" id="email" name="email" required>
                    
                    <label for="phone_no">Phone No:</label>
            		<input type="text" id="phone_no" name="phone_no">
                                       
                    <label for="cust_id">Customer ID:</label>
                    <input type="text" id="cust_id" name="cust_id" value="<%= custId %>" required readonly>
                    
                    <label for="room_id">Room ID:</label>
                    <input type="text" id="room_id" name="room_id" value="<%= room.getRoomId() %>" readonly>
                    
                    <label for="checkin_date">Checkin Date:</label>
                    <input type="date" id="checkout_date" name="checkin_date" value="<%= checkinDate %>" required readonly>
                    
                    <label for="checkout_date">Checkout Date:</label>
                    <input type="date" id="checkout_date" name="checkout_date" value="<%= checkoutDate %>" required readonly>
                   
                    <button type="submit" class="submit-button">Confirm Booking</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
</body>
</html>
