package com.kh.rushpickme.dto;

import java.sql.Date;

public class BuyDto {
	
	private int buyNo;
	private String memberId;
	private int pointNo;
	private Date buyDate;
	private int buyQty;
	private int buyTotal;
	private String pointName;
	
	public BuyDto() {
		super();
	}
	public int getBuyNo() {
		return buyNo;
	}
	public void setBuyNo(int buyNo) {
		this.buyNo = buyNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getPointNo() {
		return pointNo;
	}
	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}
	public Date getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}
	public int getBuyQty() {
		return buyQty;
	}
	public void setBuyQty(int buyQty) {
		this.buyQty = buyQty;
	}
	public int getBuyTotal() {
		return buyTotal;
	}
	public void setBuyTotal(int buyTotal) {
		this.buyTotal = buyTotal;
	}
	public String getPointName() {
		return pointName;
	}
	public void setPointName(String pointName) {
		this.pointName = pointName;
	}
	
	
	
	
}
