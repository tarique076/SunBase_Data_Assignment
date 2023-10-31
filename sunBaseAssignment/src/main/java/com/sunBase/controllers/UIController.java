package com.sunBase.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sunBase.services.CustomerServices;

@Controller
public class UIController {

	@Value("${base.url}")
	private String baseUrl;

	@Autowired
	private CustomerServices custService;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String loginStatus(Model model, @RequestParam String loginId, @RequestParam String password) {

		return custService.login(model, loginId, password);

	}

	@GetMapping("/customer_list")
	public String customerList(Model model) {

		return custService.getCustomers(model);
	}

	@GetMapping("/add_customer")
	public String addCustomer() {
		return "add_customer";
	}

	@PostMapping("/add_customer")
	public String addNewCustomer(Model model, @RequestParam String fname, @RequestParam String lname,
			@RequestParam String address, @RequestParam String state, @RequestParam String city,
			@RequestParam String email, @RequestParam String phone, @RequestParam String street) {

		custService.addCustomer(model, fname, lname, address, state, city, email, phone, street);
		return "add_customer";
	}
	
	@DeleteMapping("/delete_customer")
	public ResponseEntity<String> deleteCustomer(@RequestParam String uuid){
		
		return custService.deleteCustomer(uuid);
	}
	
	@PutMapping("/update_customer")
	public ResponseEntity<String> updateCustomer(@RequestParam String uuid, @RequestParam String first_name, @RequestParam String last_name, @RequestParam String address, @RequestParam String city, @RequestParam String state, @RequestParam String street,@RequestParam String phone, @RequestParam String email){
		
		return custService.updateCustomer(uuid, first_name, last_name, address, city, state, street, phone, email);
	}
}
