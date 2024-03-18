package com.kh.rushpickme.vo;

import java.sql.Date;

public class PickRejectVo {
	
	private int applyNo;
	private int pickNo;
	private String memberId;
	private Date applyDate;
	private String pickReject;
	
	public PickRejectVo() {
		super();
	}
	public int getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(int applyNo) {
		this.applyNo = applyNo;
	}
	public int getPickNo() {
		return pickNo;
	}
	public void setPickNo(int pickNo) {
		this.pickNo = pickNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Date getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	public String getPickReject() {
		return pickReject;
	}
	public void setPickReject(String pickReject) {
		this.pickReject = pickReject;
	}
	
}
