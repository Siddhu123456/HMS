<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        /* Basic reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f2f2f2;
            flex-direction: column;
        }

        /* Hotel heading styling */
        h1 {
            color: goldenrod;
            font-size: 2em;
            margin-bottom: 0.5em;
            font-weight: bold;
            text-align: center;
        }

        /* Form container styling */
        .form-container {
            width: 100%;
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* Heading */
        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        /* Label and Input styling */
        label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
            text-align: left;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 1em;
        }

        /* Button styling */
        button {
            width: 100%;
            padding: 10px;
            background-color: grey;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1em;
            cursor: pointer;
        }

        button:hover {
            background-color: #606060; /* Darker grey on hover */
        }

        /* Error message styling */
        .error {
            color: red;
            font-size: 0.9em;
            margin-top: 10px;
        }

        /* Signup link styling */
        p {
            margin-top: 20px;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Blissful Haven</h1>
    <div class="form-container">
        <h2>Sign Up</h2>
        <form action="LoginController" method="post">
            <input type="hidden" name="action" value="signup">
            
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <% String errorMessage = (String)request.getAttribute("errorMessage");     
               if(errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="error"><%= errorMessage %></div>
            <% } %>
            
            <label for="confirm_password">Confirm Password:</label>
            <input type="password" id="confirm_password" name="confirm_password" required>
            
            <label for="phone_no">Phone No:</label>
            <input type="text" id="phone_no" name="phone_no">
            
            <% String errorMsg = (String)request.getAttribute("errorMsg");     
               if(errorMsg != null && !errorMsg.isEmpty()) { %>
                <div class="error"><%= errorMsg %></div>
            <% } %>
            <button type="submit">Sign Up</button>
        </form>

        <!-- Link to Login Page -->
        <p>Already have an account? <a href="index.jsp">Log in here</a>.</p>
    </div>
</body>
</html>
