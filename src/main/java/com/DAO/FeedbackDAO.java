package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Booking;
import com.model.Feedback;

public class FeedbackDAO {
	
	private Connection connection;
	
	public FeedbackDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean saveFeedback(Feedback feedback) {
		
		String query = "INSERT INTO FEEDBACK (cust_id, feedback_text, rating, booking_id) values(?, ?, ?, ?)";
		
		try {
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setInt(1, feedback.getCustId());
			stmt.setString(2, feedback.getFeedbackText());
			stmt.setInt(3, feedback.getRating());
			stmt.setInt(4, feedback.getBookingId());
			
			int result = stmt.executeUpdate();
			
			if(result > 0) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Feedback> getAllFeedbacks() throws SQLException {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT feedback_id, cust_id, booking_id, given_date, feedback_text, rating FROM FEEDBACK";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setCustId(rs.getInt("cust_id"));
                feedback.setBookingId(rs.getInt("booking_id"));
                feedback.setGivenDate(rs.getTimestamp("given_date"));
                feedback.setFeedbackText(rs.getString("feedback_text"));
                feedback.setRating(rs.getInt("rating"));
                
                feedbackList.add(feedback);
            }
        }
        return feedbackList;
    }

}
