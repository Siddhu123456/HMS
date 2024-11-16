package com.controler;

import com.DAO.ReceptionistPayDAO;
import com.model.Booking;

import DBConnect.DBconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ReceptionistpayController")
public class ReceptionistpayController extends HttpServlet {
    private ReceptionistPayDAO receptionistPayDAO;
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            connection = DBconnection.getConnection();
            receptionistPayDAO = new ReceptionistPayDAO(connection);
        } catch (Exception e) {
            throw new ServletException("Failed to connect to database", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve all bookings with details from DAO
            List<Booking> bookings = receptionistPayDAO.getAllBookingsWithDetails();
            
            if("payed".equals(request.getParameter("action"))) {
    			request.setAttribute("payed", "payed");
    		}
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("receptionistpay.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving booking details", e);
        }
    }

    @Override
    public void destroy() {
        // Close the database connection if necessary
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
