package com.kh.rushpickme.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.rushpickme.dao.PickDao;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.PickFinishVo;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/pick")
public class PickRestController {
	
	@Autowired
	private PickDao pickDao;
	
	@ResponseBody
	@RequestMapping("/order")
	public List <PickFinishVo> finishListOrderBy  (@RequestParam String orderBy, HttpSession session, PageVO pageVo, Model model) {
		String loginId = (String)session.getAttribute("loginId");
		int count = pickDao.countFinish(loginId);
		pageVo.setCount(count);
		List <PickFinishVo> finishListOrderBy = null;
		if (orderBy.equals("asc")) { //오름차순
			finishListOrderBy = pickDao.pickFinishListOrderBy(loginId, "asc", pageVo);
		}else if (orderBy.equals("desc")) { //내림차순
			finishListOrderBy = pickDao.pickFinishListOrderBy(loginId, "desc", pageVo);
		}
		model.addAttribute("finishListOrderBy", finishListOrderBy);
		return finishListOrderBy;
	}

}
