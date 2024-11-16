<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.FoodOrder" %>
<%@ page import="com.model.OrderItems" %>
<html>
<head>
    <title>Food Orders</title>
    <style>
        /* General styling for the page */
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
        .centered-button-container {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            text-align: center;
        }
        .home-button {
	            padding: 10px 20px;
	            font-size: 16px;
	            background-color: #4CAF50;
	            color: white;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            text-decoration: none;
        }
        .home-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Your Food Orders</h2>
    <%
        // Retrieve the food orders from the request attribute
        List<FoodOrder> foodOrders = (List<FoodOrder>) request.getAttribute("foodOrders");
        
        if (foodOrders != null && !foodOrders.isEmpty()) {
            for (FoodOrder order : foodOrders) {
    %>
                <div class="order-card">
                    <!-- Header with order ID and status -->
                    <div class="order-header">
                        <h3>Order ID: <%= order.getOrderId() %></h3>
                        <span class="order-status <%= order.isOrderStatus() ? "completed" : "pending" %>">
                            <%= order.isOrderStatus() ? "Completed" : "Pending" %>
                        </span>
                    </div>

                    <!-- Order Details in a horizontal layout -->
                    <div class="order-details">
                        <p><strong>Order Date:</strong> <%= order.getOrderDate() %></p>
                        <p><strong>Total Price:</strong> $<%= String.format("%.2f", order.getOrderTotalPrice()) %></p>
                        <p><strong>Room ID:</strong> <%= order.getRoomId() %></p>
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
                                            <span>$<%= String.format("%.2f", item.getTotalItemsPrice()) %></span>
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
        } else {
    %>
        <p>You have no food orders.</p>
    <%
        }
    %>
    <div class="centered-button-container">
        <a href="BookingController?action=login" class="home-button">Go to Home</a>
    </div>
</body>
</html>
