package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.model.FoodMenu;

public class FoodDAO {
	
	private Connection connection;
	
	public FoodDAO(Connection connection) {
		this.connection = connection;
	}
	
	public ArrayList<FoodMenu> getFoodMenu() {
		
		ArrayList<FoodMenu> MenuList = new ArrayList<>();
		
		String query = "SELECT * FROM FOOD_MENU WHERE availability_status=1";
		
		try {
			PreparedStatement stmt = connection.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			
				while(rs.next()) {
					FoodMenu foodMenu = new FoodMenu(
						rs.getInt("item_id"),
						rs.getString("item_name"),
						rs.getString("description_of_item"),
						rs.getDouble("item_price"),
						rs.getString("item_image"),
						rs.getInt("item_type")
					);
					
					MenuList.add(foodMenu);
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return MenuList;
	}
	
	public ArrayList<FoodMenu> getFoodMenuForManager() {
			
			ArrayList<FoodMenu> MenuList = new ArrayList<>();
			
			String query = "SELECT * FROM FOOD_MENU";
			
			try {
				PreparedStatement stmt = connection.prepareStatement(query);
				ResultSet rs = stmt.executeQuery();
				
					while(rs.next()) {
						FoodMenu foodMenu = new FoodMenu(
							rs.getInt("item_id"),
							rs.getString("item_name"),
							rs.getString("description_of_item"),
							rs.getDouble("item_price"),
							rs.getString("item_image"),
							rs.getInt("item_type"),
							rs.getBoolean("availability_status")
						);
						
						MenuList.add(foodMenu);
					}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return MenuList;
		}
	
		public boolean updateFoodItem(int itemId,boolean availabilityStatus,Double price) {
			
			String query = "UPDATE FOOD_MENU SET availability_status = ?, item_price = ? WHERE item_id = ?";
			
			try {
				PreparedStatement stmt = connection.prepareStatement(query);
				stmt.setBoolean(1, availabilityStatus);
				stmt.setDouble(2, price);
				stmt.setInt(3, itemId);
				
				int result = stmt.executeUpdate();
				System.out.println(result);
				if(result>0) {
					return true;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
		}
		
		public boolean addFoodItem(FoodMenu fooditem) {
			
			String query = "INSERT INTO FOOD_MENU (item_name,description_of_item,item_price,item_image,item_type,availability_status) VALUES(?, ?, ?, ?, ?, ?)";
			
			try {
				PreparedStatement stmt = connection.prepareStatement(query);
				stmt.setString(1, fooditem.getItemName());
				stmt.setString(2, fooditem.getDescriptionOfItem());
				stmt.setDouble(3, fooditem.getItemPrice());
				stmt.setString(4, fooditem.getItemImage());
				stmt.setInt(5,fooditem.getItemType());
				stmt.setBoolean(6, fooditem.isAvailabilityStatus());
				
				int result = stmt.executeUpdate();
				
				if (result>0) {
					return true;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
		}
}
