package com.kh.rushpickme.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller 
@RequestMapping("/pick")
public class PickController {

	@RequestMapping("/list")
	private String list () {
		return "/WEB-INF/views/pick/list.jsp";
	}
	
}
