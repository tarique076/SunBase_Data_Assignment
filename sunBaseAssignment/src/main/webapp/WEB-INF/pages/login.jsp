<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style type="text/css">

	body{
		margin: auto;
		display: flex;
		justify-content: center;
	}
	.container{
		width: 40%;
		display: flex;
		flex-direction: column;
		align-items: center;
		text-align: center;
	}
	input {
		width: 90%;
		margin-bottom: 20px;
		padding: 5px
    }
    #button {
		width: 40%;
		padding: 5px;
		margin: auto;
	}
</style>
</head>
<body>
	<div class="container">
		
		<%  
		 if( request.getAttribute("statusCode") != null ){ 
		 	if((int)request.getAttribute("statusCode") != 200){
		 %>
		 	<form method="post">
				<h1>Login Page</h1>
				<input id="loginId" name="loginId" type="text" placeholder="Login Id" required>
				<input id="password" name="password" type="password" placeholder="Password" required>
				<h3>${Error}</h3>
				<input id="button" type="submit" value="Submit">
			</form>
			<% } else { %>
				<h3>Logged in successfully!</h3>
				<div>
					<a href="${baseUrl}/customer_list" style="text-decoration: none">
						<button>View Customers</button>
					</a>
					<a  href="${baseUrl}/add_customer" style="text-decoration: none">
						<button>Add Customers</button>
					</a> 
				</div>
			<% } %>
		 <% }else{ %>
			 <form method="post">			 
			 	<h1>Login Page</h1>
				<input id="loginId" name="loginId" type="text" placeholder="Login Id" required>
				<input id="password" name="password" type="password" placeholder="Password" required>
				<input id="button" type="submit" value="Submit">
			 </form>
		 	
		 <% } %>
		
	</div>
</body>
</html>