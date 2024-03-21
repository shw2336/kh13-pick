package com.kh.rushpickme.controller;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.service.KakaoService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/auth/kakao")
public class KakaoLoginController {
	
	  @Value("${kakao.client.id}")
	    private String client_id;

	    @Autowired
	    private KakaoService kakaoService;
	    @Autowired
	    private MemberDao memberDao;

	    @GetMapping("/callback")
	    public String callback(HttpSession session ,@RequestParam("code") String code) throws IOException {
	        String accessToken = kakaoService.getAccessTokenFromKakao(client_id, code);
	        HashMap<String, Object> userInfo = kakaoService.getUserInfo(accessToken);
	        log.info("id : " + userInfo.get("id"));
	        // User 로그인, 또는 회원가입 로직 추가0
	       
	        String loginId = memberDao.getId(userInfo.get("id"));
	        MemberDto findMemberDto = memberDao.selectOne(loginId);
	        System.out.println(loginId);
	        session.setAttribute("loginId", loginId);
			session.setAttribute("loginLevel", findMemberDto.getMemberType());
	        return "redirect:/";
	    }
}
