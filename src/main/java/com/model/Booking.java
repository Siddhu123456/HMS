package com.model;

import java.sql.Date;
import java.util.List;

public class Booking {
    private int bookingId;        
    private Integer custId;     
    private Integer roomId;       
    private Date checkinDate;     
    private Date checkoutDate;    
    private int bookingStatus;
    private List<FoodOrder> foodorder;
    private Customer customer;
    private Double pricepernight;
    private boolean bookingMood;
    

	// Constructor for retrieving
    public Booking(int bookingId, Integer custId, Integer roomId, Date checkinDate, Date checkoutDate, int bookingStatus) {
        this.bookingId = bookingId;
        this.custId = custId;
        this.roomId = roomId;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.bookingStatus = bookingStatus;
    }

    // Constructor for inserting a new booking (without bookingId)
    public Booking(Integer custId, Integer roomId, Date checkinDate, Date checkoutDate) {
        this.custId = custId;
        this.roomId = roomId;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
    }
    
    //Constructor for retriving the bookingdate along with customer and foodorder made by that bookingId
    public Booking(int bookingId, Integer custId, Integer roomId, Date checkinDate, Date checkoutDate,int bookingStatus,Double pricepernight) {
    	this.bookingId = bookingId;
    	this.custId = custId;
    	this.roomId = roomId;
    	this.checkinDate = checkinDate;
    	this.checkoutDate = checkoutDate;
    	this.bookingStatus = bookingStatus;
    	this.pricepernight = pricepernight;
    }
    
    //constructor for offline booking by receptionist
    public Booking(Integer custId, Integer roomId, Date checkinDate, Date checkoutDate,Customer customer) {
        this.custId = custId;
        this.roomId = roomId;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.customer = customer;
    }
    
    //constructor for retriving offline bookings
    public Booking(Integer bookingId,Integer roomId,Date checkinDate, Date checkoutDate,int bookingStatus,Double pricepernight,Customer customer) {
    	this.bookingId = bookingId;
    	this.roomId = roomId;
    	this.checkinDate = checkinDate;
    	this.checkoutDate = checkoutDate;
    	this.bookingStatus = bookingStatus;
    	this.pricepernight = pricepernight;
    	this.customer = customer;
    }

    public Double getPricepernight() {
		return pricepernight;
	}

	public void setPricepernight(Double pricepernight) {
		this.pricepernight = pricepernight;
	}

	// Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public Integer getCustId() {
        return custId;
    }

    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public Date getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(Date checkinDate) {
        this.checkinDate = checkinDate;
    }

    public Date getCheckoutDate() {
        return checkoutDate;
    }

    public void setCheckoutDate(Date checkoutDate) {
        this.checkoutDate = checkoutDate;
    }

    public int getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(int bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    public List<FoodOrder> getFoodorder() {
		return foodorder;
	}

	public void setFoodorder(List<FoodOrder> foodorder) {
		this.foodorder = foodorder;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public boolean isBookingMood() {
		return bookingMood;
	}

	public void setBookingMood(boolean bookingMood) {
		this.bookingMood = bookingMood;
	}

}
