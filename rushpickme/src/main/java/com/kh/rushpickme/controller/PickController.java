package com.kh.rushpickme.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.ApplyDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.dto.MemberPickDto;
import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.PickFinishVo;
import com.kh.rushpickme.vo.PickProceedVo;
import com.kh.rushpickme.vo.PickWaitVo;

import jakarta.servlet.http.HttpSession;

@Controller 
@RequestMapping("/pick")
public class PickController {

	@Autowired
	private PickDao pickDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ApplyDao applyDao;
	
	//전체화면
	@RequestMapping("/list")
	public String list (Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		
		MemberPickDto findArea = pickDao.pickArea(loginId);
		System.out.println(findArea); 
		List<PickFinishVo> voList = pickDao.pickFinishList();
		model.addAttribute("voList", voList);
		
		model.addAttribute("countApply", pickDao.countApply());
		model.addAttribute("countUrgentApply", pickDao.countUrgentApply());
		model.addAttribute("countProceed", pickDao.countProceed());
		model.addAttribute("countReject", pickDao.countReject());
		
		return "/WEB-INF/views/pick/list.jsp"; 
	}
	
	@RequestMapping("/waitList")
	public String waitList (Model model, @ModelAttribute PageVO pageVo) {
		int count = pickDao.countApply();
		pageVo.setCount(count);	
		model.addAttribute("pageVo", pageVo);
		List<PickWaitVo> waitList = pickDao.waitListByPaging(pageVo);
		model.addAttribute("waitList", waitList);
		return "/WEB-INF/views/pick/waitList.jsp";
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
	
	@RequestMapping("/finishList")
	public String finishList (Model model, @ModelAttribute PageVO pageVo) {
		int count = pickDao.countFinish();
		pageVo.setCount(count);
		model.addAttribute("pageVo", pageVo);
		List<PickFinishVo> finishList = pickDao.pickFinishListAll(pageVo);
		model.addAttribute("finishList", finishList);
		return "/WEB-INF/views/pick/finishList.jsp";
	}
	
	@RequestMapping("/waitDetail")
	public String waitDetail () {
//		@RequestParam int applyNo, Model model
//		ApplyDto applyDto = applyDao.detail(applyNo);
//		model.addAttribute("applyDto", applyDto);
		return "/WEB-INF/views/pick/waitDetail.jsp";
	}
	
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
	
	// 첨부파일 
//	@RequestMapping ("/image")
//	public String image (@RequestParam int applyNo) {
//		try {
////			int attachNo = applyDao.(applyNo);
////			return "redirect:/download?attachNo=" + attachNo;
//		} catch (Exception e) {
////			return "redirect:/image/profile.jpg";
//		}
	
	
//	}
	
}
