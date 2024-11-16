package com.controler;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import com.DAO.BookingDAO;
import com.DAO.CustomerDAO;
import com.model.Booking;
import com.model.Customer;

import DBConnect.DBconnection;

@WebServlet("/BookingController")
public class BookingController extends HttpServlet {
    
    private Connection conn;
    private BookingDAO bookingDAO;
    private CustomerDAO customerDAO;
    
    public void init() {
        try {
            this.conn = DBconnection.getConnection();
            this.bookingDAO = new BookingDAO(conn);
            this.customerDAO = new CustomerDAO(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	System.out.println(request.getParameter("action"));
    	if("login".equals(request.getParameter("action"))) {
    		getUserBookings(request,response);
        }
        else {
        	fetchBookings(request,response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
        	case "bookroom":
        		bookNow(request, response);
        		break;
        	case "receptionist":
        		updateBookingStatus(request, response);
        }
        
    }
    
    private void bookNow(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Retrieve parameters from the request
            int custId = Integer.parseInt(request.getParameter("cust_id"));
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            Date checkinDate = Date.valueOf(request.getParameter("checkin_date"));
            Date checkoutDate = Date.valueOf(request.getParameter("checkout_date"));
            
            // Create BookingModel object
            Booking bookingModel = new Booking(custId, roomId, checkinDate, checkoutDate);

            // Call DAO to book the room
            boolean isBooked = bookingDAO.bookRoom(bookingModel);

            // Send response based on booking status
            if (isBooked) {
                response.sendRedirect("BookingController?action=login&booking=success");
            } else {
                response.getWriter().write("Failed to book the room. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred while processing your booking.");
        }
    }
    
    private void fetchBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	ArrayList<Booking> bookingList = bookingDAO.fetchBooking();
    	ArrayList<Customer> customerDetails = new ArrayList<>();
    	for(Booking booking : bookingList) {
    		Customer customer = customerDAO.getCustomerDetails(booking.getCustId());
    		if(customer != null) {
    			customerDetails.add(customer);
    		}
    	}
    	request.setAttribute("bookingList", bookingList);
    	request.setAttribute("customerDetails", customerDetails);
    	
    	RequestDispatcher rs = request.getRequestDispatcher("receptionistbookingrequest.jsp");
    	rs.forward(request,response);
    }
    
    private void updateBookingStatus(HttpServletRequest request,HttpServletResponse response) {
    	
    	int bookingId = Integer.parseInt(request.getParameter("booking_id"));
    	int bookingStatus = Integer.parseInt(request.getParameter("booking_status"));
    	
    	bookingDAO.updateBookingStatus(bookingId, bookingStatus);
    	
    	try {
			fetchBookings(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    private void getUserBookings(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
    	
    	Customer customer = (Customer) request.getSession().getAttribute("customer");
        if (customer != null) {
            int custId = customer.getCustomerId();
            ArrayList<Booking> userBookings = bookingDAO.getBookingsByCustomerId(custId);
            request.setAttribute("userBookings", userBookings);
        }
        if("success".equals(request.getParameter("booking"))) {
        	request.setAttribute("booking", "success");
        }
        if("success".equals(request.getParameter("foodorder"))) {
        	request.setAttribute("foodorder", "success");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
