package com.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.model.FoodOrder;
import com.model.OrderItems;

public class FoodOrderDAO {
		private Connection connection;
		
		public FoodOrderDAO(Connection connection) {
			this.connection = connection;
		}
		
		public boolean placeFoodOrder(FoodOrder foodorder) throws SQLException {
		    
		    String foodorderQuery = "INSERT INTO FOODORDER (cust_id, booking_id, order_total_price,room_id) VALUES (?, ?, ?, ?)";
		    String orderitemsQuery = "INSERT INTO ORDERITEMS (order_id, item_id, item_name, quantity, totalitems_price) VALUES (?, ?, ?, ?, ?)";
		    
		    PreparedStatement stmt1 = null;
		    ResultSet generatedkeys = null;

		    try {
		        stmt1 = connection.prepareStatement(foodorderQuery, Statement.RETURN_GENERATED_KEYS);
		        stmt1.setInt(1, foodorder.getCustId());
		        stmt1.setInt(2, foodorder.getBookingId());
		        stmt1.setDouble(3, foodorder.getOrderTotalPrice());
		        stmt1.setInt(4, foodorder.getRoomId());
		        
		        int result = stmt1.executeUpdate();
		        System.out.println("Order Insert Result: " + result);
		        
		        if (result > 0) {
		            generatedkeys = stmt1.getGeneratedKeys();
		            if (generatedkeys.next()) {
		                int orderId = generatedkeys.getInt(1);
		                
		                List<OrderItems> items = foodorder.getOrderItems();
		                
		                for (OrderItems item : items) {
		                    try (PreparedStatement stmt2 = connection.prepareStatement(orderitemsQuery)) {
		                        stmt2.setInt(1, orderId);
		                        stmt2.setInt(2, item.getItem_id());
		                        stmt2.setString(3, item.getItem_name());
		                        stmt2.setInt(4, item.getQuantity());
		                        stmt2.setDouble(5, item.getTotalItemsPrice());
		                        int isInserted = stmt2.executeUpdate();
		                        System.out.println("Order Item Insert Result: " + isInserted);
		                        
		                        if (isInserted == 0) {
		                            return false;
		                        }
		                    }
		                }
		            } else {
		                return false;
		            }
		        } else {
		            return false;
		        }
		    } finally {
		        if (generatedkeys != null) generatedkeys.close();
		        if (stmt1 != null) stmt1.close();
		    }
		    return true;
		}
		
		public List<FoodOrder> getFoodOrdersByCustomerId(int customerId) {
	        List<FoodOrder> foodOrders = new ArrayList<>();
	        
	        // Query to retrieve food orders for a particular customer
	        String orderQuery = "SELECT * FROM FOODORDER WHERE cust_id = ? ORDER BY order_id DESC";
	        String itemsQuery = "SELECT * FROM ORDERITEMS WHERE order_id = ?";

	        try (PreparedStatement orderStmt = connection.prepareStatement(orderQuery);
	             PreparedStatement itemsStmt = connection.prepareStatement(itemsQuery)) {

	            orderStmt.setInt(1, customerId);
	            ResultSet orderRs = orderStmt.executeQuery();

	            while (orderRs.next()) {
	                int orderId = orderRs.getInt("order_id");
	                int bookingId = orderRs.getInt("booking_id");
	                Date orderDate = orderRs.getDate("order_date");
	                double orderTotalPrice = orderRs.getDouble("order_total_price");
	                boolean orderStatus = orderRs.getBoolean("orderstatus");
	                int roomId = orderRs.getInt("room_id");

	                FoodOrder foodOrder = new FoodOrder(orderId, customerId, bookingId, orderDate, orderTotalPrice, orderStatus, roomId);

	                itemsStmt.setInt(1, orderId);
	                ResultSet itemsRs = itemsStmt.executeQuery();
	                List<OrderItems> orderItemsList = new ArrayList<>();

	                while (itemsRs.next()) {
	                    int itemId = itemsRs.getInt("item_id");
	                    String itemName = itemsRs.getString("item_name");
	                    int quantity = itemsRs.getInt("quantity");
	                    double totalItemsPrice = itemsRs.getDouble("totalitems_price");

	                    orderItemsList.add(new OrderItems(itemId, itemName, quantity, totalItemsPrice));
	                }
	                
	                foodOrder.setOrderItems(orderItemsList);

	                foodOrders.add(foodOrder);

	                itemsRs.close();
	            }

	            orderRs.close();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return foodOrders;
	    }
		
		public List<FoodOrder> fetchFoodOrders() {
	        List<FoodOrder> foodOrders = new ArrayList<>();
	        
	        // Query to retrieve food orders for a particular customer
	        String orderQuery = "SELECT * FROM FOODORDER ORDER BY order_id DESC";
	        String itemsQuery = "SELECT * FROM ORDERITEMS WHERE order_id = ?";

	        try (PreparedStatement orderStmt = connection.prepareStatement(orderQuery);
	             PreparedStatement itemsStmt = connection.prepareStatement(itemsQuery)) {

	            ResultSet orderRs = orderStmt.executeQuery();

	            while (orderRs.next()) {
	                
	            	int customerId = orderRs.getInt("cust_id");                
	            	int orderId = orderRs.getInt("order_id");
	                int bookingId = orderRs.getInt("booking_id");
	                Timestamp orderDate = orderRs.getTimestamp("order_date");
	                double orderTotalPrice = orderRs.getDouble("order_total_price");
	                boolean orderStatus = orderRs.getBoolean("orderstatus");
	                int roomId = orderRs.getInt("room_id");

	                FoodOrder foodOrder = new FoodOrder(orderId, customerId, bookingId, orderDate, orderTotalPrice, orderStatus, roomId);

	                itemsStmt.setInt(1, orderId);
	                ResultSet itemsRs = itemsStmt.executeQuery();
	                List<OrderItems> orderItemsList = new ArrayList<>();

	                while (itemsRs.next()) {
	                    int itemId = itemsRs.getInt("item_id");
	                    String itemName = itemsRs.getString("item_name");
	                    int quantity = itemsRs.getInt("quantity");
	                    double totalItemsPrice = itemsRs.getDouble("totalitems_price");

	                    orderItemsList.add(new OrderItems(itemId, itemName, quantity, totalItemsPrice));
	                }
	                
	                foodOrder.setOrderItems(orderItemsList);

	                foodOrders.add(foodOrder);

	                itemsRs.close(); 
	            }

	            orderRs.close(); 

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return foodOrders;
	    }
		
		public boolean updateOrderStatus(int orderId) {
			
			String query = "UPDATE FOODORDER SET orderstatus=1 WHERE order_id = ?";
			
			try {
				PreparedStatement stmt = connection.prepareStatement(query);
				stmt.setInt(1, orderId);
				int isUpdated = stmt.executeUpdate();
				
				if(isUpdated>0) {
					return true;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
		}
}
