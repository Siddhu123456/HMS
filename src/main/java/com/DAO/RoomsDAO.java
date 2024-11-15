package com.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.model.Rooms;

public class RoomsDAO {
    
    private Connection connection;
    
    public RoomsDAO (Connection connection) {
        this.connection = connection;
    }
    
    public ArrayList<Rooms> fetchRooms(String checkinDate, String checkoutDate) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        
        ArrayList<Rooms> roomlist = new ArrayList<>();
        
        try {
            // Parse Strings to java.util.Date
            java.util.Date utilCheckinDate = formatter.parse(checkinDate);
            java.util.Date utilCheckoutDate = formatter.parse(checkoutDate);
            
            // Convert java.util.Date to java.sql.Date for SQL compatibility
            Date sqlCheckinDate = new Date(utilCheckinDate.getTime());
            Date sqlCheckoutDate = new Date(utilCheckoutDate.getTime());
            
            System.out.println("Check-in Date: " + sqlCheckinDate);
            System.out.println("Check-out Date: " + sqlCheckoutDate);
            
            String query = "SELECT room_id, room_type, room_description, room_image, room_price " +
                           "FROM ROOMS " +
                           "WHERE availability_status=1 AND room_id NOT IN (" +
                           "SELECT room_id " +
                           "FROM BOOKING " +
                           "WHERE (booking_status IS NULL OR booking_status NOT IN (2, 3, 0)) AND NOT (checkin_date > ? OR checkout_date < ?)" +
                           ");";
            
            PreparedStatement stmt = connection.prepareStatement(query);
            // Set parameters correctly
            stmt.setDate(1, sqlCheckoutDate);  // checkout_date < ?
            stmt.setDate(2, sqlCheckinDate);   // checkin_date > ?
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                int roomId = rs.getInt("room_id");
                String roomType = rs.getString("room_type");
                String roomDescription = rs.getString("room_description");
                String roomImage = rs.getString("room_image");
                BigDecimal roomPrice = rs.getBigDecimal("room_price");
                
                System.out.println("Room ID: " + roomId);
                
                roomlist.add(new Rooms(roomId, roomType, roomDescription, roomImage, roomPrice, true));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        return roomlist;
    }
    
    public List<Rooms> fetchAllRooms() {
    	
    	String query = "SELECT * FROM ROOMS";
    	
    	List<Rooms> roomlist = new ArrayList<>();
    	try {
			PreparedStatement stmt = connection.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			
			
			while(rs.next()) {
				int roomId = rs.getInt("room_id");
                String roomType = rs.getString("room_type");
                String roomDescription = rs.getString("room_description");
                String roomImage = rs.getString("room_image");
                BigDecimal roomPrice = rs.getBigDecimal("room_price");
                boolean avalabilityStatus = rs.getBoolean("availability_status");
                
                roomlist.add(new Rooms(roomId, roomType, roomDescription, roomImage, roomPrice, avalabilityStatus));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return roomlist;
    }
    
    public boolean updateRoomStatus(int roomId,Double price,boolean availabilityStatus) {
    	
    	String query = "UPDATE ROOMS SET availability_status=?,room_price=? WHERE room_id = ?";
    	System.out.print(roomId);
    	try {
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setBoolean(1, availabilityStatus);
			stmt.setDouble(2, price);
			stmt.setInt(3, roomId);
			
			int result = stmt.executeUpdate();
			System.out.println(result);
			if(result > 0) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return false;
    }
}
