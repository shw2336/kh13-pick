package com.kh.rushpickme.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice (annotations = Controller.class) 
public class ErrorController {
	
	@ExceptionHandler (Exception.class)
	public String handler(Exception e) {
		
		e.printStackTrace();  //에러 정보를 콘솔이나 파일 등에 출력하는 코드 (사용자는 안보임)
		return "/WEB-INF/views/error.jsp";
	}
}
