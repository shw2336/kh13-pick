package com.kh.rushpickme.dto;

public class MemberGreenDto {
	private String memberId;
	private String memberGreenPost;
	private String memberGreenAddress1;
	private String memberGreenAddress2;
	private int memberGreenPoint;
	private int memberGreenTicket;
	public MemberGreenDto() {
		super();
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberGreenPost() {
		return memberGreenPost;
	}
	public void setMemberGreenPost(String memberGreenPost) {
		this.memberGreenPost = memberGreenPost;
	}
	public String getMemberGreenAddress1() {
		return memberGreenAddress1;
	}
	public void setMemberGreenAddress1(String memberGreenAddress1) {
		this.memberGreenAddress1 = memberGreenAddress1;
	}
	public String getMemberGreenAddress2() {
		return memberGreenAddress2;
	}
	public void setMemberGreenAddress2(String memberGreenAddress2) {
		this.memberGreenAddress2 = memberGreenAddress2;
	}
	public int getMemberGreenTicket() {
		return memberGreenTicket;
	}
	public void setMemberGreenTicket(int memberGreenTicket) {
		this.memberGreenTicket = memberGreenTicket;
	}
	public int getMemberGreenPoint() {
		return memberGreenPoint;
	}
	public void setMemberGreenPoint(int memberGreenPoint) {
	    this.memberGreenPoint = memberGreenPoint;

	    // memberGreenPoint에 따라 memberGreenTicket을 자동으로 업데이트
	    if (memberGreenPoint >= 100000) {
	        this.memberGreenTicket = 5;
	    } else if (memberGreenPoint >= 50000) {
	        this.memberGreenTicket = 3;
	    } else if (memberGreenPoint >= 30000) {
	        this.memberGreenTicket = 2;
	    } else if (memberGreenPoint >= 10000) {
	        this.memberGreenTicket = 1;
	    }
	}
	
	
	
	
	
}
