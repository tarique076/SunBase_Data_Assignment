<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
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
body{
	background-color: #768bfa;
	font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS',
		sans-serif;
	cursor: default;
}
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
  margin: 5% auto;
  padding: 20px;
  border: 1px solid #888;
  width: max-content;
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

#table_data{
  width: 100%;
  text-align: left;
  background-color: #d7dde0;
  border-collapse: collapse;
  table-layout: fixed;
}

th{
  padding: 10px;
  border-bottom: 2px solid;
}

td{
  padding: 10px;
  white-space: nowrap;     /* Prevent text from wrapping */
  overflow: hidden;        /* Hide any overflowing content */
  text-overflow: ellipsis;
}

#head_con{
	margin: 0px 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
#heading{
	text-align: center;
}

button {
	padding: 10px;
	border: 2px solid #303131;
	font-weight: bold;
	cursor: pointer;
	border-radius: 5%;
	background-color: #151d47;
	color: white;
	cursor: pointer;
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
</style>
<body>
	<div id="head_con">
		<h1 id="heading">Customer List</h1>
		<%
		if (request.getAttribute("statusCode") != null && (int) request.getAttribute("statusCode") == 200) {
		%>
		<a href="${baseUrl}/add_customer" style="text-decoration: none">
			<button>Add Customers</button>
		</a>
	</div>
	<table id="table_data">
		<thead>
			<tr>
				<th style="width: 8%">First Name</th>
				<th style="width: 8%">Last Name</th>
				<th style="width: 15%">Address</th>
				<th style="width: 15%">Street</th>
				<th style="width: 8%">City</th>
				<th style="width: 8%">State</th>
				<th style="width: 15%">Email</th>
				<th style="width: 8%">Phone</th>
				<th style="width: 5%">Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			List<Map<String, Object>> resMap = (List<Map<String, Object>>) request.getAttribute("response");
			/* System.out.println(resMap); */
			for (Map<String, Object> map : resMap) {
			%>
			<tr>
				<td title="<%=map.get("first_name")%>"><%=map.get("first_name")%></td>
				<td title="<%=map.get("last_name")%>"><%=map.get("last_name")%></td>
				<td title="<%=map.get("address")%>"><%=map.get("address")%></td>
				<td title="<%=map.get("street")%>"><%=map.get("street")%></td>
				<td title="<%=map.get("city")%>"><%=map.get("city")%></td>
				<td title="<%=map.get("state")%>"><%=map.get("state")%></td>
				<td title="<%=map.get("email")%>"><%=map.get("email")%></td>
				<td title="<%=map.get("phone")%>"><%=map.get("phone")%></td>
				<td><i title="Delete" style="cursor: pointer;" class="fa-solid fa-trash" class="openDelModalButton"
					onclick="openDelModal('<%=map.get("uuid")%>')"></i> <i
					title="Update" class="fa-regular fa-pen-to-square" class="openUpdateModalButton"
					style="cursor: pointer;" onclick="openUpdateModal('<%=map.get("uuid")%>','<%=map.get("first_name")%>','<%=map.get("last_name")%>', '<%=map.get("address")%>', '<%=map.get("city")%>', '<%=map.get("state")%>', '<%=map.get("street")%>','<%=map.get("phone")%>','<%=map.get("email")%>')"></i></td>
			</tr>
			<%
			}
			%>
		</tbody>
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
			<h3>Are you sure you want to delete this customer?</h3>
			<button onclick="delCustomer()">Delete</button>
		</div>
	</div>
	
	<div id="updateModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span> <br>
			<p>Please change the fields you want to update!</p>
			<div class="input_flex">
				<div class="input_flex_first_item">
					<label for="fname">First Name</label> <br> <input type="text"
						placeholder="Enter First Name." name="fname" id="fname" required value="">
				</div>
				<div class="input_flex_second_item">
					<label for="lname">Last Name</label> <br> <input type="text"
						placeholder="Enter Last Name." name="lname" id="lname" required value="">
				</div>
			</div>
			<div class="input_flex">
				<div class="input_flex_first_item">
					<label for="street">Street</label> <br> <input type="text"
						placeholder="Enter Street" name="street" id="street" value="">
				</div>
				<div class="input_flex_second_item">
					<label for="address">Address</label> <br> <input type="text"
						placeholder="Enter Address." name="address" id="address" value="">
				</div>
			</div>
			<div class="input_flex">
				<div class="input_flex_first_item">
					<label for="city">City</label> <br> <input type="text"
						placeholder="Enter City." name="city" id="city" value="">
				</div>
				<div class="input_flex_second_item">
					<label for="state">State</label> <br> <input type="text"
						placeholder="Enter State" name="state" id="state" value="">
				</div>
			</div>
			<div class="input_flex">
				<div class="input_flex_first_item">
					<label for="email">Email</label> <br> <input type="text"
						placeholder="Enter Email" name="email" id="email" value="">
				</div>
				<div class="input_flex_second_item">
					<label for="phone">Phone</label> <br> <input type="number"
						placeholder="Enter Phone" name="phone" id="phone" maxlength="10" minlength="10" value="">
				</div>
			</div>
			<button id="updateDetails" onclick="updateCustDetails()" >Update</button>
		</div>
	</div>
	
	<div id="delSuccessModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeDelSuccModal()">&times;</span>
			<p id="succMsg"></p>
			<button onclick="closeDelSuccModal()">Ok</button>
		</div>
	</div>


	<script type="text/javascript">
	
	const delModal = document.getElementById("delModal");
	const updateModal = document.getElementById("updateModal");
	const openDelModalButton = document.querySelectorAll(".openDelModalButton");
	const openUpdateModalButton = document.querySelectorAll(".openUpdateModalButton");
	const delSuccModal = document.getElementById("delSuccessModal");
	
	const fname_inp = document.getElementById("fname");
	const lname_inp = document.getElementById("lname");
	const add_inp = document.getElementById("address");
	const city_inp = document.getElementById("city");
	const state_inp = document.getElementById("state");
	const street_inp = document.getElementById("street");
	const phone_inp = document.getElementById("phone");
	const email_inp = document.getElementById("email");
	
	const success_msg_el = document.getElementById("succMsg");
	
	function openDelModal(uuid_val) {
	  uuid = uuid_val;
	  console.log(uuid);
	  delModal.style.display = "block";
	}
	
	function openUpdateModal(uuid_val,first_name,last_name,address,city,state,street,phone,email) {
		uuid = uuid_val;
		console.log(uuid);
		
		fname_inp.value = first_name;
		lname_inp.value = last_name;
		add_inp.value = address;
		city_inp.value = city;
		state_inp.value = state;
		street_inp.value = street;
		phone_inp.value = phone;
		email_inp.value = email;
		updateModal.style.display = "block";
	}
	
	function closeModal() {
	  delModal.style.display = "none";
	  updateModal.style.display = "none";
	}

	function closeDelSuccModal() {
		  delSuccModal.style.display = "none";
		  window.location.reload();
	}
	
	function delCustomer(){
		const apiUrl = "http://localhost:8092/delete_customer?uuid="+uuid;
		const requestOptions = {
		  method: "DELETE",
		};

		fetch(apiUrl, requestOptions)
		  .then((response) => {
			  if (!response.ok) {
			        return response.text().then((text) => {
			          throw new Error(`Error: ${response} - ${text}`);
			        });
			      }
			      return response;
		  })
		  .then((data) => {
		    console.log("Resource deleted:", data);
		    success_msg_el.textContent = "Customer deleted successfully!"
		    delSuccModal.style.display = "block";
		  })
		  .catch((error) => {
		    success_msg_el.textContent = "Delete request failed." ;
		    delSuccModal.style.display = "block";
		  });
	}
	
	function updateCustDetails(){
		let fname = document.getElementById("fname").value;
		let lname = document.getElementById("lname").value;
		let add = document.getElementById("address").value;
		let city = document.getElementById("city").value;
		let state = document.getElementById("state").value;
		let street = document.getElementById("street").value;
		let phone = document.getElementById("phone").value;
		let email = document.getElementById("email").value;
		
		const apiUrl = "http://localhost:8092/update_customer?uuid="+uuid+"&first_name="+fname+"&last_name="+lname+"&address="+add+"&city="+city+"&state="+state+"&street="+street+"&phone="+phone+"&email="+email;
		const requestOptions = {
		  method: "PUT",
		};

		fetch(apiUrl, requestOptions)
		  .then((response) => {
			  if (!response.ok) {
			        return response.text().then((text) => {
			          throw new Error(`Error: ${response} - ${text}`);
			        });
			      }
			      return response;
		  })
		  .then((data) => {
		    console.log("Resource updates:", data);
		    success_msg_el.textContent = "Customer updated successfully!"
		    delSuccModal.style.display = "block";
		  })
		  .catch((error) => {
		    success_msg_el.textContent = "Update request failed!"
		    delSuccModal.style.display = "block";
		  });
	}
	
	window.addEventListener("click", (event) => {
	  if (event.target === delModal || event.target === updateModal) {
	    closeModal();
	  }
	  if(event.target === delSuccModal){
		  window.location.reload();
	  }
	});

	</script>
</body>
</html>