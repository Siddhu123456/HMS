package com.DAO;

import com.model.Booking;
import com.model.Customer;
import com.model.FoodOrder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReceptionistPayDAO {
    private Connection connection;

    public ReceptionistPayDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to retrieve all Bookings with related Customer and FoodOrders, ordered by booking_id descending
    public List<Booking> getAllBookingsWithDetails() throws SQLException {
         String query = "SELECT b.booking_id, b.cust_id, b.room_id, b.checkin_date, b.checkout_date, b.booking_status, " +
		                "c.customer_id, c.name, c.email, c.phone_no, " +
		                "f.order_id, f.order_date, f.order_total_price, f.orderstatus, f.room_id AS food_room_id, " +
		                "r.room_price AS pricepernight " + 
		                "FROM BOOKING b " +
		                "JOIN CUSTOMER c ON b.cust_id = c.customer_id " +
		                "LEFT JOIN FOODORDER f ON b.booking_id = f.booking_id " +
		                "JOIN ROOMS r ON b.room_id = r.room_id " +
		                "WHERE b.booking_mode = 0 "+
		                "ORDER BY b.booking_id DESC"; 

        List<Booking> bookings = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            int currentBookingId = -1;
            Booking booking = null;
            List<FoodOrder> foodOrders = null;

            while (rs.next()) {
                int bookingId = rs.getInt("booking_id");

                // When a new booking_id is encountered, finalize the previous booking and start a new one
                if (bookingId != currentBookingId) {
                    // If there's an existing booking, add it to the bookings list
                    if (booking != null) {
                        booking.setFoodorder(foodOrders); // Set food orders for the previous booking
                        bookings.add(booking);
                    }

                    // Initialize a new booking
                    booking = new Booking(
                            bookingId,
                            rs.getInt("cust_id"),
                            rs.getInt("room_id"),
                            rs.getDate("checkin_date"),
                            rs.getDate("checkout_date"),
                            rs.getInt("booking_status"),
                            rs.getDouble("pricepernight")
                        );

                    // Create and set customer details for the new booking
                    Customer customer = new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        null, // Excluding password for security reasons
                        rs.getString("phone_no")
                    );
                    booking.setCustomer(customer);

                    // Initialize a new list for food orders associated with this booking
                    foodOrders = new ArrayList<>();
                    currentBookingId = bookingId; // Update the current booking ID tracker
                }

                // Add each food order associated with the current booking
                int orderId = rs.getInt("order_id");
                if (orderId != 0) { // Only add if there's a food order
                    FoodOrder foodOrder = new FoodOrder(
                        orderId,
                        rs.getInt("cust_id"),
                        bookingId,
                        rs.getDate("order_date"),
                        rs.getDouble("order_total_price"),
                        rs.getInt("orderstatus") == 1,
                        rs.getInt("food_room_id")
                    );
                    foodOrders.add(foodOrder);
                }
            }

            // Add the last booking to the list if it exists
            if (booking != null) {
                booking.setFoodorder(foodOrders); // Set remaining food orders
                bookings.add(booking);
            }
        }
        return bookings;
    }
}
