package com.kh.rushpickme.vo;

import java.sql.Date;

public class PickFinishVo {

	private int pickNo;
	private Date applyDate;
	private Date pickFinishDate;
	private int pickPay;
	
	public PickFinishVo() {
		super();
	}
	public int getPickNo() {
		return pickNo;
	}
	public void setPickNo(int pickNo) {
		this.pickNo = pickNo;
	}

	public Date getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	public Date getPickFinishDate() {
		return pickFinishDate;
	}
	public void setPickFinishDate(Date pickFinishDate) {
		this.pickFinishDate = pickFinishDate;
	}
	public int getPickPay() {
		return pickPay;
	}
	public void setPickPay(int pickPay) {
		this.pickPay = pickPay;
	}
	
}
