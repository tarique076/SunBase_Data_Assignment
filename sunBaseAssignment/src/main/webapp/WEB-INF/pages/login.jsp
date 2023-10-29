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
		<form method="post">
			<h1>Login Page</h1>
			<input id="loginId" name="loginId" type="text" placeholder="Login Id" required>
			<input id="password" name="password" type="password" placeholder="Password" required>
			<h3>${Error}</h3>
			<input id="button" type="submit" value="Submit">
		</form>
	</div>
</body>
</html>