package com.controler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import com.DAO.OfflineBookingDAO;
import com.model.Booking;
import com.model.Customer;

import DBConnect.DBconnection;

/**
 * Servlet implementation class OfflineBookingController
 */
@WebServlet("/OfflineBookingController")
public class OfflineBookingController extends HttpServlet {
	
	private Connection connection;
	private OfflineBookingDAO offlinebookingDAO;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.offlinebookingDAO = new OfflineBookingDAO(connection);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Booking> booking = offlinebookingDAO.fetchOfflineBookings();
		if (booking != null) {
			if("payed".equals(request.getParameter("action"))) {
    			request.setAttribute("payed", "payed");
    		}
			request.setAttribute("bookings", booking);
			request.getRequestDispatcher("offlinebookingpayment.jsp").forward(request, response);
		}
		else {
			PrintWriter out = response.getWriter();
			out.println("ur not lucky");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phoneNo = request.getParameter("phone_no");
		Integer custId = Integer.parseInt((String)request.getParameter("cust_id"));
		Integer roomId = Integer.parseInt((String)request.getParameter("room_id"));
		Date checkinDate = Date.valueOf(request.getParameter("checkin_date"));
        Date checkoutDate = Date.valueOf(request.getParameter("checkout_date"));
        
		Customer customer = new Customer(name,email,phoneNo);
		
		Booking booking = new Booking(custId,roomId,checkinDate,checkoutDate,customer);
		
		try {
			boolean isSuccess = offlinebookingDAO.offlineBooking(booking);
			
			PrintWriter out = response.getWriter();
			if(isSuccess) {
				response.sendRedirect("receptionist.jsp?booking=success");
			}
			else {
				out.println("ur unlucky.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
