<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean isBooked = false;
	if("success".equals(request.getParameter("booking"))){
		isBooked = true;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reception</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7; /* Light grey background */
        }

        /* Navigation Bar Styles */
        .navbar {
            background-color: #333; /* Dark background for contrast */
            color: white;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .navbar .hotel-name {
            font-size: 24px;
            font-weight: bold;
            color: #d4af37; /* Gold color for the hotel name */
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .navbar .logout-button {
            background-color: #d4af37; /* Gold background */
            color: #333; /* Dark text color */
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
            text-decoration: none;
        }
        .navbar .logout-button:hover {
            background-color: #c19a28; /* Darker gold on hover */
            color: white;
        }

        /* Card styling */
        .card {
            background-color: #fff; /* White background for the card */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            padding: 20px; /* Padding inside the card */
            text-align: center; /* Center text */
            width: 300px; /* Fixed width */
            margin: 5% auto; /* Center the card horizontally */
            transition: transform 0.2s; /* Smooth scaling effect */
        }
        
        .card:hover {
            transform: scale(1.05); /* Scale up on hover */
        }
        
        /* Title styling */
        .card-title {
            font-size: 24px; /* Title font size */
            color: #d4af37; /* Gold color for title */
            margin: 0 0 20px 0; /* Margin below title */
        }
        
        /* Input fields styling */
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
        
        /* Button styling */
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
        
        /* Card Container for Functional Cards */
        .card-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            padding: 30px;
        }
        
        /* Functional Card Styling */
        .function-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 250px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s, background-color 0.3s;
            margin: 15px;
        }
        
        .function-card:hover {
            transform: scale(1.05);
            background-color: #f1f1f1;
        }

        /* Icon styling */
        .function-card i {
            font-size: 50px;
            color: #d4af37; /* Gold color for icons */
            margin-bottom: 15px;
        }

        .function-card h3 {
            font-size: 20px;
            color: #333;
            margin-top: 10px;
        }
        
    </style>
    <script>
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
	        	alert("The Offline booking was successfull.");
	        	window.location.href = "receptionist.jsp";
	    	</script>
	<% 	
		}
	%>	
    <!-- Navigation Bar -->
    <header class="navbar">
        <div class="hotel-name">Blissful Haven</div>
        <a href="index.jsp" class="logout-button">Logout</a>
    </header>

    <!-- Booking Card Section -->
    <form action="RoomsController" method="get" class="card">
        <input type="hidden" name="customer_id" value="18">
        <input type="hidden" name="action" value="reception">
        
        <h2 class="card-title">OFFLINE BOOKING</h2>
        
        <label for="checkin_date">Enter Check-in Date: </label>
        <input type="date" name="checkin_date" id="checkin_date" 
               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" 
               onchange="updateCheckoutMinDate()">
        
        <label for="checkout_date">Enter Check-out Date: </label>
        <input type="date" name="checkout_date" id="checkout_date" 
               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
        
        <button type="submit" class="book-button">Book Room</button>
    </form>

	<div class="card-container">
    <div class="function-card" onclick="location.href='BookingController'">
        <!-- SVG icon for Booking Requests -->
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="#d4af37" viewBox="0 0 16 16">
            <path d="M9.854 5.146a.5.5 0 1 1 .708.708L7.707 8.707a1 1 0 0 1-1.414 0L5.354 7.768a.5.5 0 0 1 .708-.708l.94.939 2.854-2.853z"/>
            <path d="M14 4.5V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4.5a1 1 0 0 1 1-1h1V2.75A.75.75 0 0 1 4.75 2h6.5a.75.75 0 0 1 .75.75V3.5h1a1 1 0 0 1 1 1zM5 3.5V2.75a.25.25 0 0 1 .25-.25h6.5a.25.25 0 0 1 .25.25V3.5H5z"/>
        </svg>
        <h3>Manage Online Booking Requests</h3>
    </div>
    
    <div class="function-card" onclick="location.href='ReceptionistpayController'">
        <!-- SVG icon for Online Booking Payments -->
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="#d4af37" viewBox="0 0 16 16">
            <path d="M10 1.5v1h4.5v12H1.5v-12H6v-1H1.5A1.5 1.5 0 0 0 0 3v10A1.5 1.5 0 0 0 1.5 14.5h13A1.5 1.5 0 0 0 16 13V3a1.5 1.5 0 0 0-1.5-1.5H10z"/>
            <path d="M7 3a3 3 0 1 1 6 0 3 3 0 0 1-6 0zM6.5 8a.5.5 0 0 1 .5.5v.5h1V8a.5.5 0 0 1 1 0v1h1V8a.5.5 0 0 1 1 0v1h1V8a.5.5 0 0 1 1 0v1h1V8a.5.5 0 0 1 1 0v1h.5a.5.5 0 0 1 .5.5V10a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1v-.5a.5.5 0 0 1 .5-.5z"/>
        </svg>
        <h3>Manage Online Booking Payments</h3>
    </div>

    <div class="function-card" onclick="location.href='OfflineBookingController'">
        <!-- SVG icon for Offline Booking Payments -->
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="#d4af37" viewBox="0 0 16 16">
            <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h.5A1.5 1.5 0 0 1 15 2.5v11A1.5 1.5 0 0 1 13.5 15H2.5A1.5 1.5 0 0 1 1 13.5v-11A1.5 1.5 0 0 1 2.5 1H3v-.5a.5.5 0 0 1 .5-.5zm10 3a.5.5 0 0 1 .5.5v2.707l-1-.646V3.5a.5.5 0 0 1 .5-.5zm-.5 5.54v1.46H3v-1h7.707l-1 .646V8.5a.5.5 0 0 1 1 0v1.54zM1 2.5v11a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 .5-.5v-11a.5.5 0 0 0-.5-.5H13v1h1V13H2V3.5h1v-1h-.5a.5.5 0 0 0-.5.5zm4.5 0a.5.5 0 0 1 .5.5V6h3v-.5a.5.5 0 0 1 1 0v1h-5V3a.5.5 0 0 1 .5-.5zM4 8.5A.5.5 0 0 1 4.5 8h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 2A.5.5 0 0 1 4.5 10h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5z"/>
        </svg>
        <h3>Manage Offline Booking Payments</h3>
    </div>

    <div class="function-card" onclick="location.href='FeedbackController?action=reception'">
        <!-- SVG icon for Customer Feedback -->
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="#d4af37" viewBox="0 0 16 16">
            <path d="M8 3c-2.667 0-4 1.333-4 4s1.333 4 4 4 4-1.333 4-4-1.333-4-4-4z"/>
            <path d="M6 8.25a.75.75 0 0 1 .75-.75h2.5a.75.75 0 0 1 0 1.5h-2.5A.75.75 0 0 1 6 8.25zm3.25 1.75a.75.75 0 0 0 1.5 0 .75.75 0 0 0-1.5 0zm-5.5 0a.75.75 0 0 1 1.5 0 .75.75 0 0 1-1.5 0zM4.785 10.36c.268.485.635.889 1.08 1.203l-.854 1.707a.5.5 0 1 0 .895.448l.75-1.5a.5.5 0 0 1 .895 0l.75 1.5a.5.5 0 1 0 .895-.448l-.854-1.707a5.198 5.198 0 0 0 1.08-1.203c.265.158.537.282.825.369.285.086.583.135.886.136a5.023 5.023 0 0 0 4.5-4.5 5.023 5.023 0 0 0-4.5-4.5 5.023 5.023 0 0 0-4.5 4.5c0 .303.05.6.136.886.087.288.211.56.369.825z"/>
        </svg>
        <h3>View Customer Feedback</h3>
    </div>
</div>
</body>
</html>
