package com.codeusgroup.codeus.calendar.model.vo;

import java.sql.Date;
import java.sql.Time;

public class Calendar {
	private String mId;
	private int scheNo;
	private String scheType;
	private String scheTitle;
	private String scheContent;
	private Date scheRegiDate;
	private Date scheStartDate;
	private String scheStartString;
	private Date scheEndDate;
	private String scheEndString;
	private String allDayYn;
	private int scheStatus;
	private String color;
	public Calendar() {}

	public Calendar(String mId, int scheNo, String scheType, String scheTitle, String scheContent, Date scheRegiDate,
			Date scheStartDate, String scheStartString, Date scheEndDate, String scheEndString, String allDayYn,
			int scheStatus, String color) {
		super();
		this.mId = mId;
		this.scheNo = scheNo;
		this.scheType = scheType;
		this.scheTitle = scheTitle;
		this.scheContent = scheContent;
		this.scheRegiDate = scheRegiDate;
		this.scheStartDate = scheStartDate;
		this.scheStartString = scheStartString;
		this.scheEndDate = scheEndDate;
		this.scheEndString = scheEndString;
		this.allDayYn = allDayYn;
		this.scheStatus = scheStatus;
		this.color = color;
	}

	public String getScheStartString() {
		return scheStartString;
	}

	public void setScheStartString(String scheStartString) {
		this.scheStartString = scheStartString;
	}

	public String getScheEndString() {
		return scheEndString;
	}

	public void setScheEndString(String scheEndString) {
		this.scheEndString = scheEndString;
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

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@Override
	public String toString() {
		return "Calendar [mId=" + mId + ", scheNo=" + scheNo + ", scheType=" + scheType + ", scheTitle=" + scheTitle
				+ ", scheContent=" + scheContent + ", scheRegiDate=" + scheRegiDate + ", scheStartDate=" + scheStartDate
				+ ", scheStartString=" + scheStartString + ", scheEndDate=" + scheEndDate + ", scheEndString="
				+ scheEndString + ", allDayYn=" + allDayYn + ", scheStatus=" + scheStatus + ", color=" + color + "]";
	}
}