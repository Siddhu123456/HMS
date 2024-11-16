<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.FoodOrder" %>
<%@ page import="com.model.OrderItems,com.model.Customer" %>
<%
	Integer orderStatus = (Integer) request.getAttribute("orderstatus");
	boolean alertMessage = orderStatus != null && orderStatus == 1;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Food Manager Home</title>
	<style type="text/css">
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

        /* Styling for each order card */
        .order-card {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 15px auto;
            max-width: 700px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* Flex container for main order details */
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 15px;
            margin-bottom: 10px;
        }

        .order-header h3 {
            font-size: 1.5em;
            color: #0077b6;
            margin: 0;
        }

        .order-status {
            font-size: 1em;
            padding: 5px 10px;
            border-radius: 4px;
            color: #fff;
        }

        .order-status.completed {
            background-color: #28a745;
        }

        .order-status.pending {
            background-color: #ffc107;
            color: #333;
        }

        /* Styling for order details section */
        .order-details {
            display: flex;
            justify-content: space-between;
            font-size: 0.95em;
        }

        .order-details p {
            margin: 0;
        }

        /* Styling for order items */
        .order-items {
        	display: none;
            border-top: 1px solid #e0e0e0;
            padding-top: 10px;
        }

        .order-items h4 {
            margin-bottom: 8px;
            font-size: 1.2em;
            color: #333;
        }

        .order-items ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .order-items li {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #ddd;
        }

        .order-items li:last-child {
            border-bottom: none;
        }
        
		.customer-details {
		    margin-bottom: 10px;
		    padding: 10px;
		    background-color: #f9f9f9;
		    border-bottom: 1px solid #ddd;
		    display: flex;
		    flex-direction: column;
		    align-items: center; /* Center the heading */
		}

		.customer-details h3 {
			    margin: 0;
			    font-size: 1.2em;
			    text-align: center;
			}
			
			.customer-details-info {
			    width: 100%;
			    display: flex;
			    justify-content: space-between; /* Email to left, Phone No. to right */
			    font-size: 0.9em;
			    color: #555;
			    margin-top: 5px; /* Spacing between h3 and p elements */
			}
			
			.customer-details-info p {
			    margin: 0;
			}
			.toggle-button {
	            background-color: #0077b6;
	            color: white;
	            padding: 8px 16px;
	            border-radius: 6px;
	            cursor: pointer;
	            border: none;
	            margin-top: 10px;
	            transition: background-color 0.3s;
	        }
	
	        .toggle-button:hover {
	            background-color: #005f8c;
	        }
	
	        .total-price {
	            font-size: 1.1em;
	            font-weight: 600;
	            color: #0077b6;
	        }
			@media (max-width: 768px) {
	           .order-card {
	                flex-direction: column;
	                align-items: center;
	                gap: 15px;
	            }
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
	<script type="text/javascript">
        // Function to toggle the visibility of order items
        function toggleOrderItems(orderId) {
            var itemsSection = document.getElementById("order-items-" + orderId);
            if (itemsSection.style.display === "none" || itemsSection.style.display === "") {
                itemsSection.style.display = "block";
            } else {
                itemsSection.style.display = "none";
            }
        }
    </script>
</head>
<body>
    
    <h2>Completed Food Orders History</h2>
    <%
    List<Customer> customerDetails = (List<Customer>) request.getAttribute("customerdetails");
    List<FoodOrder> foodOrders = (List<FoodOrder>) request.getAttribute("foodorders");

    if (foodOrders != null && !foodOrders.isEmpty() && customerDetails != null && !customerDetails.isEmpty()) {
        for (int i = 0; i < foodOrders.size(); i++) {
            FoodOrder order = foodOrders.get(i);
            Customer customer = customerDetails.get(i);
            
            java.sql.Timestamp orderDateTime = order.getOrderdate();
            
            java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm:ss");
            
            String formattedDate = dateFormat.format(orderDateTime);
            String formattedTime = timeFormat.format(orderDateTime);
            
            if (order.isOrderStatus()) { 
    %>
                <div class="order-card">
                	<!-- Customer Details Section -->
				    <div class="customer-details">
				        <h3><%= customer.getName() %></h3>
				        <div class="customer-details-info">
				        	<p><strong>Email:</strong> <%= customer.getEmail() %></p>
				        	<p><strong>Phone No:</strong> <%= customer.getPhoneNo() %></p>
				        </div>
				    </div>
                    <!-- Header with order ID and status -->
                    <div class="order-header">
                        <h3>Order ID: <%= order.getOrderId() %></h3>
                        <span class="order-status <%= order.isOrderStatus() ? "completed" : "pending" %>">
                            <%= order.isOrderStatus() ? "Completed" : "Pending" %>
                        </span>
                    </div>

                    <!-- Order Details in a horizontal layout -->
                    <div class="order-details">
                    	<p><strong>Order Date:</strong> <%= formattedDate %></p>
        				<p><strong>Order Time:</strong> <%= formattedTime %></p>
                        <p><strong>Total Price:</strong> ₹<%= String.format("%.2f", order.getOrderTotalPrice()) %></p>
                        <p style="color:seagreen"><strong>Delivered To  Room NO <%= order.getRoomId() %></strong></p>
                    </div>
					<button class="toggle-button" onclick="toggleOrderItems(<%= order.getOrderId() %>)">View Order Items</button>
                    <!-- Order Items Section -->
                    <div class="order-items" id="order-items-<%= order.getOrderId() %>">
                        <h4>Order Items:</h4>
                        <ul>
                            <%
                                List<OrderItems> orderItems = order.getOrderItems();
                                if (orderItems != null && !orderItems.isEmpty()) {
                                    for (OrderItems item : orderItems) {
                            %>
                                        <li>
                                            <span><%= item.getItem_name() %> (x<%= item.getQuantity() %>)</span>
                                            <span>₹<%= String.format("%.2f", item.getTotalItemsPrice()) %></span>
                                        </li>
                            <%
                                    }
                                } else {
                            %>
                                    <li>No items found for this order.</li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </div>
                
    <%
                }
            }
        } else {
    %>
        <p>You have no food orders History.</p>
    <%
        }
    %>
    <div style="text-align: center; margin-top: 20px;">
		<a href="FoodManagerController?action=foodmanager" class="go-home-button">Go to Home Page</a>
	</div>
</body>
</html>