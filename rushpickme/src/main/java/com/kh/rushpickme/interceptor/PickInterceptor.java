package com.kh.rushpickme.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class PickInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String loginLevel = (String) session.getAttribute("loginLevel");
		
		boolean isPicker = loginLevel != null && loginLevel.equals("피커");
		
		if (isPicker) {
			return true;
		}else {
			response.sendRedirect("/member/login");
			return false;
		}
	}
}
