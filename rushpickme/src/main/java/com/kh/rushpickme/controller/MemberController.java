package com.kh.rushpickme.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.AttachDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.dto.MemberGreenDto;
import com.kh.rushpickme.dto.MemberPickDto;
import com.kh.rushpickme.service.AttachService;
import com.kh.rushpickme.service.EmailService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private EmailService emailService;
	
	//회원가입 선택창
	@GetMapping("/signUp")
	public String singUp() {
		return "/WEB-INF/views/member/signUp.jsp";
	}
	
	
    //일반회원 가입
    @GetMapping("/signUpGreen")
    public String signUpGreen() {
        return "/WEB-INF/views/member/signUpGreen.jsp"; 
    }
    
    @PostMapping("/signUpGreen")
	public String signUpGreen(@ModelAttribute MemberDto memberDto,
							@ModelAttribute MemberGreenDto memberGreenDto) {
  		                 
		
		memberDao.insert(memberDto);
		memberDao.insertGreen(memberGreenDto);
		return "redirect:signUpSuccess";
	}
    
    @RequestMapping("/signUpSuccess")
	public String joinFinishGreen() {
		return "/WEB-INF/views/member/signUpSuccess.jsp";
	}

    
    
    //수거회원가입 
    @GetMapping("/signUpPick")
    public String signUpPick() {
        return "/WEB-INF/views/member/signUpPick.jsp"; // 회원가입 폼으로 이동
    }
    
    @PostMapping("/signUpPick")
	public String signUpPick(@ModelAttribute MemberDto memberDto,
							 @ModelAttribute MemberPickDto memberPickDto) {
  		                 
		
		memberDao.insert(memberDto);
		memberDao.insertPick(memberPickDto);
		return "redirect:signUpSuccess";
	}
    
    
    
   
    
   
    
    
  //실제 로그인
  	//- 아이디와 비밀번호 검사를 통과해야만 세션에 데이터를 추가한다
  	//- 사용자가 입력한 아이디를 추가한다
  	@GetMapping("/login")
  	public String login() {
  		return "/WEB-INF/views/member/login.jsp";
  	}
  	@PostMapping("/login")
  	public String login(@ModelAttribute MemberDto inputDto,
  										HttpSession session) {
  		//사용자가 입력한 아이디로 회원정보를 조회한다
  		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
  		//로그인 가능 여부를 판정
  		boolean isValid = findDto != null 
  				&& inputDto.getMemberPw().equals(findDto.getMemberPw());
  		//결과에 따라 다른 처리
  		if(isValid) {
  			//세션에 데이터 추가
  			session.setAttribute("loginId", findDto.getMemberId());
  			session.setAttribute("loginLevel", findDto.getMemberType());
  		
  			
  			return "redirect:/";
  		}
  		else {//로그인 실패
  			return "redirect:login?error";
  		}
  	}
  	
  	@GetMapping("/findId")
  	public String findId() {
  		return "/WEB-INF/views/member/findId.jsp";
  	}
  	@PostMapping("/findId")
  	public String findId(@RequestParam String memberNick) {
//  		boolean result = emailService.sendMemberId
  	}
    
    
}