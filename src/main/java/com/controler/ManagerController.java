package com.controler;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.DAO.ManagerBillHistoryDAO;
import com.model.Billing;

import DBConnect.DBconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ManagerController")
public class ManagerController extends HttpServlet{
	
	private Connection connection;
	private ManagerBillHistoryDAO billhistory;
	
	public void init() {
		try {
			this.connection = DBconnection.getConnection();
			this.billhistory = new ManagerBillHistoryDAO(connection);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		List<Billing> billHistory = new ArrayList<>();
		billHistory = billhistory.fetchBillHistory();
		
		request.setAttribute("billhistory", billHistory);
		request.getRequestDispatcher("viewbillhistory.jsp").forward(request, response);
	}
}
