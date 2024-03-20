package com.kh.spring10.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 이미 만들어진 컨트롤러에서 발생하는 예외에 대한 처리를 수행하는 도구
// - 간섭도구 (AOP의 구현체 중 하나)
// - 등록을 @ControllerAdvice로 하며, 옵션으로 대상을 반드시 지정해야 한다.
// - 클래스 내에는 @ExeptionHandler를 만들어 예외를 종류별로 처리
// - 메소드 내에서 필요한 처리를하고 보여주고 싶은 화면을 반환
// - 컨트롤러처럼 필요한 데이터를 선언하면 자동으로 전달해 줌 (세션, 예외객체 등)

//@ControllerAdvice(basePackages = {"com.kh.spring10.controller", ...}) : 패키지이름으로 대상설정
//Controller 어노테이션으로 대상설정 (어떤 패키지든 상관없이)
// : 어느컨트롤러든 컨트롤러 실행시 오류가 나면 나오는 페이지 설정 
// : 컨트롤러 실행오류가 아닌, 예를들어 주소를틀려서 오류나면 나오는 white label 페이지를 안보이게 하려면
//  -> application.properties에서 설정

@ControllerAdvice (annotations = Controller.class) 
public class ErrorController {
	
	@ExceptionHandler (Exception.class)
	public String handler(Exception e) {
		
		e.printStackTrace();  //에러 정보를 콘솔이나 파일 등에 출력하는 코드 (사용자는 안보임)
		return "/WEB-INF/views/error.jsp";
	}
}

 

