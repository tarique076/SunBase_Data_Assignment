<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	  	/* System.out.println(resMap); */
	  	for(Map<String, Object> map : resMap){
	  	%>
	  	<tr>
	  		<td><%= map.get("first_name") %></td>
		    <td><%= map.get("last_name") %></td>
		    <td><%= map.get("address") %> </td>
		    <td><%= map.get("city") %></td>
		    <td><%= map.get("state") %></td>
		    <td><%= map.get("email") %></td>
		    <td><%= map.get("phone") %></td>
		    <td>Action</td>
	  	</tr>
	  	<% } %>
	</table>
</body>
</html>