package com.kh.rushpickme.vo;

import java.sql.Date;

public class PickProceedVo {

	private int pickNo;
	private String applyAddress1;
	private int applyVinyl;
	private Date applyDate;
	private String applyHopeDate;
	private String timePasses;
	
	public PickProceedVo() {
		super();
	}
	public int getPickNo() {
		return pickNo;
	}
	public void setPickNo(int pickNo) {
		this.pickNo = pickNo;
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
	public String getTimePasses() {
		return timePasses;
	}
	public void setTimePasses(String timePasses) {
		this.timePasses = timePasses;
	}
	
}
