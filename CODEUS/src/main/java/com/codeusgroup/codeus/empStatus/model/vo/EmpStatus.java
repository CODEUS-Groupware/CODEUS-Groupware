package com.codeusgroup.codeus.empStatus.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class EmpStatus {
	private int empNum;
	private Date empRegiDate;
	private String empOnTime;
	private Timestamp empOffTime;
	private String empStatus;
	private String empQrCode;
	private String mId;
	
	public EmpStatus() {}

	public EmpStatus(int empNum, Date empRegiDate, String empOnTime, Timestamp empOffTime, String empStatus,
			String empQrCode, String mId) {
		super();
		this.empNum = empNum;
		this.empRegiDate = empRegiDate;
		this.empOnTime = empOnTime;
		this.empOffTime = empOffTime;
		this.empStatus = empStatus;
		this.empQrCode = empQrCode;
		this.mId = mId;
	}

	public int getEmpNum() {
		return empNum;
	}

	public void setEmpNum(int empNum) {
		this.empNum = empNum;
	}

	public Date getEmpRegiDate() {
		return empRegiDate;
	}

	public void setEmpRegiDate(Date empRegiDate) {
		this.empRegiDate = empRegiDate;
	}

	public String getEmpOnTime() {
		return empOnTime;
	}

	public void setEmpOnTime(String empOnTime) {
		this.empOnTime = empOnTime;
	}

	public Timestamp getEmpOffTime() {
		return empOffTime;
	}

	public void setEmpOffTime(Timestamp empOffTime) {
		this.empOffTime = empOffTime;
	}

	public String getEmpStatus() {
		return empStatus;
	}

	public void setEmpStatus(String empStatus) {
		this.empStatus = empStatus;
	}

	public String getEmpQrCode() {
		return empQrCode;
	}

	public void setEmpQrCode(String empQrCode) {
		this.empQrCode = empQrCode;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	@Override
	public String toString() {
		return "EmpStatus [empNum=" + empNum + ", empRegiDate=" + empRegiDate + ", empOnTime=" + empOnTime
				+ ", empOffTime=" + empOffTime + ", empStatus=" + empStatus + ", empQrCode=" + empQrCode + ", mId="
				+ mId + "]";
	}
	
	

}
