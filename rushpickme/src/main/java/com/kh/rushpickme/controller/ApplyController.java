package com.kh.rushpickme.controller;

import java.io.IOException;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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


import jakarta.mail.Session;
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
			
	

	// 수거 신청 페이지

	@GetMapping("/request")
	private String request() {
		return "/WEB-INF/views/apply/request.jsp"; // 수거 신청 정보입력페이지 주소
	}

	@PostMapping("/request")
	private String request(@ModelAttribute ApplyDto applyDto, @RequestParam MultipartFile applyAttach,
			HttpSession session) throws IllegalStateException, IOException {
		// 1. 세션에 저장된 아이디를 꺼낸다
		String loginId = "testuser1";
		// 로그인 아이디 뽑기
		applyDto.setMemberId(loginId);

		int longinNo = applyDao.getSequence();

		applyDto.setApplyNo(longinNo);

		applyDao.applyInsert(applyDto);

		// 첨부파일 등록
		if (!applyAttach.isEmpty()) {
			int attachNo = attachService.save(applyAttach);// 파일저장+DB저장
			applyDao.connect(applyDto.getApplyNo(), attachNo);// 연결
		}

		return "redirect:/";
	}
	// stateList화면
	@GetMapping("/stateList")
	private String stateList() {
		return "/WEB-INF/views/apply/stateList.jsp"; // 이용상세 내역 페이지
	}
//	@PostMapping("/stateList")
//	private String stateList() {/*int applyNo, HttpSession httpSession*/
//
//		
////		applyDao.applyInsert(applyDto);
////		applyDao.update
//	
//	return "/WEB-INF/views/apply/stateList.jsp";
//}
	@GetMapping("/stateDetail")
	private String stateDetail() {
		return "/WEB-INF/views/apply/stateDetail.jsp"; // 수거 진행 상세 페이지
	}
	
	
	
	
	@RequestMapping("/requestList")
	public String list() {
//					Model model, HttpSession session,		@ModelAttribute ApplyRequestListVo applyRequestListVo) {
//		int findNo = (int) session.getAttribute("applyNo");
//		int count = applyDao.count(applyRequestListVo);
//		applyRequestListVo.setCount(count);
//		model.addAttribute("pageVO", applyRequestListVo);
//		
//		List<ApplyRequestListVo> requestList = applyDao.requestListByPaging(applyRequestListVo, findNo);
//		model.addAttribute("list", requestList);
		
		return "/WEB-INF/views/apply/requestList.jsp";
		
	}
	

		


	@GetMapping("/cancel")
	private String cancel() {
		return "/WEB-INF/views/apply/cancel.jsp";
	}

}
