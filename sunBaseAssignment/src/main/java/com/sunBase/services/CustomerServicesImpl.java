package com.sunBase.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

@Service
public class CustomerServicesImpl implements CustomerServices {

	@Value("${base.url}")
	private String baseUrl;

	private String token;

	@Override
	public String login(Model model, String loginId, String password) {

		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment_auth.jsp";

		String jsonRequestBody = "{\r\n" + "\"login_id\" : \"" + loginId + "\",\r\n" + "\"password\" :\"" + password
				+ "\"\r\n" + "}";

		Response response = RestAssured.given().contentType(ContentType.JSON).body(jsonRequestBody).when().post(); // path

		if (response.getStatusCode() == 200) {
			JsonPath jsonPath = response.jsonPath();
			Map<String, Object> responseBodyMap = jsonPath.getMap("");

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

	@Override
	public void addCustomer(Model model, String fname, String lname, String address, String state, String city,
			String email, String phone, String street) {

		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		String requestBody = "{\r\n" + "\"first_name\": \"" + fname + "\",\r\n" + "\"last_name\": \"" + lname
				+ "\",\r\n" + "\"street\": \"" + street + "\",\r\n" + "\"address\": \"" + address + " \",\r\n"
				+ "\"city\": \"" + city + "\",\r\n" + "\"state\": \"" + state + "\",\r\n" + "\"email\": \"" + email
				+ "\",\r\n" + "\"phone\": \"" + phone + "\"\r\n" + "}";
		Response response = RestAssured.given().queryParam("cmd", "create").body(requestBody)
				.headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().post();

		if (response.getStatusCode() == 201) {

			model.addAttribute("response", response.getBody().asString());
			model.addAttribute("statusCode", response.getStatusCode());
		} else {
			model.addAttribute("statusCode", response.getStatusCode());
		}
	}

	@Override
	public ResponseEntity<String> updateCustomer(String uuid, String first_name, String last_name, String address,
			String city, String state, String street, String phone, String email) {

		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		String requestBody = "{\r\n" + "\"first_name\": \"" + first_name + "\",\r\n" + "\"last_name\": \"" + last_name
				+ "\",\r\n" + "\"street\": \"" + street + "\",\r\n" + "\"address\": \"" + address + " \",\r\n"
				+ "\"city\": \"" + city + "\",\r\n" + "\"state\": \"" + state + "\",\r\n" + "\"email\": \"" + email
				+ "\",\r\n" + "\"phone\": \"" + phone + "\"\r\n" + "}";

		Response response = RestAssured.given().queryParam("cmd", "update").queryParam("uuid", uuid).body(requestBody)
				.headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().post();

		if (response.getStatusCode() == 200)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.OK);
		else if (response.getStatusCode() == 500)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.NOT_FOUND);
		else
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.BAD_REQUEST);
	}

	@Override
	public ResponseEntity<String> deleteCustomer(String uuid) {
		RestAssured.baseURI = "https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp";

		Response response = RestAssured.given().queryParam("cmd", "delete").queryParam("uuid", uuid)
				.headers("Authorization", "Bearer " + token).contentType(ContentType.JSON).when().post();
		if (response.getStatusCode() == 200)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.OK);
		else if (response.getStatusCode() == 500)
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.INTERNAL_SERVER_ERROR);
		else
			return new ResponseEntity<String>(response.getBody().asString(), HttpStatus.NOT_FOUND);
	}

	@Override
	public String getCustomers(Model model) {
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

}
