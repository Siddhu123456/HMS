<%@ page import="java.util.List" %>
<%@ page import="com.model.FoodMenu" %>
<%@ page import="java.math.BigDecimal" %>
<%  
	boolean isAdded = false;
	boolean isUpdated = false;
	if("success".equals(request.getAttribute("updateStatus"))){
		isUpdated = true;
	}
	if("yes".equals(request.getAttribute("addedfooditem"))){
		isAdded = true;
	}
%>
<html>
<head>
    <title>Edit Food Menu</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #0077b6;
            margin-bottom: 30px;
        }

        .food-card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
        }

        .food-card {
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 280px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            position: relative; /* Position relative for absolute positioning of edit form */
        }

        .food-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .food-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }

        .food-card h3 {
            font-size: 1.2em;
            color: #0077b6;
            margin-top: 15px;
        }

        .food-card p {
            font-size: 0.9em;
            color: #555;
            margin: 8px 0;
        }

        .food-card .price {
            font-weight: bold;
            color: #0077b6;
        }

        .food-card .status {
            margin: 10px 0;
            font-weight: bold;
        }

        .food-card input[type="number"],
        .food-card select {
            width: 90%;
            margin-bottom: 10px;
            padding: 8px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 6px;
            margin-top: 8px;
        }

        .food-card button {
            background-color: #0077b6;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
        }

        .food-card button:hover {
            background-color: #005f8c;
        }

        /* Initially hide the edit form */
        .edit-fields {
            display: none;
            position: absolute;
            top: 10px; /* Position it at the top of the card */
            left: 0;
            right: 0;
            background-color: rgba(255, 255, 255, 0.9); /* Slight transparency to blend with the card */
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1; /* Ensure it's above the card content */
        }

        /* When card is in edit mode, show the edit form */
        .food-card.edit-mode .edit-fields {
            display: block;
        }

        /* Change the color of the Edit Item button when the card is in edit mode */
        .food-card.edit-mode .edit-item {
            background-color: #005f8c; /* Blue when in edit mode */
            color: white;
        }

        /* Hide Save Changes button by default */
        .edit-fields button.save-item {
            background-color: #28a745;
            margin-top: 10px;
            display: none; /* Hidden initially */
            margin-left: 27%;
        }

        /* When in edit mode, show Save Changes button */
        .food-card.edit-mode .save-item {
            display: block;
        }
		/* Card Styling */
		.add-item-card {
		    background-color: #ffffff;
		    border: 1px solid #ddd;
		    border-radius: 12px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    padding: 20px;
		    max-width: 800px; /* Adjust width to fit three columns comfortably */
		    margin: 0 auto;
		}
		
		.add-item-card h3 {
		    color: #0077b6;
		    text-align: center;
		    margin-bottom: 20px;
		    font-size: 1.5em;
		}
		
		/* Form Styling */
		.add-item-card form {
		    display: flex;
		    flex-direction: column;
		    gap: 15px;
		}
		
		/* Row styling for three-column layout */
		.form-row {
		    display: flex;
		    gap: 20px; /* Space between columns */
		}
		
		/* Individual form group styling */
		.form-group {
		    flex: 1; /* Each input takes up one-third of the row */
		    display: flex;
		    flex-direction: column;
		}
		
		.form-group label {
		    font-weight: bold;
		    color: #555;
		    margin-bottom: 5px;
		}
		
		.form-group input[type="text"],
		.form-group input[type="number"],
		.form-group select,
		.form-group textarea {
		    padding: 8px;
		    border: 1px solid #ddd;
		    border-radius: 6px;
		    font-size: 1em;
		}
		
		/* Submit button styling */
		.form-submit {
		    text-align: center;
		    margin-top: 15px;
		}
		
		.form-submit button {
		    background-color: #0077b6;
		    color: white;
		    padding: 10px 20px;
		    border-radius: 6px;
		    cursor: pointer;
		    border: none;
		    font-size: 1em;
		    transition: background-color 0.3s ease;
		}
		
		.form-submit button:hover {
		    background-color: #005f8c;
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
    <script>
        // Function to toggle visibility of the edit form and button color
        function editItem(itemId) {
            const card = document.getElementById('card_' + itemId);
            const editButton = card.querySelector('.edit-item');
            const saveButton = card.querySelector('.save-item');
            
            // Toggle the edit mode
            card.classList.toggle('edit-mode');
            
            // When the form is in edit mode
            if (card.classList.contains('edit-mode')) {
                // Change button color to indicate it's in edit mode
                editButton.style.backgroundColor = '#005f8c'; // Blue color
                saveButton.style.display = 'block'; // Show the Save Changes button
            } else {
                // Reset button color when not in edit mode
                editButton.style.backgroundColor = '#0077b6'; // Default color
                saveButton.style.display = 'none'; // Hide the Save Changes button
            }
        }
        
        function filterItemsByType() {
            const filterValue = document.getElementById('itemTypeFilter').value;
            const foodCards = document.querySelectorAll('.food-card');
            
            foodCards.forEach(card => {
                const itemType = card.getAttribute('data-item-type');
                
                // Show all items if "All" is selected or the item's type matches the selected filter
                if (filterValue === 'all' || itemType === filterValue) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</head>
<body>
	<%
		if(isUpdated) {
	%>
		<script type="text/javascript">
	        	alert("The FoodItems details were successfully updated.");
	        	window.location.href = "FoodManagerController";
	    	</script>
	<% 	
		}
	%>	
	<%
		if(isAdded) {
	%>
		<script type="text/javascript">
			alert("The FoodItem was Added to the Menu Successfully.");
			window.location.href= "FoodManagerController";
		</script>
	<%
		}
	%>
	<!-- Insert New Food Item Form Card -->
    <div class="add-item-card">
	    <h3>Add New Food Item</h3>
	    <form action="FoodManagerController" method="post">
	        <input type="hidden" name="action" value="addfooditem">
	
	        <div class="form-row">
	            <div class="form-group">
	                <label for="itemName">Item Name:</label>
	                <input type="text" id="itemName" name="itemName" placeholder="Enter item name" required>
	            </div>
	            <div class="form-group">
	                <label for="itemPrice">Price:</label>
	                <input type="number" id="itemPrice" name="itemPrice" placeholder="Enter price" step="0.01" required>
	            </div>
	            <div class="form-group">
	                <label for="itemType">Type:</label>
	                <select id="itemType" name="itemType" required>
	                    <option value="0">Naan and Rice</option>
	                    <option value="1">Vegetarian</option>
	                    <option value="2">Non-Vegetarian</option>
	                    <option value="3">Snacks</option>
	                    <option value="4">Drinks</option>
	                </select>
	            </div>
	        </div>
	
	        <div class="form-row">
	            <div class="form-group">
	                <label for="descriptionOfItem">Description:</label>
	                <textarea id="descriptionOfItem" name="descriptionOfItem" placeholder="Enter description" rows="2"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="itemImage">Image URL:</label>
	                <input type="text" id="itemImage" name="itemImage" placeholder="Enter image URL">
	            </div>
	            <div class="form-group">
	                <label for="availabilityStatus">Status:</label>
	                <select id="availabilityStatus" name="availabilityStatus" required>
	                    <option value="1">Available</option>
	                    <option value="0">Unavailable</option>
	                </select>
	            </div>
	        </div>
	
	        <div class="form-submit">
	            <button type="submit">Submit</button>
	        </div>
	    </form>
	</div>
    
		<h2>Update Food Menu</h2>
		
		<!-- Item Type Filter Dropdown -->
		<div class="filter-container">
		    <label for="itemTypeFilter">Filter by Item Type:</label>
		    <select id="itemTypeFilter" onchange="filterItemsByType()">
		        <option value="all">All</option>
		        <option value="0">Naan and Rice</option>
		        <option value="1">Vegetarian</option>
		        <option value="2">Non-Vegetarian</option>
		        <option value="3">Snacks</option>
		        <option value="4">Drinks</option>
		    </select>
		</div>
		
		<div class="food-card-container">
		    <% List<FoodMenu> foodItems = (List<FoodMenu>) request.getAttribute("foodmenu");
		       for (FoodMenu item : foodItems) { %>
		    <div class="food-card" id="card_<%= item.getItemId() %>"  data-item-type="<%= item.getItemType() %>">
		        <!-- Image of the Food Item -->
		        <img src="<%= item.getItemImage() %>" alt="<%= item.getItemName() %>">
		
		        <!-- Food Item Details -->
		        <h3><%= item.getItemName() %></h3>
		        <p><strong>Description:</strong> <%= item.getDescriptionOfItem() %></p>
		        <p><strong>Type:</strong> <%= item.getItemType() == 0 ? "Naan and Rice" : item.getItemType() == 1 ? "Vegetarian" : item.getItemType() == 2 ? "Non-Vegetarian" : item.getItemType() == 3 ? "Snacks" : "Drinks" %></p>
		
		        <!-- Editable Fields for Price and Availability Status (in a form) -->
		        <div class="edit-fields">
		            <form action="FoodManagerController" method="post">
		                <p><strong>Price:</strong>
		                    <input type="number" name="price" value="<%= item.getItemPrice() %>" />
		                </p>
		                <input type="hidden" name="itemId" value="<%= item.getItemId()%>">
						<input type="hidden" name="action" value="updatefooditem">
		                <p><strong>Status:</strong>
		                    <select name="status">
		                        <option value="1" <%= item.isAvailabilityStatus() ? "selected" : "" %>>Available</option>
		                        <option value="0" <%= !item.isAvailabilityStatus() ? "selected" : "" %>>Unavailable</option>
		                    </select>
		                </p>
		                <button class="save-item" type="submit">Update changes</button>
		            </form>
		        </div>
		
		        <!-- Default View (Readonly Mode) -->
		        <div class="default-view">
		            <p><strong>Price:</strong> <%= item.getItemPrice() %></p>
		            <p><strong>Status:</strong> <%= item.isAvailabilityStatus() ? "Available" : "Unavailable" %></p>
		        </div>
		
		        <!-- Edit Button -->
		        <button class="edit-item" onclick="editItem(<%= item.getItemId() %>)">Edit Item</button>
		    </div>
		    <% } %>
		</div>
		<div style="text-align: center; margin-top: 20px;">
			 <a href="FoodManagerController?action=foodmanager" class="go-home-button">Go to Home Page</a>
	    </div> 
	</body>
</html>
