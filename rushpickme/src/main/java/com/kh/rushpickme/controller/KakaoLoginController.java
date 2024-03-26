package com.kh.rushpickme.controller;

import java.io.IOException;
import java.net.URISyntaxException;
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
	    public String callback(HttpSession session ,@RequestParam("code") String code) throws IOException, URISyntaxException {
	        String accessToken = kakaoService.getAccessTokenFromKakao(client_id, code);
	        HashMap<String, Object> userInfo = kakaoService.getUserInfo(accessToken);
	      
	        // 카카오 ID로 이미 가입되어 있는지 확인
	        String kakaoId = userInfo.get("id").toString();
	        String loginId = memberDao.getId(kakaoId);
	        
	        if (loginId == null) {
	            // 카카오 ID로 가입된 회원이 없는 경우, 회원가입 진행
	            MemberDto newMember = new MemberDto();
	            newMember.setKakaoId(kakaoId);
	            // 카카오로부터 받아온 다른 필요한 정보들을 여기에 추가
	            
	            // 회원 정보를 DB에 저장
	            memberDao.insert(newMember);
	            
	            // 가입한 회원의 ID를 가져옴
	            loginId = newMember.getMemberId(); // 수정된 부분
	        }
	        
	        // 로그인 정보 세션에 저장
	        MemberDto findMemberDto = memberDao.selectOne(loginId);
	        session.setAttribute("loginId", loginId);
	        session.setAttribute("loginLevel", findMemberDto.getMemberType());
	        
	        
	        
	        
	        
	        
//	        // User 로그인, 또는 회원가입 로직 추가0
//	       
//	        String loginId = memberDao.getId(userInfo.get("id"));
//	        MemberDto findMemberDto = memberDao.selectOne(loginId);
//	        System.out.println(loginId);
//	        session.setAttribute("loginId", loginId);
//			session.setAttribute("loginLevel", findMemberDto.getMemberType());
	        return "redirect:/";
	    }
}
