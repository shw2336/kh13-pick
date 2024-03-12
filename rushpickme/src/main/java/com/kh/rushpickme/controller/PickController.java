package com.kh.rushpickme.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.vo.PickFinishVo;

import jakarta.servlet.http.HttpSession;

@Controller 
@RequestMapping("/pick")
public class PickController {

	@Autowired
	private PickDao pickDao;
	
	@Autowired
	private MemberDao memberDao;
	
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
	
	@GetMapping("/reject")
	public String reject () {
		return "/WEB-INF/views/pick/reject.jsp";
	}
	
//	@PostMapping("/reject")

	
}
