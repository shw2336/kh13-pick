package com.kh.rushpickme.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

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
		message.setSubject("[Rush] 비밀번호 ");
		message.setText(memberDto.getMemberName()+"님의"+"임시 비밀번호는 " + memberDto.getMemberPw() + "입니다");
		
		sender.send(message);
	}
	
	public void sendWelcomeMail(String memberemail, @ModelAttribute MemberDto memberDto) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(memberemail);
		message.setSubject("[Rush] 가입을 환영합니다");
		message.setText("회원님의 가입 정보를 알려 드립니다"
						+"아이디"+memberDto.getMemberId()	
						+"이름"+memberDto.getMemberName()
						+"생년월일"+memberDto.getMemberBirth()
						+"닉네임"+memberDto.getMemberNick()
						+"이메일"+memberDto.getMemberEmail()	
						+"많은 활동 부탁 드립니다 감사합니다."	);
		
		sender.send(message);
	}
	
	//수거완료처리시 후기작성 요청 메일 전송
	public void sendFinishMail(String email) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("[Rush Pick Me!] 수거 완료!");
		message.setText("후기작성을 부탁 드려요!");
		sender.send(message);
//		
//		MimeMessage message = mailSender.createMimeMessage();
//		MimeMessageHelper helper = new MimeMessageHelper(message, true);
//		helper.setTo(email);
//		helper.setSubject("[Rush Pick Me!] 수거 완료!");
//
//		String htmlContent = "<p>후기 작성을 부탁 드려요! 아래 링크를 클릭하여 후기를 작성해 주세요.</p>" +
//		                     "<p><a href=\"http://example.com/write_review\">후기 작성하기</a></p>";
//		helper.setText(htmlContent, true);
//
//		mailSender.send(message);
	}
	
}
