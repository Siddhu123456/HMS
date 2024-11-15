package com.model;

public class CartItem {
    private int itemId;
    private String itemName;
    private double itemPrice;
    private int quantity;

    // Constructor
    public CartItem(int itemId, String itemName, double itemPrice, int quantity) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getItemId() 
    { 
    	return itemId; 
    }
    public void setItemId(int itemId) { 
    	this.itemId = itemId; 
    }

    public String getItemName() {
    	return itemName; 
    }
    public void setItemName(String itemName) {
    	this.itemName = itemName; 
    }

    public double getItemPrice() {
    	return itemPrice; 
    }
    public void setItemPrice(double itemPrice) {
    	this.itemPrice = itemPrice; 
    }

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

    
}
