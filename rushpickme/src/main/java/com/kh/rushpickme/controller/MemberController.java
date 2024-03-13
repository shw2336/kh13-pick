package com.kh.rushpickme.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.AttachDao;
import com.kh.rushpickme.dao.BuyDao;
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

	@Autowired
	private BuyDao buyDao;

	// 회원가입 선택창
	@GetMapping("/signUp")
	public String singUp() {
		return "/WEB-INF/views/member/signUp.jsp";
	}

	// 일반회원 가입
	@GetMapping("/signUpGreen")
	public String signUpGreen() {
		return "/WEB-INF/views/member/signUpGreen.jsp";
	}

	@PostMapping("/signUpGreen")
	public String signUpGreen(@ModelAttribute MemberDto memberDto, @ModelAttribute MemberGreenDto memberGreenDto) {

		memberDao.insert(memberDto);
		memberDao.insertGreen(memberGreenDto);
		return "redirect:signUpSuccess";
	}

	@RequestMapping("/signUpSuccess")
	public String joinFinishGreen() {
		return "/WEB-INF/views/member/signUpSuccess.jsp";
	}

	// 수거회원가입
	@GetMapping("/signUpPick")
	public String signUpPick() {
		return "/WEB-INF/views/member/signUpPick.jsp"; // 회원가입 폼으로 이동
	}

	@PostMapping("/signUpPick")
	public String signUpPick(@ModelAttribute MemberDto memberDto, @ModelAttribute MemberPickDto memberPickDto) {

		memberDao.insert(memberDto);
		memberDao.insertPick(memberPickDto);
		return "redirect:signUpSuccess";
	}

	// 실제 로그인
	// - 아이디와 비밀번호 검사를 통과해야만 세션에 데이터를 추가한다
	// - 사용자가 입력한 아이디를 추가한다
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto, HttpSession session) {
		// 사용자가 입력한 아이디로 회원정보를 조회한다
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		// 로그인 가능 여부를 판정
		boolean isValid = findDto != null && inputDto.getMemberPw().equals(findDto.getMemberPw());
		// 결과에 따라 다른 처리
		if (isValid) {
			// 세션에 데이터 추가
			session.setAttribute("loginId", findDto.getMemberId());
			session.setAttribute("loginLevel", findDto.getMemberType());

			return "redirect:/";
		} else {// 로그인 실패
			return "redirect:login?error";
		}
	}

	@GetMapping("/findId")
	public String findId() {
		return "/WEB-INF/views/member/findId.jsp";
	}

	@PostMapping("/findId")
	public String findId(@RequestParam String memberNick) {
		boolean result = emailService.sendMemberId(memberNick);

		if (result) {
			return "redirect:findIdClear";
		} else {
			return "redirect:findIdFail";
		}

	}

	@RequestMapping("/findIdClear")
	public String findIdSuccess() {
		return "/WEB-INF/views/member/findIdClear.jsp";
	}

	@RequestMapping("/findIdFail")
	public String findIdFail() {
		return "/WEB-INF/views/member/findIdFail.jsp";
	}

	@RequestMapping("/mypage")
	public String myPage(HttpSession session, Model model) {
		// 1. 세션-> 아이디를 가져온다
		String loginId = (String) session.getAttribute("loginId");

		// 2. 아이디에 맞는 정보를 조회
		MemberDto memberDto = memberDao.selectOne(loginId);
		MemberGreenDto memberGreenDto = memberDao.selectOneGreen(loginId);
		MemberPickDto memberPickDto = memberDao.selectOnePick(loginId);

		// 3.조회 정보를 화면에 보여준다
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberGreenDto", memberGreenDto);
		model.addAttribute("memberPickDto", memberPickDto);

		// 4. 구매내역을 화면에 같이 보여준다
		model.addAttribute("buyList", buyDao.selectList(loginId));

		// 5.로그인 되어있는 작성 글 내역을 첨부
		model.addAttribute(loginId, memberDto);

		// 6.화면 반환
		return "/WEB-INF/views/member/mypage.jsp";

	}

	// 일반회원 개인정보 변경
	@GetMapping("/changeAccountGreen")
	public String changeAccountGreen(Model model, HttpSession session) {
		// 1.로그인 되어있는 회원을 세션에서 가져온다
		String loginId = (String) session.getAttribute("loginId");

		// 2.로그인 되어있는 아이디로 Dto에 있는 정보를 불러온다
		MemberDto memberDto = memberDao.selectOne(loginId);
		MemberGreenDto memberGreenDto = memberDao.selectOneGreen(loginId);
		//MemberPickDto memberPickDto = memberDao.selectOnePick(loginId);

		// 3. 화면에 정보 전달
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberGreenDto", memberGreenDto);
		//model.addAttribute("memberPickDto", memberPickDto);

		// 4.로그인 되어있는 회원의 구매내역 첨부
		model.addAttribute("buyList", buyDao.selectList(loginId));

		// 5.현재 사용자의 Q&A 작성글
		model.addAttribute(loginId, memberDto);
		model.addAttribute(loginId, memberGreenDto);
		//model.addAttribute(loginId, memberPickDto);

		// 6.view 전달
		return "/WEB-INF/views/member/changeAccountGreen.jsp";
	}

	@PostMapping("/changeAccountGreen")
	public String changeAccountGreen(@ModelAttribute MemberDto memberDto, @ModelAttribute MemberGreenDto memberGreenDto,
									HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		// memberDto 아이디 설정
		memberDto.setMemberId(loginId);
		// memberGreenDto 아이디 설정
		memberGreenDto.setMemberId(loginId);
		// memberPickDto 아이디 설정
		//memberPickDto.setMemberId(loginId);

		// DB정보 조회
		MemberDto findMemberDto = memberDao.selectOne(loginId);
		//MemberGreenDto findGreenDto = memberDao.selectOneGreen(loginId);
		//MemberPickDto findPickDto = memberDao.selectOnePick(loginId);
		
		
		// 조건
		boolean isValid = memberDto.getMemberPw().equals(findMemberDto.getMemberPw());

		System.out.println("aaa");
		System.out.println(loginId);
		// 변경
		if (isValid) {
			memberDao.updateMember(memberDto);
			memberDao.updateGreenMember(memberGreenDto);
			//memberDao.updatePickMember(memberPickDto);

			return "redirect:mypage";
		}

		else {
			// 이전 페이지로 리다이렉트
			return "redirect:change?error";

		}

	}
	
	// 수거회원 개인정보 변경
		@GetMapping("/changeAccountPick")
		public String changeAccountPick(Model model, HttpSession session) {
			// 1.로그인 되어있는 회원을 세션에서 가져온다
			String loginId = (String) session.getAttribute("loginId");

			// 2.로그인 되어있는 아이디로 Dto에 있는 정보를 불러온다
			MemberDto memberDto = memberDao.selectOne(loginId);
		//	MemberGreenDto memberGreenDto = memberDao.selectOneGreen(loginId);
			MemberPickDto memberPickDto = memberDao.selectOnePick(loginId);

			// 3. 화면에 정보 전달
			model.addAttribute("memberDto", memberDto);
		//	model.addAttribute("memberGreenDto", memberGreenDto);
			model.addAttribute("memberPickDto", memberPickDto);

			// 4.로그인 되어있는 회원의 구매내역 첨부
			model.addAttribute("buyList", buyDao.selectList(loginId));

			// 5.현재 사용자의 Q&A 작성글
			model.addAttribute(loginId, memberDto);
		//	model.addAttribute(loginId, memberGreenDto);
			model.addAttribute(loginId, memberPickDto);

			// 6.view 전달
			return "/WEB-INF/views/member/changeAccountPick.jsp";
		}

		@PostMapping("/changeAccountPick")
		public String changeAccountPick(@ModelAttribute MemberDto memberDto, @ModelAttribute MemberPickDto memberPickDto,
				 HttpSession session) {
			String loginId = (String) session.getAttribute("loginId");
			// memberDto 아이디 설정
			memberDto.setMemberId(loginId);
			// memberGreenDto 아이디 설정
			//memberGreenDto.setMemberId(loginId);
			// memberPickDto 아이디 설정
			memberPickDto.setMemberId(loginId);

			// DB정보 조회
			MemberDto findMemberDto = memberDao.selectOne(loginId);
			//MemberGreenDto findGreenDto = memberDao.selectOneGreen(loginId);
			//MemberPickDto findPickDto = memberDao.selectOnePick(loginId);

			// 조건
			boolean isValid = memberDto.getMemberPw().equals(findMemberDto.getMemberPw());

			// 변경
			if (isValid) {
				memberDao.updateMember(memberDto);
				//memberDao.updateGreenMember(memberGreenDto);
				memberDao.updatePickMember(memberPickDto);

				return "redirect:mypage";
			}

			else {
				// 이전 페이지로 리다이렉트
				return "redirect:change?error";

			}

		}

	@GetMapping("/changepassword")
	public String changePassword() {
		return "/WEB-INF/views/member/changePassword.jsp";
	}

	// 기존 비밀번호는 nowPw, 변경비밀번호는 afterPw로 처리
	@PostMapping("/changepassword")
	public String changePassword(@RequestParam String nowPw, @RequestParam String afterPw, HttpSession session) {
		// 로그인된 회원 아이디를 추출
		String loginId = (String) session.getAttribute("loginId");

		// DB에 있는 비밀번호 확인
		MemberDto findDto = memberDao.selectOne(loginId);
//		MemberGreenDto findGreenDto = memberDao.selectOneGreen(loginId);
//		MemberPickDto findPickDto = memberDao.selectOnePick(loginId);
		boolean isValid = findDto.getMemberPw().equals(afterPw);

		if (isValid) {
			// nowPw가 유효
			// 아이디와 변경할 비밀번호(afterPw)로 DTO를 만들어 DAO 기능을 호출 한다
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(loginId);
			memberDto.setMemberPw(afterPw);
			memberDao.updateMemberPw(memberDto);

			return "redirect:/";

		} else {
			return "redirect:password?error";
		}

	}

	@RequestMapping("completePassword")
	public String completePassword() {
		return "/WEB-INF/views/member/completePassword.jsp";
	}

	@GetMapping("/leave")
	public String leave() {
		return "/WEB-INF/views/member/leave.jsp";
	}

	@PostMapping("/leave")
	public String exit(@RequestParam String memberPw, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");

		MemberDto findDto = memberDao.selectOne(loginId);
		boolean isValid = findDto.getMemberPw().equals(memberPw);

		if (isValid) {

			memberDao.delete(loginId);
			session.removeAttribute("loginId");
			return "redirect:exitFinish";
		} else {
			return "redirect:exit?error";
		}

	}
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}
	@PostMapping("/findPw")
	public String findPw(@ModelAttribute MemberDto memberDto) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		
		//아이디가 있으면서 이메일까지 일치하면 통과
		boolean isValid = findDto!=null&&
				findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		if(isValid) {
			emailService.sendTempPassword(findDto);
			return "redirect:findPwSuccess";
		}
		else {
			return "redirect:findPwFail";
		}
		
	}
	@RequestMapping("/findPwSuccess")
	public String findPwsuccess() {
		return "/WEB-INF/views/member/findPwSuccess.jsp";
	}
	@RequestMapping("/findPwFail")
	public String findPwfail() {
		return "/WEB-INF/views/member/findPwFail.jsp";
	}

}
