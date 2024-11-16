package com.DAO;


import com.model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import DBConnect.DBconnection;

public class LoginDAO {

    private Connection connection;

    public LoginDAO(Connection connection) {
        this.connection = connection;
    }

    // Sign up a new customer
    public boolean signUp(Customer customer) {
        String sql = "INSERT INTO CUSTOMER (name, email, password, phone_no) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPassword());
            statement.setString(4, customer.getPhoneNo());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0; // Returns true if sign-up is successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Login function to authenticate a customer
    public Customer login(String email, String password) {
        String sql = "SELECT * FROM CUSTOMER WHERE email = ? AND password = ?";
        Customer customer = null;

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            statement.setString(2, password);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                customer = new Customer();
                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setName(resultSet.getString("name"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPassword(resultSet.getString("password"));
                customer.setPhoneNo(resultSet.getString("phone_no"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer; // Returns customer object if login is successful, null otherwise
    }

    // Logout function (no database interaction needed for simple logout)
    public void logout() {
        // For a simple logout, no action is required in the database
        // You can add session management or cleanup here if needed
        System.out.println("User logged out successfully.");
    }
}
