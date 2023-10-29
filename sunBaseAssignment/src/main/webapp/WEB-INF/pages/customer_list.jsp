<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer List</title>
</head>
<body>
<h1>Customer List</h1>

	<table>
	  <tr>
	    <th>First Name</th>
	    <th>Last Name</th>
	    <th>Address </th>
	    <th>City</th>
	    <th>State</th>
	    <th>Email</th>
	    <th>Phone</th>
	    <th>Action</th>
	  </tr>
	  	<% List<Map<String, Object>> resMap = (List<Map<String,Object>>) request.getAttribute("response"); 
	  	System.out.println(resMap);
	  	%>
	  	<tr>
	  		<th>${customer.first_name}</th>
		    <th>Last Name</th>
		    <th>Address </th>
		    <th>City</th>
		    <th>State</th>
		    <th>Email</th>
		    <th>Phone</th>
		    <th>Action</th>
	  	</tr>
	</table>
	
	<h3>${response}</h3>
</body>
</html>