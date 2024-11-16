<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,com.model.Booking" %>
<%
    boolean isSaved = false;
    if("saved".equals(request.getAttribute("savedfb"))){
        isSaved = true;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Feedback Bookings</title>
    <style>
        /* Scoped styling for feedback page */
        #feedback-page {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }

        #feedback-page h2 {
            text-align: center;
            color: #0077b6;
        }

        #feedback-page .card {
            border: 1px solid #ccc;
            padding: 16px;
            margin: 16px 0;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 300px;
            background-color: #fff;
        }

        #feedback-page .card h3 {
            margin: 0;
            font-size: 20px;
            color: #0077b6;
        }

        #feedback-page .card p {
            margin: 8px 0;
            font-size: 16px;
        }

        #feedback-page .card .feedback-form {
            display: none; /* Initially hidden */
            margin-top: 12px;
            padding: 16px;
            border-top: 1px solid #ccc;
            background-color: #f9f9f9;
        }

        #feedback-page .feedback-form label {
            display: block;
            margin: 8px 0 4px;
            font-size: 14px;
        }

        #feedback-page .feedback-form input[type="text"],
        #feedback-page .feedback-form input[type="range"] {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            margin-bottom: 12px;
        }

        #feedback-page .feedback-form button {
            padding: 8px 16px;
            font-size: 14px;
            background-color: #0077b6;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #feedback-page .feedback-form button:hover {
            background-color: #005f8c;
        }

        #feedback-page .feedback-form .rating-display {
            font-size: 14px;
            margin-left: 8px;
            color: #0077b6;
        }

        #feedback-page .go-home-button {
            display: inline-block;
            background-color: #d4af37; /* Gold background */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s, transform 0.2s;
            position: fixed;
            bottom: 20px;
            left: 43%;
        }

        #feedback-page .go-home-button:hover {
            background-color: #c19a28;
            transform: scale(1.05);
        }
    </style>
    <script>
        function showFeedbackForm(bookingId) {
            var feedbackForm = document.getElementById("feedback-form-" + bookingId);
            feedbackForm.style.display = "block";
        }

        function updateRatingDisplay(bookingId) {
            var ratingValue = document.getElementById("rating-" + bookingId).value;
            document.getElementById("rating-display-" + bookingId).textContent = ratingValue;
        }
    </script>
</head>
<body>

<div id="feedback-page">
    <%
        if(isSaved) {
    %>
        <script type="text/javascript">
                var custId = "<%= request.getAttribute("custId")%>";
                alert("The Feedback was submitted successfully.");
                window.location.href = "FeedbackController?custId=" + encodeURIComponent(custId);
        </script>
    <%
        }
    %>
    <h2>Feedback Pending Bookings</h2>

    <%
        // Retrieve the list of bookings pending feedback from the request attribute
        List<Booking> fbPendingBookings = (List<Booking>) request.getAttribute("fbpendingbookings");

        if (fbPendingBookings != null && !fbPendingBookings.isEmpty()) {
            for (Booking booking : fbPendingBookings) {
    %>
                <div class="card">
                    <h3>Booking Details</h3>
                    <p><strong>Customer ID:</strong> <%= booking.getCustId() %></p>
                    <p><strong>Booking ID:</strong> <%= booking.getBookingId() %></p>
                    <p><strong>Room ID:</strong> <%= booking.getRoomId() %></p>
                    <p><strong>Check-in Date:</strong> <%= booking.getCheckinDate() %></p>
                    <p><strong>Check-out Date:</strong> <%= booking.getCheckoutDate() %></p>

                    <!-- Submit Feedback Button -->
                    <button type="button" onclick="showFeedbackForm(<%= booking.getBookingId() %>)">Submit Feedback</button>

                    <!-- Hidden Feedback Form -->
                    <div class="feedback-form" id="feedback-form-<%= booking.getBookingId() %>">
                        <form action="FeedbackController" method="post">
                            <label for="feedbackText">Feedback Text:</label>
                            <input type="text" name="feedbackText" id="feedbackText" required>
                            
                            <label for="rating">Rating (1 to 5):</label>
                            <input 
                                type="range" 
                                name="rating" 
                                id="rating-<%= booking.getBookingId() %>" 
                                min="1" 
                                max="5" 
                                value="3" 
                                oninput="updateRatingDisplay(<%= booking.getBookingId() %>)" 
                                required
                            >
                            <span class="rating-display" id="rating-display-<%= booking.getBookingId() %>">3</span>
                            
                            <input type="hidden" name="custId" value="<%= booking.getCustId() %>">
                            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                            
                            <button type="submit">Submit</button>
                        </form>
                    </div>
                </div>
    <%
            }
        } else {
    %>
        <p>No feedback bookings pending.</p>
    <%
        }
    %>
    <div style="text-align: center; margin-top: 20px;">
        <a href="BookingController?action=login" class="go-home-button">Go to Home Page</a>
    </div>
</div>
</body>
</html>
