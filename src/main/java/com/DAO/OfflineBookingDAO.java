package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.model.Booking;
import com.model.Customer;

public class OfflineBookingDAO {
	private Connection connection;
	
	public OfflineBookingDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean offlineBooking(Booking booking) throws SQLException {
		
		String bookingQuery = "INSERT INTO BOOKING (cust_id, room_id, checkin_date, checkout_date,booking_status,booking_mode) VALUES (?, ?, ?, ?, ?, ?)";
		String offcustomerQuery = "INSERT INTO OFFLINECUSTOMER (booking_id,name,email,phone_no) VALUES (?,?,?,?)";
		
		PreparedStatement stmt1 = null;
		ResultSet generatedkeys = null;
		try {
			stmt1 = connection.prepareStatement(bookingQuery,Statement.RETURN_GENERATED_KEYS);
			stmt1.setInt(1,booking.getCustId());
			stmt1.setInt(2,booking.getRoomId());
			stmt1.setDate(3,booking.getCheckinDate());
			stmt1.setDate(4, booking.getCheckoutDate());
			stmt1.setInt(5, 1);
			stmt1.setBoolean(6,true);
			
			int result = stmt1.executeUpdate();
			
			if (result>0) {
				generatedkeys = stmt1.getGeneratedKeys();
				if (generatedkeys.next()) {
					int booking_id = generatedkeys.getInt(1);
					
					
					Customer customer = booking.getCustomer();
					
					try(PreparedStatement stmt2 = connection.prepareStatement(offcustomerQuery)){
						stmt2.setInt(1,booking_id);
						stmt2.setString(2, customer.getName());
						stmt2.setString(3,customer.getEmail());
						stmt2.setString(4,customer.getPhoneNo());
						
						int result1 = stmt2.executeUpdate();
						if (result1==0) {
							return false;
						}
					}
				}
				else {
					return false;
				}
			}
			else {
				return false;
			}
			
		} finally {
	        if (generatedkeys != null) generatedkeys.close();
	        if (stmt1 != null) stmt1.close();
	    }
		
		return true;
		
	}
	
	public List<Booking>fetchOfflineBookings() {
		
		String query = "SELECT b.booking_id,b.room_id,b.checkin_date,b.checkout_date,b.booking_status,oc.name,oc.email,oc.phone_no,r.room_price "+
					   "FROM BOOKING b "+
					   "JOIN OFFLINECUSTOMER oc "+
					   "ON b.booking_id=oc.booking_id "+
					   "JOIN ROOMS r ON b.room_id = r.room_id";
		
		List<Booking> booking = new ArrayList<>();
		
		try {
			PreparedStatement stmt = connection.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				Customer customer = new Customer(
						rs.getString("name"),
						rs.getString("email"),
						rs.getString("phone_no")
						);
				booking.add(new Booking(
						rs.getInt("booking_id"),
						rs.getInt("room_id"),
						rs.getDate("checkin_date"),
						rs.getDate("checkout_date"),
						rs.getInt("booking_status"),
						rs.getDouble("room_price"),
						customer
						));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return booking;
		
	}
}
