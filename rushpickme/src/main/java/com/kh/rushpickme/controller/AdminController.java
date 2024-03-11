package com.kh.rushpickme.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.MemberDto;

public class AdminController {
	
	@Autowired
	private MemberDao memberDao;

	
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
		model.addAttribute(memberDto)
	}
}
