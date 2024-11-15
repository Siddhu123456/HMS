package com.model;

import java.math.BigDecimal;

public class Rooms {
    private int roomId;
    private String roomType;
    private String roomDescription;
    private String roomImage;
    private BigDecimal roomPrice;
    private boolean availabilityStatus;

    // Constructor
    public Rooms(int roomId, String roomType, String roomDescription, String roomImage, BigDecimal roomPrice, boolean availabilityStatus) {
        this.roomId = roomId;
        this.roomType = roomType;
        this.roomDescription = roomDescription;
        this.roomImage = roomImage;
        this.roomPrice = roomPrice;
        this.availabilityStatus = availabilityStatus;
    }

    // Getters and Setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getRoomDescription() {
        return roomDescription;
    }

    public void setRoomDescription(String roomDescription) {
        this.roomDescription = roomDescription;
    }

    public String getRoomImage() {
        return roomImage;
    }

    public void setRoomImage(String roomImage) {
        this.roomImage = roomImage;
    }

    public BigDecimal getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(BigDecimal roomPrice) {
        this.roomPrice = roomPrice;
    }

    public boolean isAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(boolean availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    @Override
    public String toString() {
        return "RoomsModel{" +
                "roomId=" + roomId +
                ", roomType='" + roomType + '\'' +
                ", roomDescription='" + roomDescription + '\'' +
                ", roomImage='" + roomImage + '\'' +
                ", roomPrice=" + roomPrice +
                ", availabilityStatus=" + availabilityStatus +
                '}';
    }
}
