package com.kh.rushpickme.dto;

import java.sql.Date;

public class PickDto {

	private int pickNo;
	private int applyNo;
	private String memberId;
	private float pickWeight;
	private int pickPay;
	private String pickSchedule;
	private String pickState;
	private String pickReject;
	private Date pickFinishDate;
	private String pickDelete;
	
	public String getPickDelete() {
		return pickDelete;
	}
	public void setPickDelete(String pickDelete) {
		this.pickDelete = pickDelete;
	}
	public Date getPickFinishDate() {
		return pickFinishDate;
	}
	public void setPickFinishDate(Date pickFinishDate) {
		this.pickFinishDate = pickFinishDate;
	}

	public PickDto() {
		super();
	}
	public int getPickNo() {
		return pickNo;
	}
	public void setPickNo(int pickNo) {
		this.pickNo = pickNo;
	}
	public int getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(int applyNo) {
		this.applyNo = applyNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public float getPickWeight() {
		return pickWeight;
	}
	public void setPickWeight(float pickWeight) {
		this.pickWeight = pickWeight;
	}
	public int getPickPay() {
		return pickPay;
	}
	public void setPickPay(int pickPay) {
		this.pickPay = pickPay;
	}

	public String getPickSchedule() {
		return pickSchedule;
	}
	public void setPickSchedule(String pickSchedule) {
		this.pickSchedule = pickSchedule;
	}
	public String getPickState() {
		return pickState;
	}
	public void setPickState(String pickState) {
		this.pickState = pickState;
	}
	public String getPickReject() {
		return pickReject;
	}
	public void setPickReject(String pickReject) {
		this.pickReject = pickReject;
	}
	
}
