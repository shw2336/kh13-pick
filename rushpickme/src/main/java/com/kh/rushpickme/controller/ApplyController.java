package com.kh.rushpickme.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/apply")
public class ApplyController {
	
	@RequestMapping("/request")
	private String request() {
		return "/WEB-INF/views/apply/request.jsp";
	}

}
