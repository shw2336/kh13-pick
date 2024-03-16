package com.kh.rushpickme.vo;

import java.util.Date;

public class ApplyListVO {
	private String memberId;
	private int applyNo;
	private String applyAddress1;
	private int applyVinyl;
	private Date applyDate;
	private String applyHopeDate;
	private int pickPay;
	
	public ApplyListVO() {
		super();
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(int applyNo) {
		this.applyNo = applyNo;
	}
	public String getApplyAddress1() {
		return applyAddress1;
	}
	public void setApplyAddress1(String applyAddress1) {
		this.applyAddress1 = applyAddress1;
	}
	public int getApplyVinyl() {
		return applyVinyl;
	}
	public void setApplyVinyl(int applyVinyl) {
		this.applyVinyl = applyVinyl;
	}
	public Date getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	public String getApplyHopeDate() {
		return applyHopeDate;
	}
	public void setApplyHopeDate(String applyHopeDate) {
		this.applyHopeDate = applyHopeDate;
	}
	public int getPickPay() {
		return pickPay;
	}
	public void setPickPay(int pickPay) {
		this.pickPay = pickPay;
	}
	
	
	

}