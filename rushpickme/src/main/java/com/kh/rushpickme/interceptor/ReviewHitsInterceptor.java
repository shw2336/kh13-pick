package com.kh.rushpickme.interceptor;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.rushpickme.dao.ReviewDao;
import com.kh.rushpickme.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
		
		//1. 비회원은 조회수 증가 방지 처리
//		HttpSession session = request.getSession();
//		String loginId = (String) session.getAttribute("loginId");
//		if(loginId == null) {
//			return true;
//		}
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		//2. 작성자 본인인 경우 조회수 증가 방지 처리
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		if(loginId.equals(reviewDto.getMemberId())) {
			return true;
		}
		
//		//3. 작성자가 탈퇴한 사용자면 조회수 증가 방지 처리
//		if(reviewDto.getMemberId() == null) {
//			return true;
//		}
		
		//4. 한 번이라도 본 적이 있는 글이라면 조회수 증가 방지 처리
		//- 여러 방법 중에 HttpSession을 사용하는 방법으로 구현
		//- 세션에 past라는 이름으로 글 번호를 저장할 저장소를 저장
		//- past=[10, 13, 15]  과 같은 형태로 만들 예정
		//- past에 해당하는 저장소는 HashSet<Integer> 형태로 만든다
		
		//session에 past라는 이름의 저장소를 꺼낸다(없을 수도 있음)
		Set<Integer> past = (Set<Integer>) session.getAttribute("past");
		//System.out.println("before = " + past); 
		
		//past가 없으면 null이므로 새로 만들어야 한다
		if(past == null) {
			past = new HashSet<>();
		}
		
		if(past.contains(reviewNo)) {//이미 읽은적이 있다면
			return true;//그냥 통과시키고
		}
		else {//읽은 적이 없다면
			past.add(reviewNo);//번호를 기록하고
			session.setAttribute("past", past);//저장소를 갱신시켜라
		}
		//System.out.println("after = " + past); 
		
		//조회수 증가
		reviewDao.updateReviewHits(reviewNo);
		
		return true;//통과 
	}
}


