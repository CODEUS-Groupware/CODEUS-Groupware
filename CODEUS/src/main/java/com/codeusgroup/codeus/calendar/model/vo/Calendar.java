package com.codeusgroup.codeus.calendar.model.vo;

import java.sql.Date;

public class Calendar {
	private String mId;
	private int scheNo;
	private String scheType;
	private String scheTitle;
	private String scheContent;
	private Date scheRegiDate;
	private Date scheStartDate;
	private Date scheEndDate;
	private String allDayYn;
	private int scheStatus;
	public Calendar() {}

	public Calendar(String mId, int scheNo, String scheType, String scheTitle, String scheContent, Date scheRegiDate,
			Date scheStartDate, Date scheEndDate, String allDayYn, int scheStatus) {
		super();
		this.mId = mId;
		this.scheNo = scheNo;
		this.scheType = scheType;
		this.scheTitle = scheTitle;
		this.scheContent = scheContent;
		this.scheRegiDate = scheRegiDate;
		this.scheStartDate = scheStartDate;
		this.scheEndDate = scheEndDate;
		this.allDayYn = allDayYn;
		this.scheStatus = scheStatus;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getScheNo() {
		return scheNo;
	}

	public void setScheNo(int scheNo) {
		this.scheNo = scheNo;
	}

	public String getScheType() {
		return scheType;
	}

	public void setScheType(String scheType) {
		this.scheType = scheType;
	}

	public String getScheTitle() {
		return scheTitle;
	}

	public void setScheTitle(String scheTitle) {
		this.scheTitle = scheTitle;
	}

	public String getScheContent() {
		return scheContent;
	}

	public void setScheContent(String scheContent) {
		this.scheContent = scheContent;
	}

	public Date getScheRegiDate() {
		return scheRegiDate;
	}

	public void setScheRegiDate(Date scheRegiDate) {
		this.scheRegiDate = scheRegiDate;
	}

	public Date getScheStartDate() {
		return scheStartDate;
	}

	public void setScheStartDate(Date scheStartDate) {
		this.scheStartDate = scheStartDate;
	}

	public Date getScheEndDate() {
		return scheEndDate;
	}

	public void setScheEndDate(Date scheEndDate) {
		this.scheEndDate = scheEndDate;
	}

	public String getAllDayYn() {
		return allDayYn;
	}

	public void setAllDayYn(String allDayYn) {
		this.allDayYn = allDayYn;
	}

	public int getScheStatus() {
		return scheStatus;
	}

	public void setScheStatus(int scheStatus) {
		this.scheStatus = scheStatus;
	}

	@Override
	public String toString() {
		return "Calendar [mId=" + mId + ", scheNo=" + scheNo + ", scheType=" + scheType + ", scheTitle=" + scheTitle
				+ ", scheContent=" + scheContent + ", scheRegiDate=" + scheRegiDate + ", scheStartDate=" + scheStartDate
				+ ", scheEndDate=" + scheEndDate + ", allDayYn=" + allDayYn + ", scheStatus=" + scheStatus + "]";
	}
}
