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
	
	@RequestMapping("/member/approveGreen")
	public String approveGreen(@RequestParam String memberId, Model model) {
		memberDao.approveGreen(memberId);
		List<MemberDto> list = memberDao.selectList("member_type", "green");
		model.addAttribute("greenList", list);
		return "/WEB-INF/views/admin/member/greenList.jsp";
	}
	
	@RequestMapping("/member/approvePicker")
	public String approvePicker(@RequestParam String memberId, Model model) {
		memberDao.approvePicker(memberId);
		List<MemberDto> list = memberDao.selectList("member_type", "picker");
		model.addAttribute("pickerList", list);
		return "/WEB-INF/views/admin/member/pickerList.jsp";
	}
}
