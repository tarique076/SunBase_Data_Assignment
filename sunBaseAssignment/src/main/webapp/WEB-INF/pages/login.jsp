<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style type="text/css">
body {
	background-color: #768bfa;
	font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS',
		sans-serif;
	margin: auto;
	display: flex;
	justify-content: center;
}

.container {
	margin-top: 40px; background-color : #f5f4ff;
	padding: 20px;
	border-radius: 10px;
	width: 40%;
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	background-color: #f5f4ff;
}

input {
	width: 90%;
	margin-bottom: 20px;
	padding: 8px;
	font-size: 15px; border-radius : 5px; width : 90%; border : 2px solid
	black;
	margin-top: 4px;
	border-radius: 5px;
	width: 90%;
	border: 2px solid black;
}

#button {
	width: 40%;
	padding: 5px;
	margin: auto;
	background-color: #151d47;
	color: white;
	cursor: pointer;
}

button {
	padding: 8px;
	font-size: 15px;
	border-radius: 5px;
	margin-bottom: 10px;
	background-color: #151d47;
	color: white;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		
		<%  
		 if( request.getAttribute("statusCode") != null && (int)request.getAttribute("statusCode") == 200){ 
		 %>
				<h3>Logged in successfully!</h3>
				<div>
					<a href="${baseUrl}/customer_list" style="text-decoration: none">
						<button>View Customers</button>
					</a>
					<a  href="${baseUrl}/add_customer" style="text-decoration: none">
						<button>Add Customers</button>
					</a> 
				</div>
			<% } else { %>
		 	<form method="post">
				<h1>Login</h1>
				<input id="loginId" name="loginId" type="text" placeholder="Login Id" required>
				<input id="password" name="password" type="password" placeholder="Password" required>
				<h3>${Error}</h3>
				<input id="button" type="submit" value="Login">
			</form>
			<% } %>
		
	</div>
</body>
</html>