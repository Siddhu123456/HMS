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
		.assign-button-container {
			    text-align: center;
			    margin-top: 10px;
			}
			
			.assign-button {
			    background-color: #007bff;
			    color: white;
			    border: none;
			    padding: 8px 16px;
			    font-size: 1em;
			    cursor: pointer;
			    border-radius: 4px;
			}
			
			.assign-button:hover {
			    background-color: #0056b3;
			}
		.navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, #4a90e2, #0077b6);
            padding: 15px 30px;
            color: #fff;
            font-family: Arial, sans-serif;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .navbar .hotel-name {
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 1px;
            color: #f0f8ff;
            margin-right : 40%
        }

        .navbar .nav-links {
            display: flex;
            gap: 20px;
            margin-right: 20px;
        }

        .navbar .nav-links a {
            color: #f0f8ff;
            text-decoration: none;
            font-size: 18px;
            font-weight: 500;
            padding: 8px 12px;
            transition: all 0.3s ease;
            border-radius: 5px;
        }

        .navbar .nav-links a:hover {
            background-color: #0288d1;
            color: #ffffff;
        }

        .navbar .logout-button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .navbar .logout-button:hover {
            background-color: #ff3333;
        }
	</style>
</head>
<body>
	<%
		if(alertMessage) {
	%>
		<script type="text/javascript">
        	alert("The Foodorder was to succesfully assigned to the server");
        	window.location.href = "FoodManagerController?action=foodmanager";
    	</script>
    <%
		}
    %>
    
    <div class="navbar">
        <!-- Hotel name on the left -->
        <div class="hotel-name">Blissful Haven</div>
        
        <!-- Navigation links on the right -->
        <div class="nav-links">
            <a href="FoodManagerController?action=foodmanager&action1=orderhistory">View Order History</a>
            <a href="FoodManagerController">Edit Food Menu</a>
        </div>

        <!-- Logout button on the far right -->
        <form action="login.jsp" method="post" style="margin: 0;">
            <button type="submit" class="logout-button">Log Out</button>
        </form>
    </div>
    
    <h2>Pending Food Orders</h2>
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
            
            if (!order.isOrderStatus()) { 
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
                        <p style="color:seagreen"><strong>Delivery To  Room NO <%= order.getRoomId() %></strong></p>
                    </div>

                    <!-- Order Items Section -->
                    <div class="order-items">
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
                    <div class="assign-button-container">
				        <form action="FoodManagerController" method="post">
				            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
				            <button type="submit" class="assign-button">Assign order to Server</button>
				        </form>
				    </div>
                </div>
    <%
                }
            }
        } else {
    %>
        <p>You have no food orders.</p>
    <%
        }
    %>
    
</body>
</html>