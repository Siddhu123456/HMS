package com.controler;


import com.DAO.LoginDAO;
import com.model.Customer;
import DBConnect.DBconnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    private LoginDAO LoginDAO;
    private Connection connection;
    

    @Override
    public void init() throws ServletException {
        // Initialize database connection and DAO
        try {
            this.connection = DBconnection.getConnection();
            this.LoginDAO = new LoginDAO(connection);
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "signup":
                    signUp(request, response);
                    break;
                case "login":
                    login(request, response);
                    break;
                case "logout":
                    logout(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void signUp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String phoneNo = request.getParameter("phone_no");
        
             
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
        	System.out.println(password);
        	System.out.println(confirmPassword);
            request.setAttribute("errorMessage", "Passwords do not match.");
            forwardToSignUp(request, response);
            return;
        }

        // Create a new Customer
        Customer customer = new Customer(0, name, email, password, phoneNo);

        // Attempt to sign up the customer using LoginDAO
        boolean isSignedUp = LoginDAO.signUp(customer);
        if (isSignedUp) {
            response.sendRedirect("login.jsp");
        } else {
           request.setAttribute("errorMsg", "SignUp failed enter the correct details.");
           forwardToSignUp(request,response);
        }
    }

    // Utility method for forwarding to signup.jsp with error messages
    private void forwardToSignUp(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }


    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String user = request.getParameter("userRole");
        
        if ("Receptionist".equals(user)) {
        	if(email.equals("reception@gmail.com") && password.equals("reception")) {
        		//request.setAttribute("action", "receptionist");
        		response.sendRedirect("receptionist.jsp");
        	}
        	else {
        		request.setAttribute("errorMsg", "SignUp failed enter the correct details.");
        		request.getRequestDispatcher("login.jsp").forward(request, response);
        	}
        }
        
        else if ("Food Manager".equals(user)) {
        	if(email.equals("foodmanager@gmail.com") && password.equals("foodmanager")) {
        		String action = "foodmanager";
        		response.sendRedirect("FoodManagerController?action="+action);
        	}
        	else {
        		request.setAttribute("errorMsg", "SignUp failed enter the correct details.");
        		request.getRequestDispatcher("login.jsp").forward(request, response);
        	}
        }
        
        else if ("Manager".equals(user)) {
        	if(email.equals("manager@gmail.com") && password.equals("manager")) {
        		response.sendRedirect("RoomsController?action=manager");
        	}
        	else {
        		request.setAttribute("errorMsg", "SignUp failed enter the correct details.");
        		request.getRequestDispatcher("login.jsp").forward(request, response);
        	}
        }
        
        else {
        	Customer customer = LoginDAO.login(email, password);

            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                String action = "login";
                response.sendRedirect("BookingController?action="+action); // Redirect to a dashboard page
            } else {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
        
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp"); // Redirect to the homepage or login page
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
