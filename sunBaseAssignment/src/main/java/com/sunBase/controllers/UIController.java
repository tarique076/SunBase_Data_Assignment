package com.sunBase.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
//	= "dGVzdEBzdW5iYXNlZGF0YS5jb206VGVzdEAxMjM=";

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String loginStatus(Model model, @RequestParam String loginId, @RequestParam String password) {

		// Set the base URI
		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment_auth.jsp"; // Replace with your
																									// base URL

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
			System.out.println(token);
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

//		String resp = response.getBody().asString();
//		System.err.println(response.getBody().asString());
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

		String res = response.getBody().asString();
//		String resp = response.getBody().asString();
//		System.err.println(response.getBody().asString());
		if (response.getStatusCode() == 201) {

			model.addAttribute("response",response.getBody().asString());
			model.addAttribute("statusCode", response.getStatusCode());
		} else {
			model.addAttribute("statusCode", response.getStatusCode());
		}
		
		return "add_customer";
	}
}
