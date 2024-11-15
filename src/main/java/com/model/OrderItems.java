package com.model;

public class OrderItems {
	private int orderItemId;
	private int orderId;
	private int item_id;
	private String item_name;
	private int quantity;
	private double totalItemsPrice;
	
	public OrderItems(int item_id,String item_name,int quantity,double totalItemsPrice) {
		this.item_id = item_id;
		this.item_name = item_name;
		this.quantity = quantity;
		this.totalItemsPrice = totalItemsPrice;
	}
	public int getOrderItemId() {
		return orderItemId;
	}
	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getTotalItemsPrice() {
		return totalItemsPrice;
	}
	public void setTotalItemsPrice(double totalItemsPrice) {
		this.totalItemsPrice = totalItemsPrice;
	}
	
	
}
