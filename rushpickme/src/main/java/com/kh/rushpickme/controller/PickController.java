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
import org.springframework.web.multipart.MultipartFile;

import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.vo.PickFinishVo;
import com.kh.rushpickme.vo.PickWaitVo;

import jakarta.servlet.http.HttpSession;

@Controller 
@RequestMapping("/pick")
public class PickController {

	@Autowired
	private PickDao pickDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//전체화면
	@RequestMapping("/list")
	public String list (Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		
		List<PickFinishVo> voList = pickDao.pickFinishList();
		model.addAttribute("voList", voList);
		
		model.addAttribute("countApply", pickDao.countApply());
		model.addAttribute("countUrgentApply", pickDao.countUrgentApply());
		model.addAttribute("countProceed", pickDao.countProceed());
		model.addAttribute("countReject", pickDao.countReject());
		
		return "/WEB-INF/views/pick/list.jsp";
	}
	
	@RequestMapping("/waitList")
	public String waitList (Model model) {
		List<PickWaitVo> waitList = pickDao.waitList();
		model.addAttribute("waitList", waitList);
		return "/WEB-INF/views/pick/waitList.jsp";
	}
	
	@RequestMapping("/waitDetail")
	public String waitDetail (@RequestParam int applyNo, @RequestParam MultipartFile attach, Model model) {
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
	

	
}
