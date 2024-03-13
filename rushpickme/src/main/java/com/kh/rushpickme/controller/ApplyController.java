package com.kh.rushpickme.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.rushpickme.dao.ApplyDao;
import com.kh.rushpickme.dao.AttachDao;
import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.service.AttachService;

import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/apply")
public class ApplyController {
	
	@Autowired
	private ApplyDao applyDao;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private AttachDao attachDao;
	
		//수거 신청 페이지
	
		@GetMapping("/request")
		private String request() {
			return "/WEB-INF/views/apply/request.jsp"; //수거 신청 정보입력페이지 주소
		}
		@PostMapping("/request")
		private String request(@ModelAttribute ApplyDto applyDto, 
					               	@RequestParam MultipartFile attach,HttpSession session ) throws IllegalStateException, IOException {
			
			applyDao.insert(applyDto);
			
			//첨부파일 등록
			if(!attach.isEmpty()) {
				int attachNo = attachService.save(attach);//파일저장+DB저장
				applyDao.connect(applyDto.getMemberId(), attachNo);//연결
			}
			return"redirect:/";
			
		}
		//미리 아이디 꺼내기 
		public String request(HttpSession session, @ModelAttribute ApplyDto applyDto) {
		//1. 세션에 저장된 아이디를 꺼낸다
//		String loginId = (String) session.getAttribute("loginId");
		String loginId = "testuser1";
		
		
		//로그인 아이디 뽑기 
		applyDto.setMemberId(loginId);
		
		int longinNo = applyDao.getSequence();
		
		applyDto.setApplyNo(longinNo); 
		
		applyDao.insert(applyDto);
		
		//4. 연결될 화면을 반환한다
		return "redirect:/";
		}
		
		
			
		

}
