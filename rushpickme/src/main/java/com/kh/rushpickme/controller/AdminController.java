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

import com.kh.rushpickme.dao.AdminDao;
import com.kh.rushpickme.dao.ApplyDao;
import com.kh.rushpickme.dao.BuyDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BuyDao buyDao;

	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private ApplyDao applyDao;
	
	@Autowired
	private PickDao pickDao;
	
	
	@RequestMapping("/check/apply")
	public String checkApply(
			@ModelAttribute PageVO pageVO,
			Model model) {
		int count = applyDao.count(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		
		List<ApplyDto> list = applyDao.selectListByPaging(pageVO);
		model.addAttribute("list", list);
			
	    return "/WEB-INF/views/admin/check/apply.jsp";
	}
	
	@RequestMapping("/check/pick")
	public String checkPick(
			@ModelAttribute PageVO pageVO,
			Model model) {
		int count = pickDao.count(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		List<PickDto> list = pickDao.selectListByPaging(pageVO);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/check/pick.jsp";
	}
	
	
	@RequestMapping("/member/search")
	public String memberSearch(
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword,
			Model model) {
		boolean isSearch = column != null && keyword != null;
		if(isSearch) {
			switch(column) {
			case "member_id":
			case "member_nick":
			case "member_contact":
			case "member_name":
			case "member_type":
			case "member_email":
			case "member_birth":
				List<MemberDto>list=memberDao.selectList(column, keyword);
				model.addAttribute("list", list);
			}
		}
		return "/WEB-INF/views/admin/member/search.jsp";
	}
	
	@GetMapping("/member/detail")
	public String memberDetail(@RequestParam String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("buyList", buyDao.selectList(memberId));
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	@GetMapping("/member/delete")
	public String memberDelete(@RequestParam String memberId) {
		memberDao.delete(memberId);
		return "redirect:search";
	}
	
	@GetMapping("/member/edit")
	public String edit(@RequestParam String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/admin/member/edit.jsp";
	}
	@PostMapping("/member/edit")
	public String memberEdit(@ModelAttribute MemberDto memberDto) {
		memberDao.updateMemberByAdmin(memberDto);
		return "redirect:detail?memberId="+memberDto.getMemberId();
	}
}
