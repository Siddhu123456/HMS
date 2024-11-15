package com.controler;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.DAO.FoodDAO;
import com.model.CartItem;
import com.model.FoodMenu;

import DBConnect.DBconnection;


@WebServlet("/FoodController")
public class FoodController extends HttpServlet {
	private FoodDAO foodDAO;
	private Connection connection;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.foodDAO = new FoodDAO(connection);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        
		if (session.getAttribute("bookingId") == null) {
	        session.setAttribute("bookingId", request.getParameter("bookingId"));
	    }
	    if (session.getAttribute("customer_id") == null) {
	        session.setAttribute("customer_id", request.getParameter("customer_id"));
	    }
	    if (session.getAttribute("room_id") == null) {
	        session.setAttribute("room_id", request.getParameter("room_id"));
	    }
	    
        // Get the itemType parameter from the request, if present.
        String itemType = request.getParameter("itemType");
        
        // If itemType is not null, store it in the session to persist across reloads.
        if (itemType != null) {
            session.setAttribute("itemType", itemType);
        } else {
            // If itemType is not provided in request, use the session attribute if available.
            itemType = (String) session.getAttribute("itemType");
        }

        ArrayList<FoodMenu> menuList = foodDAO.getFoodMenu();
        
        // Get cart count for display
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        int cartCount = (cart != null) ? cart.size() : 0;

        request.setAttribute("menuList", menuList);
        request.setAttribute("cartCount", cartCount);
        request.setAttribute("itemType", itemType);
        
        
        RequestDispatcher rd = request.getRequestDispatcher("orderfood.jsp");
        rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

	    HttpSession session = request.getSession();
	    
	    if (session.getAttribute("bookingId") == null) {
	        session.setAttribute("bookingId", request.getParameter("bookingId"));
	    }
	    if (session.getAttribute("customer_id") == null) {
	        session.setAttribute("customer_id", request.getParameter("customer_id"));
	    }
	    if (session.getAttribute("room_id") == null) {
	        session.setAttribute("room_id", request.getParameter("room_id"));
	    }
	    
	    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

	    if ("removeItem".equals(action)) {
	        // Remove item from cart
	        int itemIdToRemove = Integer.parseInt(request.getParameter("itemId"));
	        
	        if (cart != null) {
	            cart.removeIf(item -> item.getItemId() == itemIdToRemove);
	            session.setAttribute("cart", cart); // Update session cart
	        }
	        
	        response.sendRedirect("FoodController"); // Reload page
	        return;
	    }
	    
		int itemId = Integer.parseInt(request.getParameter("itemId"));
	    String itemName = request.getParameter("itemName");
	    double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));
	    int quantity = Integer.parseInt(request.getParameter("quantity"));
	    
	    // Create a new CartItem with these details
	    CartItem newItem = new CartItem(itemId, itemName, itemPrice, quantity);

	    
	    if (cart == null) {
	        cart = new ArrayList<>();
	    }

	    // Check if the item already exists in the cart
	    boolean itemExists = false;
	    for (CartItem item : cart) {
	        if (item.getItemId() == itemId) {
	            item.setQuantity(item.getQuantity() + quantity);
	            itemExists = true;
	            break;
	        }
	    }

	    // If the item does not exist, add it to the cart
	    if (!itemExists) {
	        cart.add(newItem);
	    }

	    // Save the updated cart in the session
	    session.setAttribute("cart", cart);

	    // Redirect to the FoodController's GET method to reload the menu page with updated cart count
	    response.sendRedirect("FoodController");
	}
}
