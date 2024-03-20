package com.kh.rushpickme.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@RequestMapping("/order")
	public List<PickFinishVo> finishListOrderBy  (@RequestParam String orderBy, HttpSession session, PageVO pageVo) {
		String loginId = (String)session.getAttribute("loginId");
		int count = pickDao.countFinish(loginId);
		pageVo.setCount(count);
		return pickDao.pickFinishListOrderBy(loginId, orderBy, pageVo);
	}

}
