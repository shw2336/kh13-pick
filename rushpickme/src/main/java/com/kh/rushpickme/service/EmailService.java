package com.kh.rushpickme.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dao.MemberDao;
import com.kh.rushpickme.dto.MemberDto;

@Service
public class EmailService {
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private MemberDao memberDao;
	
	//아이디 찾기
	public boolean sendMemberId(String memberNick) {
		MemberDto memberDto = memberDao.selectOneByMemberNick(memberNick);
		
		if(memberDto != null) {//존재하는 닉네임 이면!
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(memberDto.getMemberEmail());
			message.setSubject("[Rush] 아이디 찾기 결과 안내");
			message.setText("회원 님의 아이디는 " + memberDto.getMemberId() + "입니다");
			sender.send(message);
			return true;
		}
		else {//존재하지 않는 닉네임이라면
			return false;
		}
		
		
	}
	
	//비밀번호 찾기
	
	public void sendTempPassword(MemberDto memberDto) {
		String lower = "abcdefghijklmnopqrstuvwxyz";//3글자
		String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";//3글자
		String number = "0123456789";//1글자
		String special = "!@#$";//1글자
		
		Random r = new Random();//랜덤 도구
		StringBuffer buffer = new StringBuffer();//문자열 합성도구
		
		for(int i=0; i < 3; i++) {
			int pos = r.nextInt(lower.length());//lower에서의 랜덤위치
			buffer.append(lower.charAt(pos));//버퍼에 추가
		}
		for(int i=0; i < 3; i++) {
			int pos = r.nextInt(upper.length());//upper에서의 랜덤위치
			buffer.append(upper.charAt(pos));//버퍼에 추가
		}
		for(int i=0; i < 1; i++) {
			int pos = r.nextInt(number.length());//number에서의 랜덤위치
			buffer.append(number.charAt(pos));//버퍼에 추가
		}
		for(int i=0; i < 1; i++) {
			int pos = r.nextInt(special.length());//special에서의 랜덤위치
			buffer.append(special.charAt(pos));//버퍼에 추가
		}
		
		//생성한 비밀번호로 DB를 변경
		memberDto.setMemberPw(buffer.toString());//비밀번호 설정 후
		memberDao.updateMemberPw(memberDto);//변경 처리
		
		//이메일 발송
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(memberDto.getMemberEmail());
		message.setSubject("[KH정보교육원] 임시 비밀번호 안내");
		message.setText("임시 비밀번호는 " + memberDto.getMemberPw() + "입니다");
		
		sender.send(message);
	}
	
	
	
}
