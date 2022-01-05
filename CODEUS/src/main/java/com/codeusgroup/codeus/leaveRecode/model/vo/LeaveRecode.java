package com.codeusgroup.codeus.leaveRecode.model.vo;

import java.sql.Date;

public class LeaveRecode {
	private Date leaveUseDate;
	private String mId;
	private String leaveReason;
	private String leaveType;
	private String leaveStatus;
	private Date enrollDate;
	
	public LeaveRecode() {}

	

	



	public LeaveRecode(Date leaveUseDate, String mId, String leaveReason, String leaveType, String leaveStatus,
			Date enrollDate) {
		super();
		this.leaveUseDate = leaveUseDate;
		this.mId = mId;
		this.leaveReason = leaveReason;
		this.leaveType = leaveType;
		this.leaveStatus = leaveStatus;
		this.enrollDate = enrollDate;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Date getLeaveUseDate() {
		return leaveUseDate;
	}

	public void setLeaveUseDate(Date leaveUseDate) {
		this.leaveUseDate = leaveUseDate;
	}

	public String getmId() {
		return mId;
	}

	public String getLeaveStatus() {
		return leaveStatus;
	}



	public void setLeaveStatus(String leaveStatus) {
		this.leaveStatus = leaveStatus;
	}



	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getLeaveReason() {
		return leaveReason;
	}

	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}

	public String getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}







	@Override
	public String toString() {
		return "LeaveRecode [leaveUseDate=" + leaveUseDate + ", mId=" + mId + ", leaveReason=" + leaveReason
				+ ", leaveType=" + leaveType + ", leaveStatus=" + leaveStatus + ", enrollDate=" + enrollDate + "]";
	}



	
	
	

}
