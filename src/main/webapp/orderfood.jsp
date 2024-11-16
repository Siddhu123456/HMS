<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.model.FoodMenu" %>
<%@ page import="com.model.CartItem" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Menu - Blissful Haven</title>
    <!-- Font Awesome link for cart icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        /* Navbar styling */
        .navbar {
            background-color: #333;
            color: #f4f4f4;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .navbar .hotel-name {
            font-size: 1.5em;
            font-weight: bold;
            color: goldenrod;
        }
        .navbar .cart-icon {
            font-size: 1.5em;
            color: #f4f4f4;
            cursor: pointer;
            position: relative;
            display: flex;
            align-items: center;
        }
        .navbar .cart-icon i {
            font-size: 1.2em;
        }  
        
        header {
            text-align: center;
            margin-bottom: 20px;
            color: goldenrod;
            padding-top: 20px;
        }
        .menu-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .menu-item {
            background-color: #fff;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            width: 250px;
            text-align: center;
            transition: transform 0.2s;
        }
        .menu-item:hover {
            transform: translateY(-5px);
        }
        .menu-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }
        .type-0 { background-color: #ffecb3; } /* Naan and Rice */
        .type-1 { background-color: #c8e6c9; } /* Vegetarian */
        .type-2 { background-color: #ffccbc; } /* Non-Vegetarian */
        .type-3 { background-color: #bbdefb; } /* Snacks */
        .type-4 { background-color: #d1c4e9; } /* Drinks */
        .quantity-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 10px 0;
        }
        .quantity-button {
            background-color: white;
            color: grey;
            border: 1px solid grey;
            border-radius: 5px;
            cursor: pointer;
            padding: 5px 10px;
            font-size: 16px;
            transition: opacity 0.2s, filter 0.2s;
        }
        .quantity-button:disabled {
            background-color: #e0e0e0;
            color: #a0a0a0;
            cursor: not-allowed;
            opacity: 0.5;
            filter: blur(1px) brightness(0.7);
        }
        .quantity-display {
            margin: 0 10px;
            font-size: 18px;
            width: 30px;
            text-align: center;
        }
        .add-to-cart {
            padding: 10px 15px;
            background-color: grey;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            width: 100%;
        }
        .add-to-cart:hover {
            background-color: #555;
        }
        .cart-icon {
            font-size: 20px;
            color: white;
            margin-right: 5px;
        }
        footer {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        /* Filter styling */
        .filter-section {
            text-align: center;
            margin-bottom: 20px;
        }
        
        #cartSection {
		    display: none;
		    position: fixed;
		    right: 0;
		    top: 0;
		    width: 350px;
		    height: 100%;
		    background-color: #f9f9f9;
		    box-shadow: -5px 0 10px rgba(0, 0, 0, 0.2);
		    overflow-y: auto;
		    padding: 20px;
		    z-index: 1000;
		}
        
        .cart-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    border-bottom: 1px solid #ddd;
		    padding-bottom: 10px;
		    margin-bottom: 10px;
		}
        
        .cart-item {
            display: flex;
		    justify-content: space-between;
		    align-items: center;
		    background-color: #ffffff;
		    padding: 15px;
		    border-radius: 8px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		    margin-bottom: 10px;
        }
        
        .cart-item-details {
		    display: flex;
		    flex-direction: column;
		}
		
		.cart-item-name {
		    font-weight: bold;
		    font-size: 1em;
		    margin: 0;
		}
		
		.cart-item-quantity {
		    color: #666;
		    font-size: 0.9em;
		    margin: 5px 0 0;
		}
		
		.cart-item-price {
		    font-weight: bold;
		    color: #333;
		}
		
		.empty-cart-message {
		    text-align: center;
		    color: #666;
		    padding: 20px;
		}
		
		.order-now {
		    width: 100%;
		    background-color: goldenrod;
		    color: white;
		    padding: 12px;
		    font-size: 1em;
		    border: none;
		    border-radius: 8px;
		    cursor: pointer;
		    margin-top: 20px;
		    text-align: center;
		}
		
		.order-now:hover {
		    background-color: #d4a017;
		}
		
		.remove-item {
		    background-color: #ff4d4d;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    padding: 5px 10px;
		    cursor: pointer;
		}
		
		.remove-item:hover {
		    background-color: #e60000;
		}
		
    </style>
</head>
<body>

    <!-- Navbar -->
	<nav class="navbar">
	    <div class="hotel-name">Blissful Haven</div>
	    <div class="cart-icon" onclick="toggleCart()">
	        <span class="cart-icon"><i class="fas fa-cart-plus"></i></span>
	    </div>
	</nav>
    

    <header>
        <h1>Welcome to Blissful Haven</h1>
        <h2>Food Menu</h2>
        <h3><%= session.getAttribute("bookingId") %></h3>
        <h3><%= session.getAttribute("customer_id") %></h3>
        <h3><%= session.getAttribute("room_id") %></h3>
    </header>
    
	<!-- Cart Section -->
        <div id="cartSection">
        <div class="cart-header">
            <h2>Your Cart</h2>
            <span class="close-cart" onclick="toggleCart()">✖</span>
        </div>

        <div id="cartItems">
            <% 
                ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
                double totalCartPrice = 0;

                if (cart != null && !cart.isEmpty()) {
                    for (CartItem item : cart) {
                        double itemTotalPrice = item.getItemPrice() * item.getQuantity();
                        totalCartPrice += itemTotalPrice;
            %>
                <div class="cart-item">
                    <div class="cart-item-details">
                        <p class="cart-item-name"><%= item.getItemName() %></p>
                        <p class="cart-item-quantity">Quantity: <%= item.getQuantity() %></p>
                    </div>
                    <p class="cart-item-price">₹<%= itemTotalPrice %></p>
                    <form action="FoodController" method="post" style="display:inline;">
                    	<input type="hidden" name="bookingId" id="bookingIdInput" value=<%= session.getAttribute("bookingId") %>>
						<input type="hidden" name="customer_id" id="customerIdInput" value=<%= session.getAttribute("customer_id") %>>
						<input type="hidden" name="room_id" id="roomIdInput" value=<%= session.getAttribute("room_id") %>>
                        <input type="hidden" name="action" value="removeItem">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <button type="submit" class="remove-item">Remove</button>
                    </form>
                </div>
            <% 
                    }
                } else { 
            %>
                <p class="empty-cart-message">Your cart is empty.</p>
            <% 
                } 
            %>
        </div>

        <% if (cart != null && !cart.isEmpty()) { %>
            <div class="cart-total">
                <p><strong>Total Price:</strong> ₹<%= totalCartPrice %></p>
            </div>
            <button class="order-now" onclick="orderNow()">Order Now</button>
        <% } %>
    </div>
    
    
    
    <!-- Filter Section -->
    <section class="filter-section">
		    <form action="FoodController" method="GET">
		    	<input type="hidden" name="bookingId" id="bookingIdInput" value=<%= session.getAttribute("bookingId") %>>
		        <input type="hidden" name="customer_id" id="customerIdInput" value=<%= session.getAttribute("customer_id") %>>
		        <input type="hidden" name="room_id" id="roomIdInput" value=<%= session.getAttribute("room_id") %>>
		        <label for="itemTypeFilter">Filter by Item Type:</label>
		        <select name="itemType" id="itemTypeFilter" onchange="this.form.submit()">
		            <option value="" <%= (session.getAttribute("itemType") == null || "".equals(session.getAttribute("itemType"))) ? "selected" : "" %>>All</option>
		            <option value="0" <%= "0".equals(session.getAttribute("itemType")) ? "selected" : "" %>>Naan and Rice</option>
		            <option value="1" <%= "1".equals(session.getAttribute("itemType")) ? "selected" : "" %>>Vegetarian</option>
		            <option value="2" <%= "2".equals(session.getAttribute("itemType")) ? "selected" : "" %>>Non-Vegetarian</option>
		            <option value="3" <%= "3".equals(session.getAttribute("itemType")) ? "selected" : "" %>>Snacks</option>
		            <option value="4" <%= "4".equals(session.getAttribute("itemType")) ? "selected" : "" %>>Drinks</option>
		        </select>
		    </form>
		</section>

    <main>
        <div class="menu-container">
            <%
                ArrayList<FoodMenu> menuList = (ArrayList<FoodMenu>) request.getAttribute("menuList");
                if (menuList != null && !menuList.isEmpty()) {
                    for (FoodMenu item : menuList) {
                        String selectedType = (String)session.getAttribute("itemType");
                        if (selectedType == null || selectedType.isEmpty() || selectedType.equals(String.valueOf(item.getItemType()))) {
            %>
                            <div class="menu-item type-<%= item.getItemType() %>">
                                <img src="<%= item.getItemImage() %>" alt="<%= item.getItemName() %>" class="menu-image">
                                <h3><%= item.getItemName() %></h3>
                                <p><%= item.getDescriptionOfItem() %></p>
                                <p>Price: ₹<%= item.getItemPrice() %></p>
                                <p>Type: 
                                    <%= item.getItemType() == 0 ? "Naan and Rice" :
                                        item.getItemType() == 1 ? "Vegetarian" :
                                        item.getItemType() == 2 ? "Non-Vegetarian" :
                                        item.getItemType() == 3 ? "Snacks" :
                                        item.getItemType() == 4 ? "Drinks" : "Unknown" %>
                                </p>
                                <form action="FoodController" method="post" data-item-type="<%= item.getItemType() %>" onsubmit="setQuantityBeforeSubmit(this)">
                                	<input type="hidden" name="bookingId" id="bookingIdInput" value=<%= session.getAttribute("bookingId") %>>
							        <input type="hidden" name="customer_id" id="customerIdInput" value=<%= session.getAttribute("customer_id") %>>
							        <input type="hidden" name="room_id" id="roomIdInput" value=<%= session.getAttribute("room_id") %>>
                                	<input type="hidden" name="action" value="addItem">
								    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
								    <input type="hidden" name="itemName" value="<%= item.getItemName() %>">
								    <input type="hidden" name="itemPrice" value="<%= item.getItemPrice() %>">
								    <input type="hidden" name="itemtype" value="<%= item.getItemType() %>">
								    <div class="quantity-container">
								        <button type="button" class="quantity-button" onclick="decreaseQuantity(this)">-</button>
								        <span class="quantity-display">1</span>
								        <button type="button" class="quantity-button" onclick="increaseQuantity(this)">+</button>
								    </div>
								    <input type="hidden" name="quantity" class="quantity-input" value="1">
								    <button type="submit" class="add-to-cart">
								        <span class="cart-icon"><i class="fas fa-cart-plus"></i></span>Add to Cart
								    </button>
								</form>
                                
                                
                            </div>
            <%
                        }
                    }
                } else {
            %>
                    <p>No food items available at the moment.</p>
            <%
                }
            %>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 Blissful Haven. All rights reserved.</p>
    </footer>

    <script>
    
	    function orderNow() {
	        // Set session attributes for cart, totalCartPrice, and customer_id
	        <% 
	            session.setAttribute("cart", cart); 
	            session.setAttribute("totalCartPrice", totalCartPrice); 
	            
	        %>
	        
	        // Create a form dynamically for posting to OrderServlet
	        const form = document.createElement("form");
	        form.method = "post";
	        form.action = "FoodOrderController";
	        document.body.appendChild(form);
	        form.submit();
	    }

        
        function updateButtonState(button) {
            const quantityDisplay = button.parentNode.querySelector('.quantity-display');
            const currentQuantity = parseInt(quantityDisplay.textContent);
            const itemType = button.closest('form').querySelector('input[name="itemType"]').value;

            const increaseButton = button.parentNode.querySelector('.quantity-button:nth-of-type(2)');
            const decreaseButton = button.parentNode.querySelector('.quantity-button:nth-of-type(1)');
            
            const maxQuantity = (itemType == 0) ? 12 : 6;
            
            increaseButton.disabled = currentQuantity >= maxQuantity;
            decreaseButton.disabled = currentQuantity <= 1;

            updateButtonStyling(increaseButton);
            updateButtonStyling(decreaseButton);
        }

        function updateButtonStyling(button) {
            if (button.disabled) {
                button.classList.add('disabled');
                button.style.filter = "blur(10px) brightness(0.2)";
            } else {
                button.classList.remove('disabled');
                button.style.filter = "";
            }
        }

        function updateButtonState(button) {
            const quantityDisplay = button.parentNode.querySelector('.quantity-display');
            const currentQuantity = parseInt(quantityDisplay.textContent);

            const increaseButton = button.parentNode.querySelector('.quantity-button:nth-of-type(2)');
            const decreaseButton = button.parentNode.querySelector('.quantity-button:nth-of-type(1)');
            
            const maxQuantity = button.closest('form').dataset.itemType == "0" ? 12 : 6;
            
            increaseButton.disabled = currentQuantity >= maxQuantity;
            decreaseButton.disabled = currentQuantity <= 1;

            updateButtonStyling(increaseButton);
            updateButtonStyling(decreaseButton);
        }

        function increaseQuantity(button) {
            const quantityDisplay = button.previousElementSibling; // This gets the quantity display span
            let currentQuantity = parseInt(quantityDisplay.textContent);
            const maxQuantity = button.closest('form').dataset.itemType == "0" ? 12 : 6;

            if (currentQuantity < maxQuantity) {
                currentQuantity++; // Increase quantity
                quantityDisplay.textContent = currentQuantity; // Update the display
                button.parentNode.querySelector('.quantity-input').value = currentQuantity; // Update the hidden input
                updateButtonState(button); // Update button state
            }
        }

        function decreaseQuantity(button) {
            const quantityDisplay = button.nextElementSibling; // This gets the quantity display span
            let currentQuantity = parseInt(quantityDisplay.textContent);

            if (currentQuantity > 1) {
                currentQuantity--; // Decrease quantity
                quantityDisplay.textContent = currentQuantity; // Update the display
                button.parentNode.querySelector('.quantity-input').value = currentQuantity; // Update the hidden input
                updateButtonState(button); // Update button state
            }
        }

        
        function toggleCart() {
            const cartSection = document.getElementById("cartSection");
            cartSection.style.display = cartSection.style.display === "block" ? "none" : "block";
        }
		
        function setQuantityBeforeSubmit(form) {
            const quantityDisplay = form.querySelector('.quantity-display');
            const quantityInput = form.querySelector('.quantity-input');
            quantityInput.value = quantityDisplay.textContent.trim();
        }
		
        
    </script>
</body>
</html>
