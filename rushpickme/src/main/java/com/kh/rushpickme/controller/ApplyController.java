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
import com.kh.rushpickme.vo.ApplyListVO;
import com.kh.rushpickme.vo.PageVO;

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
	public String request() {
		return "/WEB-INF/views/apply/request.jsp"; // 수거 신청 정보입력페이지 주소
	}

	@PostMapping("/request")
	public String request(@ModelAttribute ApplyDto applyDto, @RequestParam MultipartFile applyAttach,
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
	public String stateList() {
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
	public String stateDetail() {
		return "/WEB-INF/views/apply/stateDetail.jsp"; // 수거 진행 상세 페이지
	}
	
	//join 썼을때 결제 내역 할때 사용하기 
//	@RequestMapping("/requestList")
//	public String requestList(Model model) {
//		
//		List<ApplyListVO> requestList = applyDao.applyList();
//		model.addAttribute("requestList", requestList);
//			
//		return "/WEB-INF/views/apply/requestList.jsp";
//		}
	//신청 목록 
	@GetMapping("/requestList")
	public String requestList(Model model, String memberId) {
		List<ApplyDto> applyList = applyDao.requsetList();
		//applyDao에서 requestList들을 부를게 
		//부르는 형태는 List <applyDto>야 
//		int number = 3;
//		model.addAttribute("jsp에서부를이름",현재여기서 데이터 담아놓은 파라미터명);
		model.addAttribute(applyList);
		return "/WEB-INF/views/apply/requestList.jsp";
	}
	//신청 상세 조회 
	@RequestMapping("/requestDetail")
    public String detail(@RequestParam int applyNo, Model model) {
        ApplyDto applyDto = applyDao.selectOne(applyNo);
        model.addAttribute("applyDto", applyDto);
        return "/WEB-INF/views/apply/requestDetail.jsp";
    }
	 

	
	@GetMapping("/cancel")
	public String cancel() {
		return "/WEB-INF/views/apply/cancel.jsp";
	}

}
