package com.kh.rushpickme.dto;

import java.sql.Date;

public class ReviewDto {

	private int reviewNo;//게시번호
	private int askNo;//신청번호
	private String memberId;//작성자(회원아이디)
	private String reviewStar;//별점
	private String reviewContent;//내용
	private String reviewDelete;//삭제여부
	private Date reviewWrite;//작성날짜
	private Date reviewEdit;//수정날짜
	
	public ReviewDto() {
		super();
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getAskNo() {
		return askNo;
	}
	public void setAskNo(int askNo) {
		this.askNo = askNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getReviewStar() {
		return reviewStar;
	}
	public void setReviewStar(String reviewStar) {
		this.reviewStar = reviewStar;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewDelete() {
		return reviewDelete;
	}
	public void setReviewDelete(String reviewDelete) {
		this.reviewDelete = reviewDelete;
	}
	public Date getReviewWrite() {
		return reviewWrite;
	}
	public void setReviewWrite(Date reviewWrite) {
		this.reviewWrite = reviewWrite;
	}
	public Date getReviewEdit() {
		return reviewEdit;
	}
	public void setReviewEdit(Date reviewEdit) {
		this.reviewEdit = reviewEdit;
	}
	
	
	
}
