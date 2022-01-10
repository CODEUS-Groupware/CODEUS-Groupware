package com.codeusgroup.codeus.commBoard.model.vo;

import java.sql.Date;

public class Report {
	
	private int reportId;
	private char reportType;
	private String reportCategory;
	private Date reportDate;
	private int reportStatus;
	private String mId;
	private int bId;
	private int rId;
	
	public Report(){}

	public Report(int reportId, char reportType, String reportCategory, Date reportDate, int reportStatus, String mId,
			int bId, int rId) {
		super();
		this.reportId = reportId;
		this.reportType = reportType;
		this.reportCategory = reportCategory;
		this.reportDate = reportDate;
		this.reportStatus = reportStatus;
		this.mId = mId;
		this.bId = bId;
		this.rId = rId;
	}

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public char getReportType() {
		return reportType;
	}

	public void setReportType(char reportType) {
		this.reportType = reportType;
	}

	public String getReportCategory() {
		return reportCategory;
	}

	public void setReportCategory(String reportCategory) {
		this.reportCategory = reportCategory;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public int getReportStatus() {
		return reportStatus;
	}

	public void setReportStatus(int reportStatus) {
		this.reportStatus = reportStatus;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	@Override
	public String toString() {
		return "Report [reportId=" + reportId + ", reportType=" + reportType + ", reportCategory=" + reportCategory
				+ ", reportDate=" + reportDate + ", reportStatus=" + reportStatus + ", mId=" + mId + ", bId=" + bId
				+ ", rId=" + rId + "]";
	}

	

}
