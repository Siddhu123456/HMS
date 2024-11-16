<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	boolean isSignedup = false;
	if("signup".equals(request.getParameter("action"))) {
		isSignedup = true;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        /* Basic reset */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f2f5;
            flex-direction: column;
        }

        h1 {
            color: goldenrod;
            font-size: 2em;
            margin-bottom: 0.5em;
            font-weight: bold;
            text-align: center;
        }

        h2 {
            text-align: center;
            color: goldenrod;
            margin-bottom: 1em;
        }

        form {
            width: 100%;
            max-width: 400px;
            padding: 2em;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            background-color: #ffffff;
        }

        label {
            display: block;
            margin-bottom: 0.5em;
            color: #333;
            font-weight: bold;
        }

        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 0.8em;
            margin-bottom: 1.2em;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fafafa;
            transition: border-color 0.3s;
        }

        input[type="email"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #3b82f6;
            outline: none;
        }

        button {
            width: 100%;
            padding: 0.8em;
            background-color: #808080; /* Changed to grey */
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #606060; /* Darker grey on hover */
        }

        .error {
            color: #f44336;
            font-size: 0.9em;
            text-align: center;
            margin-top: 1em;
        }

        p {
            text-align: center;
            margin-top: 1em;
            color: #555;
        }

        a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<%
		if(isSignedup) {	
	%>
		<script type="text/javascript">
			alert("Your SignUp was successfull login to continue with the page.");
			window.location.href = "index.jsp";
		</script>
	<%
		}
	%>
    <h1>Blissful Haven</h1>
    <form action="LoginController" method="post">
        <h2>Login</h2>
        
        <input type="hidden" name="action" value="login">
        
        <label for="userRole">Select the user:</label>
        <select id="userRole" name="userRole" required>
            <option value="Customer">Customer</option>
            <option value="Receptionist">Receptionist</option>
            <option value="Food Manager">Food Manager</option>
            <option value="Manager">Manager</option>
        </select>
        
        <input type="hidden" name="action" value="login"/>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        
        <button type="submit">Login</button>
        
        <% String errorMessage = (String) request.getAttribute("errorMessage");
           if (errorMessage != null && !errorMessage.isEmpty()) { %>
               <div class="error"><%= errorMessage %></div>
        <% } %>

        <p>Don't have an account? <a href="signup.jsp">Sign up here</a>.</p>
    </form>
</body>
</html>
