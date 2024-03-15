package com.kh.rushpickme.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.rushpickme.dao.ReviewDao;
import com.kh.rushpickme.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//게시글의 조회수와 관련된 사전 처리를 수행하는 인터셉터
@Service
public class ReviewHitsInterceptor  implements HandlerInterceptor {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//인터셉터에서 파라미터를 받고싶다면 
		// - request.getParameter("이름") 을 사용
		// - 반환형이 String이므로 원하는 형태로 바꿔서 사용
		
		//파라미터에서 글 번호 추출
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		
		//조회수 증가
		reviewDao.updateReviewHits(reviewNo);
		
		return true;//통과 
	}
}


