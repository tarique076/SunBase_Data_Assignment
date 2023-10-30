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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://kit.fontawesome.com/87218ca82a.js" crossorigin="anonymous"></script>

<style>
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.7);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover {
  color: black;
}

</style>
<body>
<h1>Customer List</h1>

<% if( request.getAttribute("statusCode")!=null && (int)request.getAttribute("statusCode")==200){ %>
	<a href="${baseUrl}/add_customer" style="text-decoration: none">
		<button>Add Customers</button>
	</a>
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
		    <td><i class="fa-solid fa-trash" id="openDelModalButton"></i> <i class="fa-regular fa-pen-to-square" id="openUpdateModalButton"></i></td>
	  	</tr>
	  	<% } %>
	</table>
	<% } else{ %>
	<h3>${response}Please Login!</h3>
	<a href="${baseUrl}/login" style="text-decoration: none">
		<button>Login</button>
	</a>
	<%
	}
	%>
	<div id="delModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<p>Modal content goes here.</p>
		</div>
	</div>
	
	<div id="updateModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<p>Modal content goes here.</p>
		</div>
	</div>


	<script type="text/javascript">
	// Get the modal and open button elements
	const delModal = document.getElementById("delModal");
	const updateModal = document.getElementById("updateModal");
	const openDelModalButton = document.getElementById("openDelModalButton");
	const openUpdateModalButton = document.getElementById("openUpdateModalButton");

	// Function to open the modal
	function openDelModal() {
	  delModal.style.display = "block";
	}
	
	function openUpdateModal() {
		  updateModal.style.display = "block";
		}
	
	// Function to close the modal
	function closeModal() {
	  delModal.style.display = "none";
	  updateModal.style.display = "none";
	}

	// Event listener to open the modal when the open button is clicked
	openDelModalButton.addEventListener("click", openDelModal);
	openUpdateModalButton.addEventListener("click", openUpdateModal);

	// Event listener to close the modal when the close button (×) is clicked
	modal.querySelector(".close").addEventListener("click", closeModal);

	// Event listener to close the modal when clicking outside of the modal content
	window.addEventListener("click", (event) => {
	  if (event.target === delModal) {
	    closeModal();
	  }
	});

	</script>
</body>
</html>