package com.kh.rushpickme.vo;

import java.sql.Date;

public class ApplyRequestListVo {
	private int applyNo;
	private String applyAddress1;
	private int applyVinyl;
	private String applyHopeDate;
	private int pickPay;
	
	public ApplyRequestListVo() {
		super();
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
