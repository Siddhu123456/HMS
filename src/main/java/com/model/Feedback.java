package com.model;

import java.sql.Timestamp;

public class Feedback {
    private int feedbackId;
    private int custId;
    private Timestamp givenDate;
    private String feedbackText;
    private int rating;
    private int bookingId;

    // Default constructor
    public Feedback() {}

    // Parameterized constructor
    public Feedback(int custId, String feedbackText, int rating,int bookingId) {
        this.custId = custId;
        this.feedbackText = feedbackText;
        this.rating = rating;
        this.bookingId = bookingId;
    }
    
    //constructur for retriveing the feedbacks
    public Feedback(int feedbackId, int custId,int bookingId,Timestamp givenDate, String feedbackText, int rating) {
        this.feedbackId = feedbackId;
    	this.custId = custId;
    	this.bookingId = bookingId;
    	this.givenDate = givenDate;
        this.feedbackText = feedbackText;
        this.rating = rating;
        
    }
    
    public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	// Getters and Setters
    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getCustId() {
        return custId;
    }

    public void setCustId(int custId) {
        this.custId = custId;
    }

    public Timestamp getGivenDate() {
        return givenDate;
    }

    public void setGivenDate(Timestamp givenDate) {
        this.givenDate = givenDate;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    // Override toString() method for debugging
    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackId=" + feedbackId +
                ", custId=" + custId +
                ", givenDate=" + givenDate +
                ", feedbackText='" + feedbackText + '\'' +
                ", rating=" + rating +
                '}';
    }
}
