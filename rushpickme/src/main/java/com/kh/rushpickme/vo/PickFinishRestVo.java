package com.kh.rushpickme.vo;

public class PickFinishRestVo {
	
	private int pickNo;
	private String applyDate;
	private String pickFinishDate;
	private int pickPay;
	
	public int getPickNo() {
		return pickNo;
	}
	public void setPickNo(int pickNo) {
		this.pickNo = pickNo;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public PickFinishRestVo() {
		super();
	}
	public String getPickFinishDate() {
		return pickFinishDate;
	}
	public void setPickFinishDate(String pickFinishDate) {
		this.pickFinishDate = pickFinishDate;
	}
	public int getPickPay() {
		return pickPay;
	}
	public void setPickPay(int pickPay) {
		this.pickPay = pickPay;
	}
	
}
