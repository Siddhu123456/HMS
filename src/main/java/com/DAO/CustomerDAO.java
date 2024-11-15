package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.model.Customer;

public class CustomerDAO {
	
	private Connection connection;
	
	public CustomerDAO(Connection connection) {
		this.connection = connection;
	}
	
	public Customer getCustomerDetails(Integer custId) {
		
		Customer customer = null;
		
		String query = "SELECT name,email,phone_no FROM CUSTOMER WHERE customer_id = ?";
		
		try {
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setInt(1, custId);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				customer = new Customer();
				customer.setName(rs.getString("name"));;
				customer.setEmail(rs.getString("email"));
				customer.setPhoneNo(rs.getString("phone_no"));
				
				System.out.println(customer.getName());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return customer;
		
	}

}
