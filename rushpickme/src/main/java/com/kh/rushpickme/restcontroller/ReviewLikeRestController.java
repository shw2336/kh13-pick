package com.kh.rushpickme.restcontroller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.rushpickme.dao.ReviewLikeDao;
import com.kh.rushpickme.vo.LikeVO;

import jakarta.servlet.http.HttpSession;

//@CrossOrigin
@RestController
@RequestMapping("/rest/review_like")
public class ReviewLikeRestController {
	@Autowired
	private ReviewLikeDao reviewLikeDao;
	
//	회원의 글에 대한 좋아요 상태를 조회
//	@RequestMapping("/check")
//	public Map<String, Object> check (
//			HttpSession session, @RequestParam int reviewNo) {
//		String loginId = (String)session.getAttribute("loginId");
//		
//		Map<String, Object> data = new HashMap<>();
//		data.put("state", reviewLikeDao.check(loginId, reviewNo));
//		data.put("count", reviewLikeDao.count(reviewNo));
//		
//		return data;
//	}
	
	@RequestMapping("/check")
	public LikeVO check (
			HttpSession session, @RequestParam int reviewNo) {
		String loginId = (String)session.getAttribute("loginId");
		
		LikeVO likeVO = new LikeVO();
		likeVO.setState(reviewLikeDao.check(loginId, reviewNo));
		likeVO.setCount(reviewLikeDao.count(reviewNo));
		
		return likeVO;
	}
	
//	하트를 클릭한 경우 실행할 매핑
//	@RequestMapping("/toggle")
//	public Map<String, Object> toggle(
//			HttpSession session, @RequestParam int reviewNo) {
//		String loginId = (String)session.getAttribute("loginId");
//		
//		Map<String, Object> data = new HashMap<>();
//		
//		if(reviewLikeDao.check(loginId, reviewNo)) {//좋아요 누른적 있으면
//			reviewLikeDao.delete(loginId, reviewNo);//좋아요 취소
//			data.put("state", false);
//		}
//		else {
//			reviewLikeDao.insert(loginId, reviewNo);//좋아요 설정
//			data.put("state", true);
//		}
//		
//		//바뀐 좋아요 개수 확인
//		int count = reviewLikeDao.count(reviewNo);
//		data.put("count", count);
//		
//		return data;
//	}
	
	@RequestMapping("/toggle")
	public LikeVO toggle(
			HttpSession session, @RequestParam int reviewNo) {
		String loginId = (String)session.getAttribute("loginId");
		
		LikeVO likeVO = new LikeVO();
		if(reviewLikeDao.check(loginId, reviewNo)) {//좋아요 누른적 있으면
			reviewLikeDao.delete(loginId, reviewNo);//좋아요 취소
			likeVO.setState(false);
		}
		else {
			reviewLikeDao.insert(loginId, reviewNo);//좋아요 설정
			likeVO.setState(true);
		}
		//바뀐 좋아요 개수 확인
		likeVO.setCount(reviewLikeDao.count(reviewNo));
		
		return likeVO;
	}
}