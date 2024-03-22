package com.kh.rushpickme.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class QnaMemberNickVO {

	private int qnaNo;//글번호
	private String memberId;//작성자(회원아이디)
	private String memberNick;//닉네임
	private String qnaTitle;//제목
	private String qnaContent;//글내용
	private String qnaDelete;//삭제여부
	private int qnaHits;//조회수
	private Date qnaWrite;//작성날짜
	private Date qnaEdit;//수정날짜
	
	private int qnaGroup;//그룹번호
	private Integer qnaTarget;//원본글번호
	private int qnaDepth;//차수
	
	
	public QnaMemberNickVO() {
		super();
	}
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public String getQnaDelete() {
		return qnaDelete;
	}
	public void setQnaDelete(String qnaDelete) {
		this.qnaDelete = qnaDelete;
	}
	public int getQnaHits() {
		return qnaHits;
	}
	public void setQnaHits(int qnaHits) {
		this.qnaHits = qnaHits;
	}
	public Date getQnaWrite() {
		return qnaWrite;
	}
	public void setQnaWrite(Date qnaWrite) {
		this.qnaWrite = qnaWrite;
	}
	public Date getQnaEdit() {
		return qnaEdit;
	}
	public void setQnaEdit(Date qnaEdit) {
		this.qnaEdit = qnaEdit;
	}
	public int getQnaGroup() {
		return qnaGroup;
	}
	public void setQnaGroup(int qnaGroup) {
		this.qnaGroup = qnaGroup;
	}
	public Integer getQnaTarget() {
		return qnaTarget;
	}
	public void setQnaTarget(Integer qnaTarget) {
		this.qnaTarget = qnaTarget;
	}
	public int getQnaDepth() {
		return qnaDepth;
	}
	public void setQnaDepth(int qnaDepth) {
		this.qnaDepth = qnaDepth;
	}
	
	public String getMemberIdStr() {
		if(memberId == null)
			return "탈퇴한사용자";
		else
			return memberId;
	}
	
	public String getMemberNickStr() {
	if(memberId == null)
		return "탈퇴한사용자";
	else
		return memberNick;
}

	//오늘 작성한 글은 시간을, 이전에 작성한 글은 날짜를 반환
	//- LocalDate 형태로 시간을 변환하여 오늘 날짜와 비교
	//- 날짜가 같다면 LocalDateTime으로 변환해서 시간만 반환
	//- 날짜가 다르다면 LocalDate를 그대로 반환
	public String getQnaWriteStr() {
		LocalDate today = LocalDate.now();//오늘날짜
		LocalDate wtime = qnaWrite.toLocalDate();//작성일자
		if(wtime.equals(today)) {//작성일이 오늘이면
			//Date ---> Timestamp ---> LocalDateTime ---> LocalTime
			Timestamp stamp = new Timestamp(qnaWrite.getTime());
			LocalDateTime time = stamp.toLocalDateTime();
			LocalTime result = time.toLocalTime();
			return result.toString();//시간 반환
		}
		else {//작성일이 이전이면
			return wtime.toString();//날짜 반환
		}
	}
	
	//현재시각을 기준으로 얼마나 지난 글인지를 계산하여 반환
	public String getQnaWriteDiff() {
		long now = System.currentTimeMillis();
		long before = qnaWrite.getTime();
		long gap = now - before;
		gap /= 1000;//초로 변경
		
		if(gap < 60) {//1분 미만은 방금 전으로 표시
			return "방금 전";
		}
		else if(gap < 60 * 60) {//1시간 미만은 분으로 표시
			return gap / 60 + "분 전";
		}
		else if(gap < 24 * 60 * 60) {//1일 미만은 시간으로 표시
			return gap / 60 / 60 + "시간 전";
		}
		else if(gap < 7 * 24 * 60 * 60) {//7일 미만은 일로 표시
			return gap / 24 / 60 / 60 + "일 전";
		}
		else if(gap < 30 * 24 * 60 * 60) {//한달 미만은 주로 표시
			return gap / 7 / 24 / 60 / 60 + "주 전";
		}
		else if(gap < 1 * 365 * 24 * 60 * 60) {//1년 미만은 개월로 표시
			return gap / 30 / 24 / 60 / 60  + "개월 전";
		}
		else if(gap < 10 * 365 * 24 * 60 * 60) {//10년 미만은 연으로 표시
			return gap / 365 / 24 / 60 / 60 + "년 전";
		}
		else {//나머지는 오래전으로 표시
			return "오래 전";
		}
	}
	
	
	

}
