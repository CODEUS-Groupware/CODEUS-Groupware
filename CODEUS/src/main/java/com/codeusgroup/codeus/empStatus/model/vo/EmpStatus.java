package com.codeusgroup.codeus.empStatus.model.vo;

import java.sql.Timestamp;
import java.util.Date;

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
	private String deptId;
	private String jobId;
	private String deptName;
	private String jobName;
	private String mName;
	private int weekNum;
	private String monthOver;
	private String monthWork;
	
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
	
	



	

	


	public EmpStatus(int empNum, Date empRegiDate, Timestamp empOnTime, Timestamp empOffTime, String empStatus,
			String empQrCode, String mId, Timestamp gapTime, Timestamp overTime, String strGapTime, String strOverTime,
			String deptId, String jobId, String deptName, String jobName, String mName, int weekNum, String monthOver,
			String monthWork) {
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
		this.deptId = deptId;
		this.jobId = jobId;
		this.deptName = deptName;
		this.jobName = jobName;
		this.mName = mName;
		this.weekNum = weekNum;
		this.monthOver = monthOver;
		this.monthWork = monthWork;
	}

	

	public String getMonthOver() {
		return monthOver;
	}



	public void setMonthOver(String monthOver) {
		this.monthOver = monthOver;
	}



	public String getMonthWork() {
		return monthWork;
	}



	public void setMonthWork(String monthWork) {
		this.monthWork = monthWork;
	}



	public int getWeekNum() {
		return weekNum;
	}



	public void setWeekNum(int weekNum) {
		this.weekNum = weekNum;
	}



	public String getmName() {
		return mName;
	}



	public void setmName(String mName) {
		this.mName = mName;
	}



	public String getDeptName() {
		return deptName;
	}



	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}



	public String getJobName() {
		return jobName;
	}



	public void setJobName(String jobName) {
		this.jobName = jobName;
	}



	public String getDeptId() {
		return deptId;
	}



	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}



	public String getJobId() {
		return jobId;
	}



	public void setJobId(String jobId) {
		this.jobId = jobId;
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
				+ ", strOverTime=" + strOverTime + ", deptId=" + deptId + ", jobId=" + jobId + ", deptName=" + deptName
				+ ", jobName=" + jobName + ", mName=" + mName + ", weekNum=" + weekNum + ", monthOver=" + monthOver
				+ ", monthWork=" + monthWork + "]";
	}








	

}
