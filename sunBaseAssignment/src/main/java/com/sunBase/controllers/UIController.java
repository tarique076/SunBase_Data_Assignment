package com.sunBase.controllers;

import java.util.List;
import java.util.Map;

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

	private String token;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String customerList(Model model, @RequestParam String loginId, @RequestParam String password) {

		String redirect;

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
			redirect = "customer_list";
		} else {
			token = response.getBody().asString();
			System.out.println(token);
			model.addAttribute("Error", token);
			return "login";
		}

		return redirect;
	}

	@GetMapping("/customer_list")
	public String customerList(Model model) {

		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		Response response = RestAssured.given().param("cmd", "get_customer_list").headers("Authorization", "Bearer " + token)
				.contentType(ContentType.JSON).when().get();
		
//		String resp = response.getBody().asString();
//		System.err.println(response.getBody().asString());
		if(response.getStatusCode()==200) {
			
			JsonPath jsonPath = new JsonPath(response.getBody().asString());
			
			List<Map<String, Object>> mapList = jsonPath.getList("$");
			model.addAttribute("response", mapList);
			return "customer_list";
		}else {
			model.addAttribute("response", response.getBody().asString());
			return "customer_list";
		}
	}

	@GetMapping("/add_customer")
	public String addCustomer() {
		return "add_customer";
	}
}
