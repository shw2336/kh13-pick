package com.kh.rushpickme.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.rushpickme.dao.ApplyDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.service.AttachService;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.PickFinishVo;
import com.kh.rushpickme.vo.PickProceedVo;
import com.kh.rushpickme.vo.PickRejectVo;
import com.kh.rushpickme.vo.PickWaitVo;

import jakarta.servlet.http.HttpSession;

@Controller 
@RequestMapping("/pick")
public class PickController {
	@InitBinder
	public void initBinder (WebDataBinder binder) {
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
	@Autowired
	private PickDao pickDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ApplyDao applyDao;
	
	@Autowired
	private AttachService attachService;
	
	//전체화면
	@RequestMapping("/list")
	public String list (Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		
		String findArea = pickDao.pickArea(loginId);
		session.setAttribute("findArea", findArea); 
		//근무지역 세션에 담아주기, list에서 사용하려고
		
		if (findArea != null) {
			model.addAttribute("findArea",findArea);
		}else {
			return "redirect:/member/login";
		}
			
		List<PickFinishVo> voList = pickDao.pickFinishList(loginId);
		model.addAttribute("voList", voList);
		
		model.addAttribute("countApply", pickDao.countApply(loginId));
		model.addAttribute("countUrgentApply", pickDao.countUrgentApply(loginId));
		model.addAttribute("countProceed", pickDao.countProceed(loginId));
		model.addAttribute("countReject", pickDao.countReject(loginId));
		
		return "/WEB-INF/views/pick/list.jsp"; 
	}
	
	@RequestMapping("/waitList")
	public String waitList (Model model, HttpSession session, @ModelAttribute PageVO pageVo) {
		String findArea = (String) session.getAttribute("findArea");
		int count = pickDao.countApply((String)session.getAttribute("loginId"));
		pageVo.setCount(count);	
		model.addAttribute("pageVo", pageVo);
		List<PickWaitVo> waitList = pickDao.waitListByPaging(pageVo, findArea);
		model.addAttribute("waitList", waitList);
		return "/WEB-INF/views/pick/waitList.jsp";
	}
	
	// 수거접수리스트 상세조회 화면 
	@RequestMapping("/waitDetail")
	public String waitDetail (Model model, @RequestParam int applyNo) {
		ApplyDto findApplyDto = pickDao.selectOneByApply(applyNo);
		model.addAttribute("findApplyDto", findApplyDto);
		
		return "/WEB-INF/views/pick/waitDetail.jsp";
	}
	
	@RequestMapping("/proceedList")
	public String proceedList (Model model, @ModelAttribute PageVO pageVo, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
		int count = pickDao.countProceed(memberId);
		
		pageVo.setCount(count);
		model.addAttribute("pageVo", pageVo);
		
		List<PickProceedVo> proceedList = pickDao.proceedListByPaging(memberId, pageVo);
		model.addAttribute("proceedList", proceedList);
		
		return "/WEB-INF/views/pick/proceedList.jsp";
	}
	
	@RequestMapping("/proceedDetail")
	public String proceedDetail (Model model, @RequestParam int pickNo) {
		int applyNo = pickDao.selectApplyNo(pickNo);
		model.addAttribute("applyNo", applyNo);
		ApplyDto findApplyDto = pickDao.selectOneByApply(applyNo);
		
		MemberDto memberDto = memberDao.selectOne(findApplyDto.getMemberId());
		model.addAttribute("memberContact", memberDto.getMemberContact()) ;
		//신청자 dto에서 신청자 연락처 뽑기
		
		model.addAttribute("findApplyDto", findApplyDto);
		return "/WEB-INF/views/pick/proceedDetail.jsp";
	}
	
	@RequestMapping("/rejectList")
	public String rejectList (Model model, @ModelAttribute PageVO pageVo, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
		int count = pickDao.countReject(memberId);
		pageVo.setCount(count);
		model.addAttribute("pageVo", pageVo);
		
		List<PickRejectVo> rejectList = pickDao.rejectListByPaging(memberId, pageVo);
		model.addAttribute("rejectList", rejectList);
		
		return "/WEB-INF/views/pick/rejectList.jsp";
	}
	
	@GetMapping("/finishList")
	public String finishList (Model model, @ModelAttribute PageVO pageVo, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
		int count = pickDao.countFinish(memberId);
		pageVo.setCount(count);
		model.addAttribute("pageVo", pageVo);
		
		List<PickFinishVo> finishList = pickDao.pickFinishListByPaging(memberId, pageVo);
		model.addAttribute("finishList", finishList);
		
		return "/WEB-INF/views/pick/finishList.jsp";
	}
	
	@PostMapping("/finishList")
	public String finishList (@RequestParam Object[] deletePicks) {
		
		//배열로 넘기기
		pickDao.deleteByArray(deletePicks);
		
		return "redirect:finishList";
	}
	
	@RequestMapping("/deleteFinish")
	public String deleteFinish () {
		return "/WEB-INF/views/pick/deleteFinish.jsp";
	}
	
	@RequestMapping("/finishDetail")
	public String finishDetail (Model model, @RequestParam int pickNo) {
		model.addAttribute("pickNo", pickNo);
		int applyNo = pickDao.selectApplyNo(pickNo);
		model.addAttribute("applyNo", applyNo);
		
		ApplyDto findApplyDto = pickDao.selectOneByApply(applyNo);
		model.addAttribute("findApplyDto", findApplyDto);
		
		return "/WEB-INF/views/pick/finishDetail.jsp";
	}
	
	// 수거 접수
	@GetMapping("/accept")
	public String accept (@RequestParam int applyNo, Model model) {
		model.addAttribute("applyNo", applyNo);
		return "/WEB-INF/views/pick/accept.jsp";
	}
	
	@PostMapping("/accept")
	public String accept (@ModelAttribute PickDto pickDto, HttpSession session, Model model) {
		pickDto.setMemberId((String) session.getAttribute("loginId"));
		pickDao.insertOk(pickDto);
		pickDao.updateApplyStateProceed(pickDto.getApplyNo());
		return "redirect:acceptFinish";
	}
	
	@RequestMapping ("/acceptFinish")
	public String joinComplete () {
		return "/WEB-INF/views/pick/acceptFinish.jsp";
	}
	
	
	// 수거 거부 (접수상태에서 거부하는 경우 or 진행상태에서 거부하는 경우)
	@GetMapping("/reject")
	public String reject (@RequestParam int applyNo, Model model) {
		//apply_state 값 넘겨주기
		model.addAttribute("applyNo", applyNo);
		ApplyDto findApplyDto = pickDao.selectOneByApply(applyNo);
		model.addAttribute("findApplyState", findApplyDto.getApplyState());
		
		return "/WEB-INF/views/pick/reject.jsp";
	}
	
	@PostMapping("/reject")
	public String reject(@ModelAttribute PickDto pickDto, @RequestParam int applyNo, @RequestParam MultipartFile attach, HttpSession session) throws IllegalStateException, IOException {
		String loginId = (String) session.getAttribute("loginId");
		pickDto.setMemberId(loginId);

		ApplyDto findApplyDto = pickDao.selectOneByApply(applyNo);
		String applyState = findApplyDto.getApplyState();
		
		int pickNo = 0;
		if (applyState.equals("신청완료")) {
			//접수 전 이기 때문에 pickNo가 없음 
			pickDao.insertNo(pickDto);
		}else if (applyState.equals("진행중")) {
			//진행중일때만 pickNo가 존재 
			pickNo = pickDao.selectPickNo(applyNo);
			pickDto.setPickNo(pickNo);
			pickDao.updateNo(pickDto);
		}
		//신청자의 상태도 접수거부로 변경
		pickDao.updateApplyStateReject(pickDto.getApplyNo());
		
		if (!attach.isEmpty()) {
			int attachNo = attachService.save(attach);
			pickDao.connect(pickNo, attachNo);
		}
		return "redirect:list";
	}
	
	@GetMapping("/complete")
	public String complete(@RequestParam int applyNo, Model model) {
		model.addAttribute("applyNo", applyNo);
		ApplyDto findApplyDto = pickDao.selectOneByApply(applyNo);
		model.addAttribute("findApplyDto", findApplyDto);
		
		int pickNo = pickDao.selectPickNo(applyNo);
		model.addAttribute("pickNo", pickNo);
		
		return "/WEB-INF/views/pick/complete.jsp";
	}
	
	@PostMapping("/complete")
	public String complete(@ModelAttribute PickDto pickDto, @RequestParam int applyNo, @RequestParam MultipartFile attach, Model model) throws IllegalStateException, IOException {
		int pickNo = pickDao.selectPickNo(applyNo);
		pickDto.setPickNo(pickNo);
		//수거완료되면 수거완료시간 업데이트, 비닐중량, 금액 업데이트
		//신청자 상태 수거완료로 변경
		pickDao.updateInfo(pickDto);
		pickDao.updateApplyStateFinish(applyNo);
		
		if (!attach.isEmpty()) {
			int attachNo = attachService.save(attach);
			pickDao.connect(pickDto.getPickNo(), attachNo);
		}
		return "redirect:pickFinish";
	}
	
	@RequestMapping("/pickFinish")
	public String pickFinish () {
		return "/WEB-INF/views/pick/pickFinish.jsp";
	}
	
	
	@RequestMapping ("/image/apply")
	public String imageApply (@RequestParam int applyNo) {
		try {
			int attachNo = pickDao.applyAttachNo(applyNo);
			return "redirect:/download?attachNo=" + attachNo;
		} catch (Exception e) {
			return "redirect:/image/attachNull.png";
		}
	}
	
	@RequestMapping ("/image/pick")
	public String imagePick (@RequestParam int pickNo) {
		try {
			int attachNo = pickDao.pickAttachNo(pickNo);
			return "redirect:/download?attachNo=" + attachNo;
		} catch (Exception e) {
			return "redirect:/image/attachNull.png";
		}
	}
}
