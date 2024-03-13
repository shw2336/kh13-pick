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

import com.kh.rushpickme.dao.BuyDao;
import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.MemberDto;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BuyDao buyDao;

	
	
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
	
	@RequestMapping("/member/detail")
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
	
	
	@RequestMapping("/member/approvePicker")
	public String approvePicker(@RequestParam String memberId, Model model) {
		memberDao.approvePicker(memberId);
		List<MemberDto> list = memberDao.selectList("member_type", "picker");
		model.addAttribute("pickerList", list);
		return "/WEB-INF/views/admin/member/pickerlist.jsp";
	}
}
