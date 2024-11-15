package com.controler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import com.DAO.RoomsDAO;
import com.model.Rooms;
import DBConnect.DBconnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RoomsController")
public class RoomsController extends HttpServlet {
	
	private RoomsDAO roomDAO;
	private Connection connection;
	
	@Override
	public void init() throws ServletException {
		try {
			this.connection = DBconnection.getConnection();
			this.roomDAO = new RoomsDAO(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		if("manager".equals(request.getParameter("action"))) {
			fetchAllRooms(request,response);
		}
		else {
			fetchRooms(request,response);
		}
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int roomId = Integer.parseInt(request.getParameter("roomId"));
		Double price = Double.parseDouble(request.getParameter("roomPrice"));
		String status = request.getParameter("availabilityStatus");
		boolean availabilityStatus = "1".equals(status);
		
		boolean isUpdated = roomDAO.updateRoomStatus(roomId,price,availabilityStatus);
		System.out.println(isUpdated);
		if(isUpdated) {
			String action = "statusupdated";
			response.sendRedirect("RoomsController?action=manager&action1="+action);
		}
		else {
			PrintWriter out = response.getWriter();
			out.println("Not assigned to server.");
		}
	}
	
	public void fetchRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int custId = Integer.parseInt(request.getParameter("customer_id"));
		String checkinDate = request.getParameter("checkin_date");
		String checkoutDate = request.getParameter("checkout_date");
		System.out.println("checkinDate");
		System.out.println("checkoutDate");
		ArrayList<Rooms> roomList = roomDAO.fetchRooms(checkinDate,checkoutDate);
		request.setAttribute("roomList", roomList);
		request.setAttribute("custId", custId);
		request.setAttribute("checkindate", checkinDate);
		request.setAttribute("checkoutdate", checkoutDate);
		
		if("reception".equals(request.getParameter("action"))) {
			RequestDispatcher rs = request.getRequestDispatcher("receptionofflinebooking.jsp");
			rs.forward(request, response);
		}
		else {
			RequestDispatcher rs = request.getRequestDispatcher("bookroom.jsp");
			rs.forward(request, response);
		}
	}
	
	public void fetchAllRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Rooms> allRooms = new ArrayList<>();
		allRooms = roomDAO.fetchAllRooms();
		
		if("statusupdated".equals(request.getParameter("action1"))) {
			request.setAttribute("updateStatus", "roomUpdateSuccess");
		}
		
		request.setAttribute("allrooms", allRooms);
		request.getRequestDispatcher("manager.jsp").forward(request, response);
	}
}
