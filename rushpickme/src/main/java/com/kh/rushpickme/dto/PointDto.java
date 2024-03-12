package com.kh.rushpickme.dto;

public class PointDto {
	private int pointNo;
	private String pointName;
	private int pointSell, pointCharge;
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
	public int getPointSell() {
		return pointSell;
	}
	public void setPointSell(int pointSell) {
		this.pointSell = pointSell;
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