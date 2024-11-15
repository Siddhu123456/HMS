package com.controler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.DAO.FoodOrderDAO;
import com.model.CartItem;
import com.model.FoodOrder;
import com.model.OrderItems;

import DBConnect.DBconnection;


@WebServlet("/FoodOrderController")
public class FoodOrderController extends HttpServlet {
	
	private Connection connection;
	private FoodOrderDAO foodorderDAO;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.foodorderDAO = new FoodOrderDAO(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String custId = request.getParameter("customerId");
        
        // Check if customerId is provided and valid
        if (custId == null || custId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID is required.");
            return;
        }
        
        int customerId;
        try {
            customerId = Integer.parseInt(custId);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Customer ID format.");
            return;
        }

        List<FoodOrder> foodOrders = foodorderDAO.getFoodOrdersByCustomerId(customerId);

        request.setAttribute("foodOrders", foodOrders);
        request.getRequestDispatcher("viewfoodorders.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		System.out.println(session.getAttribute("customer_id"));
		System.out.println(session.getAttribute("bookingId"));
		System.out.println(session.getAttribute("room_id"));
		
		double totalCartPrice = (double) session.getAttribute("totalCartPrice");
		ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
		Integer customerId = Integer.parseInt((String) session.getAttribute("customer_id"));
	    Integer bookingId = Integer.parseInt((String) session.getAttribute("bookingId"));
	    Integer roomId = Integer.parseInt((String) session.getAttribute("room_id"));
		
		
		
		List<OrderItems> orderitems = new ArrayList<>();
		
		
		for(CartItem item : cart) {
			int quantity = item.getQuantity();
			double itemprice = item.getItemPrice();
			double totalitemsprice = quantity*itemprice;
			orderitems.add(new OrderItems(
					item.getItemId(),
					item.getItemName(),
					quantity,
					totalitemsprice
					));
		}
		
		FoodOrder foodorder = new FoodOrder(customerId,bookingId,totalCartPrice,orderitems,roomId);
		PrintWriter out = response.getWriter();
		try {
			boolean isSuccess = foodorderDAO.placeFoodOrder(foodorder);
			System.out.println(isSuccess);
			if(isSuccess) {
				
				session.removeAttribute("customer_id");
		        session.removeAttribute("bookingId");
		        session.removeAttribute("room_id");
		        session.removeAttribute("totalCartPrice");
		        session.removeAttribute("cart");
		        session.removeAttribute("itemType");
		        
				response.sendRedirect("BookingController?action=login&foodorder=success");
			}
			else {
				out.println("ur unlucky");
			}
		} catch (SQLException e) {
			out.println("ur unlucky");
		}
	}

}
