<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="ReceptionistpayController">paymentdetails</a>
	<form action="FeedbackController" method="post">
		<input type="number" name="customerId">
		<input type="submit">
	</form>
	<a href="OfflineBookingController">offline bookings</a>
	<a href="FoodManagerController">foodmenu</a>
	<a href="RoomsController?action=manager">manager</a>
	<a href="FeedbackController?custId=5">feedbackpending</a>
	<img src="https://t4.ftcdn.net/jpg/05/92/15/83/240_F_592158329_RSHGeLJzx8O3vH5vpWltV01nBvyz8TmL.jpg">
</body>
</html>