<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.model.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Feedback</title>
    <style>
        /* Scoped styles for feedback display page */
        #feedback-page {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            padding: 40px;
            text-align: center;
        }

        #feedback-page h2 {
            color: #1a73e8;
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        /* Enhanced Card styling */
        .feedback-card {
            display: inline-block;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            width: 320px;
            margin: 20px;
            padding: 25px;
            text-align: left;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-top: 5px solid #1a73e8;
        }

        .feedback-card:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
        }

        .feedback-card h3 {
            font-size: 20px;
            color: #333;
            font-weight: bold;
            margin: 0 0 12px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 8px;
        }

        .feedback-card p {
            font-size: 15px;
            color: #555;
            margin: 8px 0;
            line-height: 1.6;
        }

        .feedback-card .detail-label {
            font-weight: bold;
            color: #555;
        }

        .feedback-card .rating {
            font-weight: bold;
            color: #ff9800;
            font-size: 18px;
        }

        /* Button styling */
        .go-home-button {
            display: inline-block;
            background-color: #d4af37;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 30px;
        }

        .go-home-button:hover {
            background-color: #c19a28;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div id="feedback-page">
    <h2>Customer Feedback</h2>

    <%
        // Retrieve the list of feedback from the request attribute
        List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbacks");

        if (feedbackList != null && !feedbackList.isEmpty()) {
            for (Feedback feedback : feedbackList) {
    %>
                <div class="feedback-card">
                    <h3>Feedback for Booking ID: <%= feedback.getBookingId() %></h3>
                    <p><span class="detail-label">Feedback ID:</span> <%= feedback.getFeedbackId() %></p>
                    <p><span class="detail-label">Customer ID:</span> <%= feedback.getCustId() %></p>
                    <p><span class="detail-label">Submitted Date:</span> <%= feedback.getGivenDate() %></p>
                    <p><span class="detail-label">Feedback:</span> <%= feedback.getFeedbackText() %></p>
                    <p><span class="detail-label">Rating:</span> <span class="rating"><%= feedback.getRating() %>/5</span></p>
                </div>
    <%
            }
        } else {
    %>
        <p>No feedback available at this time.</p>
    <%
        }
    %>

    <a href="receptionist.jsp" class="go-home-button">Go to Home Page</a>
</div>

</body>
</html>
