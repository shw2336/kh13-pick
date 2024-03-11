package com.kh.rushpickme.dto;

public class PointDto {
	private int pointNo;
	private String pointName;
	private int pointPrice, pointCharge;
	public int getPointNo() {
		return pointNo;
	}
	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}
	public String getPointName() {
		return pointName;
	}
	public void setPointName(String pointName) {
		this.pointName = pointName;
	}
	public int getPointPrice() {
		return pointPrice;
	}
	public void setPointPrice(int pointPrice) {
		this.pointPrice = pointPrice;
	}
	public int getPointCharge() {
		return pointCharge;
	}
	public void setPointCharge(int pointCharge) {
		this.pointCharge = pointCharge;
	}
	public PointDto() {
		super();
	}
	
}
