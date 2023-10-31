package com.sunBase.services;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

public interface CustomerServices {

	public String login(Model model, String loginId, String password);

	public void addCustomer(Model model, String fname, String lname, String address, String state, String city,
			String email, String phone, String street);

	public ResponseEntity<String> updateCustomer(String uuid, String first_name, String last_name, String address, String city,
			String state, String street, String phone, String email);

	public ResponseEntity<String> deleteCustomer(String uuid);

	public String getCustomers(Model model);
}
