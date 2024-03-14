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
			
		List<PickFinishVo> voList = pickDao.pickFinishList();
		model.addAttribute("voList", voList);
		
		model.addAttribute("countApply", pickDao.countApply(loginId));
		model.addAttribute("countUrgentApply", pickDao.countUrgentApply());
		model.addAttribute("countProceed", pickDao.countProceed());
		model.addAttribute("countReject", pickDao.countReject());
		
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
	public String proceedList (Model model, @ModelAttribute PageVO pageVo) {
		int count = pickDao.countProceed();
		pageVo.setCount(count);
		model.addAttribute("pageVo", pageVo);
		List<PickProceedVo> proceedList = pickDao.proceedListByPaging(pageVo);
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
	
	@RequestMapping("/finishList")
	public String finishList (Model model, @ModelAttribute PageVO pageVo) {
		int count = pickDao.countFinish();
		pageVo.setCount(count);
		model.addAttribute("pageVo", pageVo);
		List<PickFinishVo> finishList = pickDao.pickFinishListAll(pageVo);
		model.addAttribute("finishList", finishList);
		return "/WEB-INF/views/pick/finishList.jsp";
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
	
	
	// 수거 거부
	@GetMapping("/reject")
	public String reject (@RequestParam int applyNo, Model model) {
		model.addAttribute("applyNo", applyNo);
		return "/WEB-INF/views/pick/reject.jsp";
	}
	
	@PostMapping("/reject")
	public String reject(@ModelAttribute PickDto pickDto, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		pickDto.setMemberId(loginId);

		pickDao.insertNo(pickDto);
		pickDao.updateApplyStateReject(pickDto.getApplyNo());

		return "redirect:list"; //완성 후 바꿔야 함 
	}
	
	@GetMapping("/complete")
	public String complete(@RequestParam int applyNo, Model model) {
		model.addAttribute("applyNo", applyNo);
		return "/WEB-INF/views/pick/complete.jsp";
	}
	
	@PostMapping("/complete")
	public String complete(@ModelAttribute PickDto pickDto, @RequestParam int applyNo, @RequestParam MultipartFile attach, Model model) throws IllegalStateException, IOException {
		int pickNo = pickDao.selectPickNo(applyNo);
		pickDto.setPickNo(pickNo);
		//수거완료되면 수거완료시간 업데이트, 비닐중량, 금액 업데이트
		//신청자 상태 변경
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
