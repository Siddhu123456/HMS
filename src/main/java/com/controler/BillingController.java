package com.controler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import com.DAO.BillingDAO;
import com.DAO.BookingDAO;

import DBConnect.DBconnection;

/**
 * Servlet implementation class BillingServlet
 */
@WebServlet("/BillingController")
public class BillingController extends HttpServlet {
	
	private Connection connection;
	private BillingDAO billingDAO;
	private BookingDAO bookingDAO;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.billingDAO = new BillingDAO(connection);
			this.bookingDAO = new BookingDAO(connection);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int custId = Integer.parseInt(request.getParameter("customerId"));
		int bookingId = Integer.parseInt(request.getParameter("bookingId"));
		Double totalBill = Double.parseDouble(request.getParameter("totalBill"));
		
		try {
			boolean isInserted = billingDAO.addBilling(custId,bookingId,totalBill);
			boolean isUpdated = bookingDAO.updateBookingStatus(bookingId,3);
			
			if(isInserted && isUpdated) {
				if(custId == 18) {
					response.sendRedirect("OfflineBookingController?action=payed");
				}
				else {
					response.sendRedirect("ReceptionistpayController?action=payed");
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
