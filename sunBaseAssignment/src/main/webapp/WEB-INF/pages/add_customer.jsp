<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Add Customer</h1>
	<%
	if (request.getAttribute("statusCode") != null && (int) request.getAttribute("statusCode") == 201) {
	%>
	<h3>${response}</h3>
	<div>
		<a href="${baseUrl}/customer_list" style="text-decoration: none">
			<button>View Customers</button>
		</a> <a href="${baseUrl}/add_customer" style="text-decoration: none">
			<button>Add more Customers</button>
		</a>
	</div>
	<%
	} else{
	%>
	<form method="post">
		<div class="input_flex">
			<div class="input_flex_first_item">
				<label for="fname">First Name</label> <br> <input type="text"
					placeholder="Enter First Name." name="fname" id="fname" required>
			</div>
			<div class="input_flex_second_item">
				<label for="lname">Last Name</label> <br> <input type="text"
					placeholder="Enter Last Name." name="lname" id="lname" required>
			</div>
		</div>
		<div class="input_flex">
			<div class="input_flex_first_item">
				<label for="street">Street</label> <br> <input type="text"
					placeholder="Enter Street" name="street" id="fname" >
			</div>
			<div class="input_flex_second_item">
				<label for="address">Address</label> <br> <input type="text"
					placeholder="Enter Address." name="address" id="lname" >
			</div>
		</div>
		<div class="input_flex">
			<div class="input_flex_first_item">
				<label for="city">City</label> <br> <input type="text"
					placeholder="Enter City." name="city" id="fname" >
			</div>
			<div class="input_flex_second_item">
				<label for="state">State</label> <br> <input type="text"
					placeholder="Enter State" name="state" id="lname" >
			</div>
		</div>
		<div class="input_flex">
			<div class="input_flex_first_item">
				<label for="email">Email</label> <br> <input type="text"
					placeholder="Enter Email" name="email" id="fname" >
			</div>
			<div class="input_flex_second_item">
				<label for="phone">Phone</label> <br> <input type="text"
					placeholder="Enter Phone" name="phone" id="lname" >
			</div>
		</div>
		<input id="button" type="submit" value="Submit">

	</form>
	<% } %>
</body>
</html>