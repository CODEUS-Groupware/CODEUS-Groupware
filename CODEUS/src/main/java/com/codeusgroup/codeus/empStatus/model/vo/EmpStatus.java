package com.codeusgroup.codeus.empStatus.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class EmpStatus {
	private int empNum;
	private Date empRegiDate;
	private Timestamp empOnTime;
	private Timestamp empOffTime;
	private String empStatus;
	private String empQrCode;
	private String mId;
	private Timestamp gapTime;
	private Timestamp overTime;
	private String strGapTime;
	private String strOverTime;
	
	public EmpStatus() {}

	

	public EmpStatus(int empNum, Date empRegiDate, Timestamp empOnTime, Timestamp empOffTime, String empStatus,
			String empQrCode, String mId, Timestamp gapTime, Timestamp overTime) {
		super();
		this.empNum = empNum;
		this.empRegiDate = empRegiDate;
		this.empOnTime = empOnTime;
		this.empOffTime = empOffTime;
		this.empStatus = empStatus;
		this.empQrCode = empQrCode;
		this.mId = mId;
		this.gapTime = gapTime;
		this.overTime = overTime;
	}

	

	public EmpStatus(int empNum, Date empRegiDate, Timestamp empOnTime, Timestamp empOffTime, String empStatus,
			String empQrCode, String mId, Timestamp gapTime, Timestamp overTime, String strGapTime,
			String strOverTime) {
		super();
		this.empNum = empNum;
		this.empRegiDate = empRegiDate;
		this.empOnTime = empOnTime;
		this.empOffTime = empOffTime;
		this.empStatus = empStatus;
		this.empQrCode = empQrCode;
		this.mId = mId;
		this.gapTime = gapTime;
		this.overTime = overTime;
		this.strGapTime = strGapTime;
		this.strOverTime = strOverTime;
	}

	

	public String getStrGapTime() {
		return strGapTime;
	}



	public void setStrGapTime(String strGapTime) {
		this.strGapTime = strGapTime;
	}



	public String getStrOverTime() {
		return strOverTime;
	}



	public void setStrOverTime(String strOverTime) {
		this.strOverTime = strOverTime;
	}



	public Timestamp getGapTime() {
		return gapTime;
	}



	public void setGapTime(Timestamp gapTime) {
		this.gapTime = gapTime;
	}



	public Timestamp getOverTime() {
		return overTime;
	}



	public void setOverTime(Timestamp overTime) {
		this.overTime = overTime;
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

	public Timestamp getEmpOnTime() {
		return empOnTime;
	}

	public void setEmpOnTime(Timestamp empOnTime) {
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
				+ mId + ", gapTime=" + gapTime + ", overTime=" + overTime + ", strGapTime=" + strGapTime
				+ ", strOverTime=" + strOverTime + "]";
	}




	

}
