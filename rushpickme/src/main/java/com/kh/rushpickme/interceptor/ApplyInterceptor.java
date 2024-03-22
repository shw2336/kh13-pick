package com.kh.rushpickme.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Service
public class ApplyInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		String loginLevel = (String) session.getAttribute("loginLevel");
		
		boolean isGreen = loginId != null && loginLevel.equals("그린");
		
		if (isGreen) {
			return true;
		}else {
			response.sendRedirect("/member/login");
			return false;
		}
	}
}
