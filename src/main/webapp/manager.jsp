<%@ page import="java.util.List" %>
<%@ page import="com.model.Rooms" %>
<%@ page import="java.math.BigDecimal" %>
<%
	boolean isRoomUpdated = false;
	boolean isRoomAdded = false;
	if ("roomUpdateSuccess".equals(request.getAttribute("updateStatus"))) {
		isRoomUpdated = true;
	}
	if ("yes".equals(request.getAttribute("addedRoom"))) {
		isRoomAdded = true;
	}
%>
<html>
<head>
    <title>Manage Rooms</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #0077b6;
            margin-bottom: 30px;
        }
        .room-card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
        }
        .room-card {
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 280px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            position: relative;
        }
        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .room-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .room-card h3 {
            font-size: 1.2em;
            color: #0077b6;
            margin-top: 15px;
        }
        .room-card p {
            font-size: 0.9em;
            color: #555;
            margin: 8px 0;
        }
        .room-card .price {
            font-weight: bold;
            color: #0077b6;
        }
        .room-card .status {
            margin: 10px 0;
            font-weight: bold;
        }
        .edit-fields {
            display: none;
            position: absolute;
            top: 10px;
            left: 0;
            right: 0;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }
        .room-card.edit-mode .edit-fields {
            display: block;
        }
        .room-card.edit-mode .edit-item {
            background-color: #005f8c;
            color: white;
        }
        .save-item {
            background-color: #28a745;
            margin-top: 10px;
            display: none;
        }
        .room-card.edit-mode .save-item {
            display: block;
        }
        .edit-item {
            background-color: #0077b6;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
        }
        .filter-container {
	        text-align: center;
	        margin-bottom: 20px;
	    }
	
	    .filter-container label {
	        font-weight: bold;
	        color: #0077b6;
	    }
	
	    .filter-container select {
	        padding: 5px;
	        border: 1px solid #ddd;
	        border-radius: 6px;
	        font-size: 1em;
	        color: #555;
	    }
	    .edit-fields button.save-item {
            background-color: #28a745;
            margin-top: 10px;
            display: none; /* Hidden initially */
            margin-left: 30%;
        }
        /* Navbar styling */
		.navbar {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    background-color: #0077b6;
		    padding: 10px 20px;
		    color: white;
		}
		
		.navbar a {
		    color: white;
		    text-decoration: none;
		    margin-left: 15px;
		    font-weight: bold;
		}
		
		.navbar .right-links {
		    display: flex;
		    gap: 10px;
		}
		
		.navbar .hotel-name {
		    font-size: 1.2em;
		    font-weight: bold;
		}
		        
    </style>
    <script>
        function editRoom(roomId) {
            const card = document.getElementById('card_' + roomId);
            card.classList.toggle('edit-mode');
        }
        function filterRooms() {
            const roomTypeFilter = document.getElementById("roomTypeFilter").value;
            const availabilityFilter = document.getElementById("availabilityFilter").value;
            const roomCards = document.querySelectorAll(".room-card");

            roomCards.forEach(card => {
                const roomType = card.getAttribute("data-room-type");
                const availability = card.getAttribute("data-availability");

                const matchesRoomType = (roomTypeFilter === "all" || roomType === roomTypeFilter);
                const matchesAvailability = (availabilityFilter === "all" || availability === availabilityFilter);

                // Display the card only if it matches both filters
                card.style.display = (matchesRoomType && matchesAvailability) ? "block" : "none";
            });
        }
    </script>
</head>
<body>
    <%
        if (isRoomUpdated) {
    %>
        <script type="text/javascript">
            alert("The room details were successfully updated.");
            window.location.href = "RoomsController?action=manager";
        </script>
    <% 
        }
        if (isRoomAdded) {
    %>
        <script type="text/javascript">
            alert("The room was added successfully.");
            window.location.href = "RoomsController";
        </script>
    <%
        }
    %>
    <!-- Navigation Bar -->
	<div class="navbar">
	    <span class="hotel-name">Blissful Haven</span>
	    <div class="right-links">
	        <a href="ManagerController">View Payment History</a>
	        <a href="login.jsp" class="logout-button">LogOut</a>
	    </div>
	</div>
    
    <h1>Manage Rooms</h1>
    <!-- Filters for Room Type and Availability -->
    <div class="filter-container">
        <label for="roomTypeFilter">Filter by Room Type:</label>
        <select id="roomTypeFilter" onchange="filterRooms()">
            <option value="all">All Types</option>
            <option value="AC-SINGLE">Single</option>
            <option value="AC-DOUBLE">Double</option>
            <option value="NON AC-SINGLE">Suite</option>
            <option value="NON AC-DOUBLE">Suite</option>
        </select>

        <label for="availabilityFilter">Availability:</label>
        <select id="availabilityFilter" onchange="filterRooms()">
            <option value="all">All</option>
            <option value="true">Available</option>
            <option value="false">Unavailable</option>
        </select>
    </div>
    
    <div class="room-card-container">
        <% List<Rooms> roomList = (List<Rooms>) request.getAttribute("allrooms");
           for (Rooms room : roomList) { %>
        <div class="room-card" id="card_<%= room.getRoomId() %>" data-room-type="<%= room.getRoomType() %>" data-availability="<%= room.isAvailabilityStatus() %>">
            <img src="<%= room.getRoomImage() %>" alt="<%= room.getRoomType() %>">
            <h3><%= room.getRoomType() %></h3>
            <p><strong>Description:</strong> <%= room.getRoomDescription() %></p>
            <p class="price"><strong>Price:</strong> <%= room.getRoomPrice() %></p>
            <p class="status"><strong>Status:</strong> <%= room.isAvailabilityStatus() ? "Available" : "Unavailable" %></p>
            <div class="edit-fields">
                <form action="RoomsController" method="post">
                    <input type="hidden" name="action" value="updateroom">
                    <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">
                    <p><strong>Price:</strong>
                        <input type="number" name="roomPrice" value="<%= room.getRoomPrice() %>" step="0.01" required>
                    </p>
                    <p><strong>Status:</strong>
                        <select name="availabilityStatus" required>
                            <option value="1" <%= room.isAvailabilityStatus() ? "selected" : "" %>>Available</option>
                            <option value="0" <%= !room.isAvailabilityStatus() ? "selected" : "" %>>Unavailable</option>
                        </select>
                    </p>
                    <button class="save-item" type="submit">Save Changes</button>
                </form>
            </div>
            <button class="edit-item" onclick="editRoom(<%= room.getRoomId() %>)">Edit Room</button>
        </div>
        <% } %>
    </div>
</body>
</html>
