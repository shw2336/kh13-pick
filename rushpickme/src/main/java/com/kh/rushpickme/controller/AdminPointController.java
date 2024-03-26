package com.kh.rushpickme.controller;

import java.io.File;
import java.io.IOException;
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

import com.kh.rushpickme.configuration.SettingConfiguration;
import com.kh.rushpickme.dao.AttachDao;
import com.kh.rushpickme.dao.PointDao;
import com.kh.rushpickme.dto.AttachDto;
import com.kh.rushpickme.dto.PointDto;
import com.kh.rushpickme.service.AttachService;

@Controller
@RequestMapping("/admin/point")
public class AdminPointController {
	@Autowired
	private AttachDao attachDao;
	@Autowired
	private PointDao pointDao;
	@Autowired
	private AttachService attachService;
	@Autowired
	private SettingConfiguration scf;
	
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/point/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute PointDto pointDto,
								@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
									
		//등록
		int pointNo = pointDao.getSequence();
		pointDto.setPointNo(pointNo);
		pointDao.insert(pointDto);
		
		if(!attach.isEmpty()) {
			int attachNo = attachService.save(attach);
			
		//연결
			pointDao.connect(pointNo, attachNo);
		}
		return "redirect:list";
}
	
		//포인트 상품 목록
	@RequestMapping("/list")
	public String list(Model model) {
		List<PointDto> list=pointDao.selectList();
		model.addAttribute("list", list);
		return "/WEB-INF/views/admin/point/list.jsp";
	}
	
	@RequestMapping("/image")
	public String image(@RequestParam int pointNo) {
		try {
			int attachNo = pointDao.findAttachNo(pointNo);
			return "redirect:/download?attachNo="+attachNo;
		}
		catch(Exception e) {
			return "redirect:https://via.placeholder.com/200x100";
		}
	}
	//삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int pointNo) {
		try {
			int attachNo = pointDao.findAttachNo(pointNo);
			attachService.remove(attachNo);
		}
		catch(Exception e) {}
		finally {
			pointDao.delete(pointNo);
		}
		return "redirect:list";
	}
	
	//수정
	@GetMapping("/edit")
	public String edit(@RequestParam int pointNo, Model model) {
		PointDto pointDto = pointDao.selectOne(pointNo);
		model.addAttribute("pointDto", pointDto);
		return "/WEB-INF/views/admin/point/edit.jsp";
	}
	@PostMapping("edit")
	public String edit(@ModelAttribute PointDto pointDto,
							@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		pointDao.update(pointDto);
		
		if(!attach.isEmpty()) {
			 try {
				 int attachNo = pointDao.findAttachNo(pointDto.getPointNo());
				 File dir = new File(scf.getPath());
				 File target = new File(scf.getPath());
				 target.delete();
				 attachDao.delete(attachNo);
			 }
			 catch(Exception e) {}
			 
			 int attachNo = attachDao.getSequence();
			 File dir = new File(scf.getPath());
			 File target = new File(dir, String.valueOf(attachNo));
			 attach.transferTo(target);
			 
			 AttachDto attachDto = new AttachDto();
			 attachDto.setAttachNo(attachNo);
			 attachDto.setAttachName(attach.getOriginalFilename());
			 attachDto.setAttachType(attach.getContentType());
			 attachDto.setAttachSize(attach.getSize());
			 attachDao.insert(attachDto);
			 
			 pointDao.connect(pointDto.getPointNo(), attachNo);
		}
		return "redirect:list";
	}
}
