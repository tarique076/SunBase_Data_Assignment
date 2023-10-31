package com.sunBase.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

@Controller
public class UIController {

	@Value("${base.url}")
	private String baseUrl;
	
	private String token;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String loginStatus(Model model, @RequestParam String loginId, @RequestParam String password) {

		// Set the base URI
		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment_auth.jsp"; 

		// JSON request body
		String jsonRequestBody = "{\r\n" + "\"login_id\" : \"" + loginId + "\",\r\n" + "\"password\" :\"" + password
				+ "\"\r\n" + "}";

		// Send a POST request
		Response response = RestAssured.given().contentType(ContentType.JSON).body(jsonRequestBody).when().post(); // path

		if (response.getStatusCode() == 200) {
			JsonPath jsonPath = response.jsonPath();
			Map<String, Object> responseBodyMap = jsonPath.getMap("");

			// Now you can work with the responseBodyMap
			token = (String) responseBodyMap.get("access_token");
			model.addAttribute("token", token);
			model.addAttribute("statusCode", response.getStatusCode());
			return "login";
		} else {
			token = response.getBody().asString();
			model.addAttribute("Error", token);
			model.addAttribute("statusCode", response.getStatusCode());
			return "login";
		}

	}

	@GetMapping("/customer_list")
	public String customerList(Model model) {

		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		Response response = RestAssured.given().param("cmd", "get_customer_list")
				.headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().get();

		if (response.getStatusCode() == 200) {

			JsonPath jsonPath = new JsonPath(response.getBody().asString());

			List<Map<String, Object>> mapList = jsonPath.getList("$");
			model.addAttribute("statusCode", response.getStatusCode());
			model.addAttribute("response", mapList);
			return "customer_list";
		} else {
			model.addAttribute("statusCode", response.getStatusCode());
			model.addAttribute("response", response.getBody().asString());
			return "customer_list";
		}
	}

	@GetMapping("/add_customer")
	public String addCustomer() {
		return "add_customer";
	}

	@PostMapping("/add_customer")
	public String addNewCustomer(Model model, @RequestParam String fname, @RequestParam String lname,
			@RequestParam String address, @RequestParam String state, @RequestParam String city,
			@RequestParam String email, @RequestParam String phone, @RequestParam String street) {

		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		String requestBody = "{\r\n"
				+ "\"first_name\": \""+fname+"\",\r\n"
				+ "\"last_name\": \""+lname+"\",\r\n"
				+ "\"street\": \""+street+"\",\r\n"
				+ "\"address\": \""+address+" \",\r\n"
				+ "\"city\": \""+city+"\",\r\n"
				+ "\"state\": \""+state+"\",\r\n"
				+ "\"email\": \""+email+"\",\r\n"
				+ "\"phone\": \""+phone+"\"\r\n"
				+ "}";
		Response response = RestAssured.given().queryParam("cmd", "create").body(requestBody)
				.headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().post();

		if (response.getStatusCode() == 201) {

			model.addAttribute("response",response.getBody().asString());
			model.addAttribute("statusCode", response.getStatusCode());
		} else {
			model.addAttribute("statusCode", response.getStatusCode());
		}
		
		return "add_customer";
	}
	
	@DeleteMapping("/delete_customer")
	public ResponseEntity<String> deleteCustomer(@RequestParam String uuid){
		
		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		Response response = RestAssured.given().queryParam("cmd", "delete").queryParam("uuid", uuid)
				.headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().post();
		if(response.getStatusCode() == 200)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.OK);
		else if(response.getStatusCode()==500)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.INTERNAL_SERVER_ERROR);
		else
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.NOT_FOUND);
	}
	
	@PutMapping("/update_customer")
	public ResponseEntity<String> updateCustomer(@RequestParam String uuid, @RequestParam String first_name, @RequestParam String last_name, @RequestParam String address, @RequestParam String city, @RequestParam String state, @RequestParam String street,@RequestParam String phone, @RequestParam String email){
		
		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		String requestBody = "{\r\n"
				+ "\"first_name\": \""+first_name+"\",\r\n"
				+ "\"last_name\": \""+last_name+"\",\r\n"
				+ "\"street\": \""+street+"\",\r\n"
				+ "\"address\": \""+address+" \",\r\n"
				+ "\"city\": \""+city+"\",\r\n"
				+ "\"state\": \""+state+"\",\r\n"
				+ "\"email\": \""+email+"\",\r\n"
				+ "\"phone\": \""+phone+"\"\r\n"
				+ "}";
		
		Response response = RestAssured.given().queryParam("cmd", "update").queryParam("uuid", uuid)
				.body(requestBody).headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().post();
		
		if(response.getStatusCode() == 200)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.OK);
		else if(response.getStatusCode()==500)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.NOT_FOUND);
		else
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.BAD_REQUEST);
	}
}
