package com.model;

import java.sql.Timestamp;

import com.controler.Override;

public class Billing {
    private int billId;
    private int custId; 
    private int bookingId; 
    private double totalBill;
    private Timestamp paymentDate;
    private Customer customer;

    // Constructor
    public Billing(int billId, int custId, int bookingId, double totalBill, Timestamp paymentDate) {
        this.billId = billId;
        this.custId = custId;
        this.bookingId = bookingId;
        this.totalBill = totalBill;
        this.paymentDate = paymentDate;
    }
    
    //consturctor for billhistory view of manager
    public Billing(int billId, int custId, int bookingId, double totalBill, Timestamp paymentDate, Customer customer) {
        this.billId = billId;
        this.custId = custId;
        this.bookingId = bookingId;
        this.totalBill = totalBill;
        this.paymentDate = paymentDate;
        this.customer = customer;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
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

    

    public double getTotalBill() {
        return totalBill;
    }

    public void setTotalBill(double totalBill) {
        this.totalBill = totalBill;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }
    
    public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	// Optional: toString method for debugging purposes
    @Override
    public String toString() {
        return "Billing{" +
                "billId=" + billId +
                ", custId=" + custId +
                ", bookingId=" + bookingId +
                ", totalBill=" + totalBill +
                ", paymentDate=" + paymentDate +
                '}';
    }
}

