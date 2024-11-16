package com.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Booking;

public class BookingDAO {
    private Connection connection;
    private Booking Booking;
    
    public BookingDAO(Connection connection) {
        this.connection = connection;
    }
    
    public boolean bookRoom(Booking bookingModel) {
        String query = "INSERT INTO BOOKING (cust_id, room_id, checkin_date, checkout_date) VALUES (?, ?, ?, ?)";
        try {

            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, bookingModel.getCustId());
            stmt.setInt(2, bookingModel.getRoomId());
            stmt.setDate(3, bookingModel.getCheckinDate());
            stmt.setDate(4, bookingModel.getCheckoutDate());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            // Print specific SQL error message
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public ArrayList<Booking> fetchBooking(){
    	
    	ArrayList<Booking> bookingList = new ArrayList<>();
    	String query = "SELECT booking_id,cust_id, room_id, checkin_date, checkout_date, booking_status FROM BOOKING ORDER BY booking_id DESC;";
    	
    	try {
			PreparedStatement stmt = connection.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				int bookingId = rs.getInt("booking_id");
				int custId = rs.getInt("cust_id");
				int roomId = rs.getInt("room_id");
				Date checkinDate = rs.getDate("checkin_date");
				Date checkoutDate = rs.getDate("checkout_date");
				int bookingStatus = rs.getInt("booking_status");
				
				
				bookingList.add(new Booking(bookingId, custId, roomId, checkinDate, checkoutDate, bookingStatus));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bookingList;
    	
    }
    
    public boolean updateBookingStatus(int bookingId, int bookingStatus) {
		
    	String query = "UPDATE BOOKING SET booking_status = ? WHERE booking_id = ?;";
    	
    	
    	try {
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setInt(1, bookingStatus);
			stmt.setInt(2, bookingId);
			
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return false;
    	
    }
    
    public ArrayList<Booking> getBookingsByCustomerId(int custId) {
        ArrayList<Booking> bookingList = new ArrayList<>();
        String query = "SELECT booking_id, cust_id, room_id, checkin_date, checkout_date, booking_status FROM BOOKING WHERE cust_id = ? ORDER BY checkin_date DESC";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, custId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                int bookingId = rs.getInt("booking_id");
                int roomId = rs.getInt("room_id");
                Date checkinDate = rs.getDate("checkin_date");
                Date checkoutDate = rs.getDate("checkout_date");
                int bookingStatus = rs.getInt("booking_status");
                
                System.out.println(roomId);

                bookingList.add(new Booking(bookingId, custId, roomId, checkinDate, checkoutDate, bookingStatus));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookingList;
    }
    
    public boolean updateBookingStatusBill(int bookingId) {
    	
    	String query = "UPDATE BOOKING SET booking_status=? WHERE booking_id=?";
    	
    	try {
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setInt(1, 3);
			stmt.setInt(2,bookingId);
			
			int result = stmt.executeUpdate();
			if (result>0)
				return true;
			else 
				return false;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return false;
    }
    
    public List<Booking> fetchfbPendingBookings(int customerId) {
    	
    	List<Booking> fbPendingBookings = new ArrayList<>();
    	String query = "SELECT * FROM BOOKING WHERE booking_id NOT IN (SELECT booking_id FROM FEEDBACK) AND booking_status = 3 AND cust_id = ?";
    	
    	try {
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setInt(1, customerId);
			
			ResultSet rs = stmt.executeQuery();
			
			Booking booking = null;
			while(rs.next()) {
				booking= new Booking(
						rs.getInt("cust_id"),
						rs.getInt("room_id"),
						rs.getDate("checkin_date"),
						rs.getDate("checkout_date")
						);
				booking.setBookingId(rs.getInt("booking_id"));
				fbPendingBookings.add(booking);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return fbPendingBookings;
    }
}
