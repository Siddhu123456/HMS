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
import java.util.ArrayList;
import java.util.List;

import com.DAO.BookingDAO;
import com.DAO.FeedbackDAO;
import com.model.Booking;
import com.model.Feedback;

import DBConnect.DBconnection;

@WebServlet("/FeedbackController")
public class FeedbackController extends HttpServlet {
	
	private Connection connection;
	private FeedbackDAO feedbackDAO;
	private BookingDAO bookingDAO;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.feedbackDAO = new FeedbackDAO(connection);
			this.bookingDAO = new BookingDAO(connection);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if("reception".equals(request.getParameter("action"))) {
			
			List<Feedback> feedbacks = new ArrayList<>();
			
			try {
				feedbacks = feedbackDAO.getAllFeedbacks();
				
				request.setAttribute("feedbacks", feedbacks);
				request.getRequestDispatcher("viewfeedback.jsp").forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else {
			fetchfbPendings(request,response);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println(request.getParameter("rating"));
		System.out.println(request.getParameter("bookingId"));
		String feedbackText = request.getParameter("feedbackText");
        int rating = Integer.parseInt(request.getParameter("rating"));
        int customerId = Integer.parseInt(request.getParameter("custId"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        
        Feedback feedback = new Feedback(customerId,feedbackText,rating,bookingId);
        
        boolean success = feedbackDAO.saveFeedback(feedback);
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (success) {
            response.sendRedirect("FeedbackController?action=savedfb&custId="+customerId);
        } else {
            out.print("{\"success\": false}");
        }
        out.flush();
	}
	
	protected void fetchfbPendings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int customerId = Integer.parseInt(request.getParameter("custId"));
		
		List<Booking> fbPendingBookings = bookingDAO.fetchfbPendingBookings(customerId);
		
		if("savedfb".equals(request.getParameter("action"))) {
			request.setAttribute("savedfb", "saved");
			request.setAttribute("custId", customerId);
		}
		request.setAttribute("fbpendingbookings", fbPendingBookings);
		request.getRequestDispatcher("feedback.jsp").forward(request, response);
	}
}
