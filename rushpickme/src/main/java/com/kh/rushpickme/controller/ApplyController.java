package com.kh.rushpickme.controller;

import java.io.IOException;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.dto.MemberGreenDto;
import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.dto.ReviewDto;
import com.kh.rushpickme.service.AttachService;
import com.kh.rushpickme.vo.ApplyDetailVO;
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
	
	@Autowired
	private PickDao pickDao;
	
	@Autowired
	private MemberDao memberDao;
			
	

	// 수거 신청 페이지
	@GetMapping("/request")
	public String request() {
		return "/WEB-INF/views/apply/request.jsp"; // 수거 신청 정보입력페이지 주소
	}

	@PostMapping("/request")
	public String request(@ModelAttribute ApplyDto applyDto, @RequestParam MultipartFile applyAttach,
			HttpSession session) throws IllegalStateException, IOException {
		// 1. 세션에 저장된 아이디를 꺼낸다
		String loginId = (String) session.getAttribute("loginId"); 
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
	//신청 목록 (원본)
//		@RequestMapping("/applyList")
//		public String applyList(Model model, String memberId,ApplyListVO applyListVO,ApplyDto applyDto,HttpSession session) {
//			String loginId = (String) session.getAttribute("loginId"); 
//			applyDto.setMemberId(loginId);
//			List<ApplyListVO> applyList = applyDao.applyList( loginId);
//			model.addAttribute("applyList",applyList);
//			return "/WEB-INF/views/apply/applyList.jsp";
//		}
		//신청 목록 ( PageVO추가 )
		@RequestMapping("/applyList")
		public String applyList(Model model, String memberId,ApplyListVO applyListVO,
								ApplyDto applyDto,HttpSession session,
								@ModelAttribute PageVO pageVO) {
			String loginId = (String) session.getAttribute("loginId"); 
			applyDto.setMemberId(loginId);
			int count =applyDao.applyFinishCount(loginId);
			
			pageVO.setCount(count);
			model.addAttribute("pageVO",pageVO);
			
			List<ApplyListVO> applyList = applyDao.selectApplyListByPaging(loginId,pageVO);
			model.addAttribute("applyList",applyList);
			
			return "/WEB-INF/views/apply/applyList.jsp";
		}
		
		
		
		
		
		
		
	// 수거 현황 진행사항 페이지
	@RequestMapping("/stateList")
	public String stateList(@RequestParam int applyNo, Model model, HttpSession session,ApplyDto applyDto ) {
		String loginId = (String) session.getAttribute("loginId"); 
		applyDto.setMemberId(loginId); //아이디 로그인 됬음 
		ApplyDto applyDto1 = applyDao.selectOne(applyNo);
		
		model.addAttribute("applyNo",applyNo);
		model.addAttribute("applyDto",applyDto1);
//	      List<ApplyDetailVO>applyDetail = applyDao.applyDetail(applyNo);
//	        model.addAttribute("applyDetail", applyDetail);
		return "/WEB-INF/views/apply/stateList.jsp"; // 이용상세 내역 페이지
	}

	
	//신청 상세 조회 
	@GetMapping("/applyDetail")
    public String applyDetail(@RequestParam int applyNo, Model model,ApplyDto applyDto, ApplyDetailVO applyDetailVO,HttpSession session) {
		//리스트가 아니고 ApplyDetailVO로 담아야할듯 
		//1명 정보 뽑는거니까 리스트 아님
		String loginId = (String) session.getAttribute("loginId"); 
		applyDto.setMemberId(loginId);
		ApplyDetailVO applyDetail= applyDao.applyDetail(applyNo);
        model.addAttribute("applyDetail", applyDetail);
        model.addAttribute("applyDto",applyDto);
        return "/WEB-INF/views/apply/applyDetail.jsp";
    }
	
	
//		model.addAttribute("jsp에서부를이름",현재여기서 데이터 담아놓은 파라미터명);
	
	@PostMapping("/applyDetail")
	public String applyDetai(@RequestParam int applyNo) {
		
		applyDao.cancel(applyNo);
		return "/WEB-INF/views/apply/applyDetail.jsp";
	}
	
	//신청 취소 
	@PostMapping("/cancel")
	public String cancel(@RequestParam int applyNo, HttpSession session,  @ModelAttribute ApplyDto applyDto ) {
		String loginId = (String) session.getAttribute("loginId"); 
		applyDto.setMemberId(loginId);
		
		ApplyDto applyDto1 = applyDao.selectOne(applyNo);
		ApplyDetailVO applyDetail= applyDao.applyDetail(applyNo);
		applyDao.cancel(applyNo);
		return "/WEB-INF/views/apply/cancel.jsp";
	}
	
	//결제 내역
	@RequestMapping("/finish")
	public String finish(@RequestParam int applyNo, @ ModelAttribute ApplyDto applyDto,
								HttpSession session, Model model) {
		String loginId=(String) session.getAttribute("loginId");
		applyDto.setMemberId(loginId);
		int pickNo = pickDao.selectPickNo(applyNo);
		PickDto pickDto =pickDao.selectOneByPick(pickNo);
		ApplyDto findDto = applyDao.selectOne(applyNo);
		MemberGreenDto greenDto = memberDao.selectOneGreen(loginId);
		
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setAskNo(applyNo);
		
		model.addAttribute("point", greenDto.getMemberGreenPoint());
		
		
		model.addAttribute("pickDto",pickDto);
		model.addAttribute("applyDto", findDto);
		
		
		
		return "/WEB-INF/views/apply/finish.jsp";
	}
	@PostMapping("/review")
	public String review(@RequestParam String memberId) {
		
		return "/WEB-INF/views/review.jsp";
	}
	
	
	

//	@RequestMapping("/cancel")
//	public String cancel(@RequestParam int applyNo,HttpSession httpSession, ApplyDto applyDto) {
//			String loginId = "jihaehuh123";
//			applyDto.setMemberId(loginId);
//			applyDao.cancel(applyNo);
//		return "/WEB-INF/views/apply/cancel.jsp";
//	}
	
	
	
	//join 썼을때 결제 내역 할때 사용하기 
//	@RequestMapping("/requestList")
//	public String requestList(Model model) {
//		
//		List<ApplyListVO> requestList = applyDao.applyList();
//		model.addAttribute("requestList", requestList);
//			
//		return "/WEB-INF/views/apply/requestList.jsp";
//		}
	
	

}