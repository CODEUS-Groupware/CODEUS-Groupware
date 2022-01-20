package com.codeusgroup.codeus.leaveRecode.model.vo;

import java.sql.Date;

public class LeaveRecode {
	private Date leaveUseDate;
	private String mId;
	private String leaveReason;
	private String leaveType;
	private String leaveStatus;
	private Date enrollDate;
	private int totalLeave;
	private int usedLeave;
	private int restLeveCount;
	private String leaveName;
	private String formName;
	private int leaveNum;
	
	
	public LeaveRecode() {}

	public LeaveRecode(Date leaveUseDate, String mId, String leaveReason, String leaveType, String leaveStatus,
			Date enrollDate, int totalLeave, int usedLeave, int restLeveCount) {
		super();
		this.leaveUseDate = leaveUseDate;
		this.mId = mId;
		this.leaveReason = leaveReason;
		this.leaveType = leaveType;
		this.leaveStatus = leaveStatus;
		this.enrollDate = enrollDate;
		this.totalLeave = totalLeave;
		this.usedLeave = usedLeave;
		this.restLeveCount = restLeveCount;
	}
	

	
	
	

	
	
	

	public LeaveRecode(Date leaveUseDate, String mId, String leaveReason, String leaveType, String leaveStatus,
			Date enrollDate, int totalLeave, int usedLeave, int restLeveCount, String leaveName, String formName,
			int leaveNum) {
		super();
		this.leaveUseDate = leaveUseDate;
		this.mId = mId;
		this.leaveReason = leaveReason;
		this.leaveType = leaveType;
		this.leaveStatus = leaveStatus;
		this.enrollDate = enrollDate;
		this.totalLeave = totalLeave;
		this.usedLeave = usedLeave;
		this.restLeveCount = restLeveCount;
		this.leaveName = leaveName;
		this.formName = formName;
		this.leaveNum = leaveNum;
		
	}

	
	

	public int getLeaveNum() {
		return leaveNum;
	}

	public void setLeaveNum(int leaveNum) {
		this.leaveNum = leaveNum;
	}

	public String getLeaveName() {
		return leaveName;
	}

	public void setLeaveName(String leaveName) {
		this.leaveName = leaveName;
	}

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	public int getTotalLeave() {
		return totalLeave;
	}

	public void setTotalLeave(int totalLeave) {
		this.totalLeave = totalLeave;
	}

	public int getUsedLeave() {
		return usedLeave;
	}


	public void setUsedLeave(int usedLeave) {
		this.usedLeave = usedLeave;
	}

	public int getRestLeveCount() {
		return restLeveCount;
	}


	public void setRestLeveCount(int restLeveCount) {
		this.restLeveCount = restLeveCount;
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
				+ ", leaveType=" + leaveType + ", leaveStatus=" + leaveStatus + ", enrollDate=" + enrollDate
				+ ", totalLeave=" + totalLeave + ", usedLeave=" + usedLeave + ", restLeveCount=" + restLeveCount
				+ ", leaveName=" + leaveName + ", formName=" + formName + ", leaveNum=" + leaveNum    + "]";
	}

	

	
	
	

}
