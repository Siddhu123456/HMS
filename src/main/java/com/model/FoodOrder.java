package com.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class FoodOrder {
	private int orderId;
	private int custId;
	private int bookingId;
	private Date orderDate;
	private Timestamp orderdate;
	private double orderTotalPrice;
	private boolean orderStatus;
	private int roomId;
	private List<OrderItems> orderItems;
				
	public FoodOrder(int orderId,int custId,int orderTotalPrice,boolean orderStatus) {
			this.orderId = orderId;
			this.custId = custId;
			this.orderTotalPrice = orderTotalPrice;
			this.orderStatus = orderStatus;
	}

	//constructor for inserting to FOODORDER AND ORDERITEMS TABLE AT THE SAME TIME
	public FoodOrder(int custId,int bookingId,double orderTotalPrice,List<OrderItems> orderItems,int roomId) {
		this.custId = custId;
		this.bookingId = bookingId;
		this.orderTotalPrice = orderTotalPrice;
		this.orderItems = orderItems;
		this.roomId = roomId;
	}
	
	//constructor for retrive all the coluums of the FOODORDER table
	public FoodOrder(int orderId,int custId,int bookingId,Date orderDate,double orderTotalPrice,boolean orderStatus,int roomId) {
		this.orderId = orderId;
		this.custId = custId;
		this.bookingId = bookingId;
		this.orderDate = orderDate;
		this.orderTotalPrice = orderTotalPrice;
		this.orderStatus = orderStatus;
		this.roomId = roomId;
	}
	
	//constuctor to retrive the date as Timestamp
	public FoodOrder(int orderId,int custId,int bookingId,Timestamp orderdate,double orderTotalPrice,boolean orderStatus,int roomId) {
		this.orderId = orderId;
		this.custId = custId;
		this.bookingId = bookingId;
		this.orderdate = orderdate;
		this.orderTotalPrice = orderTotalPrice;
		this.orderStatus = orderStatus;
		this.roomId = roomId;
	}

	public Timestamp getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Timestamp orderdate) {
		this.orderdate = orderdate;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public List<OrderItems> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItems> orderItems) {
		this.orderItems = orderItems;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public double getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(double orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}

	public boolean isOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(boolean orderStatus) {
		this.orderStatus = orderStatus;
	}
}
