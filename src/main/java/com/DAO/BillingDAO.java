package com.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Billing;

public class BillingDAO {
    private Connection connection;

    // Constructor to initialize the connection
    public BillingDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to add a new billing record
    public boolean addBilling(int custId,int bookingId, Double totalBill) throws SQLException {
        String sql = "INSERT INTO BILLING (cust_id, booking_id,total_bill) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, custId);
            statement.setInt(2, bookingId);
            statement.setDouble(3, totalBill);
            int result = statement.executeUpdate();
            if (result>0)
            	return true;
            else
            	return false;
        }
    }

    
    // Method to get all billing records
    public List<Billing> getAllBillings() throws SQLException {
        List<Billing> billings = new ArrayList<>();
        String sql = "SELECT * FROM BILLING";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                billings.add(new Billing (
                		rs.getInt("bill_id"),
                		rs.getInt("cust_id"),
                		rs.getInt("booking_id"),
                		rs.getDouble("total_bill"),
                		rs.getTimestamp("payment_date")
                		));
            }
        }
        return billings;
    }

    // Method to delete a billing record
    public void deleteBilling(int billId) throws SQLException {
        String sql = "DELETE FROM BILLING WHERE bill_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, billId);
            statement.executeUpdate();
        }
    }

    
}

