package com.kh.rushpickme.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.rushpickme.dao.PickDao;

@Controller 
@RequestMapping("/pick")
public class PickController {

	@Autowired
	private PickDao pickDao;
	
	@RequestMapping("/list")
	public String list (Model model) {
		return "/WEB-INF/views/pick/list.jsp";
	}
	
	@GetMapping("/reject")
	public String reject () {
		return "/WEB-INF/views/pick/reject.jsp";
	}
	
//	@PostMapping("/reject")

	
}
