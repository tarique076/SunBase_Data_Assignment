<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
body {
	background-color: #768bfa;
	font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS',
		sans-serif;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
	margin: 0;
}

#form_container {
	background-color: #f5f4ff;
	max-width: 100%;
	padding: 20px;
	border-radius: 10px;
}

.input_flex {
	display: flex;
	justify-content: space-around;
	margin-bottom: 15px;
	gap: 15px;
}

input {
	padding: 8px;
	font-size: 15px;
	border-radius: 5px;
	width: 90%;
	border: 2px solid black;
	margin-top: 4px;
}

#button, button {
	width: 40%;
	margin-left: 25%;
	background-color: #151d47;
	color: white;
	cursor: pointer;
}

#success_con{
	width: 30%;
	display: flex;
	flex-direction: column;
	background-color: #f5f4ff;
	padding: 20px;
	border-radius: 10px;
}

#created_success{
	display: flex;
	justify-content: flex-start;
}
.post_success_button{
	width: 100%;
	padding: 8px;
	font-size: 15px;
	border-radius: 5px;
	margin-bottom: 10px;
}
#form_head{
	display: flex;
	align-items: center;
	justify-content: space-around;
}
#back_customers{
	position: absolute;
	top: 0;
	right: 0;
	width: 10%;
}
</style>
</head>
<body>
	<%
	if (request.getAttribute("statusCode") != null && (int) request.getAttribute("statusCode") == 201) {
	%>
	<div id="success_con">
		<h3>${response}</h3>
		<div id="created_success">
			<a href="${baseUrl}/customer_list" style="text-decoration: none">
				<button class="post_success_button">View Customers</button>
			</a> <a href="${baseUrl}/add_customer" style="text-decoration: none">
				<button class="post_success_button">Add more Customers</button>
			</a>
		</div>
	</div>
	<%
	} else{
	%>
	<a href="${baseUrl}/customer_list" style="text-decoration: none">
		<button class="post_success_button" id="back_customers">View
			Customers</button>
	</a>
	<form method="post">
	<div id="form_head">
		<h1>Add Customer</h1>
	</div>
	<div id="form_container">
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
	</div>

	</form>
	<% } %>
</body>
</html>