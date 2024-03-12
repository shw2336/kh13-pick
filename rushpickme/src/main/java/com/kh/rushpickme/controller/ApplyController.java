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
import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.service.AttachService;



@Controller
@RequestMapping("/apply")
public class ApplyController {
	
	@Autowired
	private ApplyDao applyDao;
	
	@Autowired
	private AttachService attachService;
	
		//수거 신청 페이지
	
		@GetMapping("/request")
		private String request() {
			return "/WEB-INF/views/apply/request.jsp"; //수거 신청 정보입력페이지 주소
		}
		@PostMapping("/request")
		private String request(@ModelAttribute ApplyDto applyDto, 
					               	@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
			
			applyDao.applyInsert(applyDto);
			
			//첨부파일 등록
			if(!attach.isEmpty()) {
				int attachNo = attachService.save(attach);//파일저장+DB저장
				applyDao.connect(applyDto.getMemberId(), attachNo);//연결
			}
			return"/WEB-INF/views/apply/success.jsp";
			
		}  
		
		@RequestMapping("/requestCancel")
		public String joinFinish() {
			return "/WEB-INF/views/member/joinFinish.jsp";
		}

}
