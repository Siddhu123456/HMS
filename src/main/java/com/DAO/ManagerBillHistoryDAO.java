package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Billing;
import com.model.Customer;

public class ManagerBillHistoryDAO {
	
	private Connection connection;
	
	public ManagerBillHistoryDAO(Connection connection) {
		this.connection = connection;
	}
	
	public List<Billing> fetchBillHistory() {
		
		List<Billing> billHistory = new ArrayList<>();
		Customer customer = new Customer();
		
		String query = "SELECT B.*, "+
			    	   "COALESCE(OC.name, C.name) AS name, "+
			    	   "COALESCE(OC.email, C.email) AS email, "+
			    	   "COALESCE(OC.phone_no, C.phone_no) AS phone_no "+
			    	   "FROM "+
			    	   "BILLING B "+
			    	   "LEFT JOIN "+
			    	   "CUSTOMER C ON B.cust_id = C.customer_id AND B.cust_id != 18 "+
			    	   "LEFT JOIN "+
			    	   "OFFLINECUSTOMER OC ON B.cust_id = 18 AND B.booking_id = OC.booking_id "+
			    	   "ORDER BY "+
			    	   "B.booking_id DESC";
		
		
		try {
			PreparedStatement stmt = connection.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
				customer = new Customer(
						rs.getString("name"),
						rs.getString("email"),
						rs.getString("phone_no")
						);
				
				billHistory.add(new Billing(
						rs.getInt("bill_id"),
						rs.getInt("cust_id"),
						rs.getInt("booking_id"),
						rs.getDouble("total_bill"),
						rs.getTimestamp("payment_date"),
						customer
						));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return billHistory;
	}
}
