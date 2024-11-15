package com.controler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.DAO.CustomerDAO;
import com.DAO.FoodDAO;
import com.DAO.FoodOrderDAO;
import com.model.Customer;
import com.model.FoodMenu;
import com.model.FoodOrder;

import DBConnect.DBconnection;


@WebServlet("/FoodManagerController")
public class FoodManagerController extends HttpServlet {
	
	private FoodOrderDAO foodorderDAO;
	private Connection connection;
	private CustomerDAO customerDAO;
	private FoodDAO foodDAO;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.foodorderDAO = new FoodOrderDAO(connection);
			this.customerDAO = new CustomerDAO(connection);
			this.foodDAO = new FoodDAO(connection);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if("foodmanager".equals(request.getParameter("action"))) {
			fetchFoodOrders(request,response);
		}
		else {
			fetchFoodMenu(request,response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if("updatefooditem".equals(request.getParameter("action"))) {
			updateFoodItem(request,response);
		}
		else if ("addfooditem".equals(request.getParameter("action"))) {
			addFoodItem(request,response);
		}
		else {
			updateOrderStatus(request,response);
		}
	}
	
	protected void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		boolean isUpdated = foodorderDAO.updateOrderStatus(orderId);
		if(isUpdated) {
			String action = "statusupdated";
			response.sendRedirect("FoodManagerController?action=foodmanager&action1="+action);
		}
		else {
			PrintWriter out = response.getWriter();
			out.println("Not assigned to server.");
		}
	}

	protected void fetchFoodOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<FoodOrder> foodOrders = foodorderDAO.fetchFoodOrders();
		List<Customer> customerDetails = new ArrayList<>();
		
		for(FoodOrder foodorder : foodOrders) {
			Customer customer = customerDAO.getCustomerDetails(foodorder.getCustId());
			customerDetails.add(customer);
		}
		request.setAttribute("customerdetails", customerDetails);
		request.setAttribute("foodorders", foodOrders);
		
		if("statusupdated".equals(request.getParameter("action1"))) {
			request.setAttribute("orderstatus",1);
		}
		else if ("orderhistory".equals(request.getParameter("action1"))) {
			request.getRequestDispatcher("foodorderhistory.jsp").forward(request,response);
			return;
		}
		
		request.getRequestDispatcher("foodmanager.jsp").forward(request, response);
	}
	
	protected void fetchFoodMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<FoodMenu> menuList = foodDAO.getFoodMenuForManager();
		if("1".equals(request.getParameter("updatestatus"))) {
			request.setAttribute("updateStatus", "success");
		}
		else if ("2".equals(request.getParameter("updatestatus"))) {
			request.setAttribute("addedfooditem", "yes");
		}
		request.setAttribute("foodmenu", menuList);
		request.getRequestDispatcher("editfoodmenu.jsp").forward(request, response);
		
	}
	
	protected void updateFoodItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int itemId = Integer.parseInt(request.getParameter("itemId"));
		Double price = Double.parseDouble(request.getParameter("price"));
		String status = request.getParameter("status");
		boolean availabilityStatus = "1".equals(status);
		
		boolean isUpdated = foodDAO.updateFoodItem(itemId, availabilityStatus,price);
		
		if(isUpdated) {
			response.sendRedirect("FoodManagerController?updatestatus=1");
		}
		else {
			PrintWriter out = response.getWriter();
			out.println("the update is unsucessfull");
		}
	}
	
	protected void addFoodItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String itemName = request.getParameter("itemName");
		Double price = Double.parseDouble(request.getParameter("itemPrice"));
		int itemType = Integer.parseInt(request.getParameter("itemType"));
		String description = request.getParameter("descriptionOfItem");
		String itemImage = request.getParameter("itemImage");
		String status = request.getParameter("availabilityStatus");
		boolean availabilityStatus = "1".equals(status);
		
		FoodMenu fooditem = new FoodMenu(itemName,description,price,itemImage,itemType,availabilityStatus);
		
		boolean isUpdated = foodDAO.addFoodItem(fooditem);
		
		if (isUpdated) {
			response.sendRedirect("FoodManagerController?updatestatus=2");
		}
		else {
			PrintWriter out = response.getWriter();
			out.println("adding the fooditem is unsucessfull");
		}
	}
}
