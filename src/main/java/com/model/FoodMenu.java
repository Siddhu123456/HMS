package com.model;

public class FoodMenu {

    private int itemId;
    private String itemName;
    private String descriptionOfItem;
    private double itemPrice;
    private int quantity;
    private String itemImage;
    private int itemType;
    private boolean availabilityStatus;

    
	// Default constructor
    public FoodMenu() {}

    // Parameterized constructor
    public FoodMenu(int itemId, String itemName, String descriptionOfItem, double itemPrice,String itemImage,int itemType) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.descriptionOfItem = descriptionOfItem;
        this.itemPrice = itemPrice;
        this.itemImage = itemImage;
        this.itemType = itemType;
    }
    
    //constuctor retrive values from the table along with the availabilutyStatus of the item
    public FoodMenu(int itemId, String itemName, String descriptionOfItem, double itemPrice,String itemImage,int itemType,boolean availabilityStatus) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.descriptionOfItem = descriptionOfItem;
        this.itemPrice = itemPrice;
        this.itemImage = itemImage;
        this.itemType = itemType;
        this.availabilityStatus = availabilityStatus;
    }
    
    public FoodMenu(String itemName, String descriptionOfItem, double itemPrice,String itemImage,int itemType,boolean availabilityStatus) {
        this.itemName = itemName;
        this.descriptionOfItem = descriptionOfItem;
        this.itemPrice = itemPrice;
        this.itemImage = itemImage;
        this.itemType = itemType;
        this.availabilityStatus = availabilityStatus;
    }

    // Getters and Setters
    public int getItemId() {
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

    public String getDescriptionOfItem() {
        return descriptionOfItem;
    }

    public void setDescriptionOfItem(String descriptionOfItem) {
        this.descriptionOfItem = descriptionOfItem;
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

    public String getItemImage() {
        return itemImage;
    }

    public void setItemImage(String itemImage) {
        this.itemImage = itemImage;
    }

    public int getItemType() {
		return itemType;
	}

	public void setItemType(int itemType) {
		this.itemType = itemType;
	}
	public boolean isAvailabilityStatus() {
		return availabilityStatus;
	}

	public void setAvailabilityStatus(boolean availabilityStatus) {
		this.availabilityStatus = availabilityStatus;
	}


	// toString method to display food item details
    @Override
    public String toString() {
        return "FoodMenu{" +
                "itemId=" + itemId +
                ", itemName='" + itemName + '\'' +
                ", descriptionOfItem='" + descriptionOfItem + '\'' +
                ", itemPrice=" + itemPrice +
                ", quantity=" + quantity +
                ", itemImage='" + itemImage + '\'' +
                '}';
    }
}
