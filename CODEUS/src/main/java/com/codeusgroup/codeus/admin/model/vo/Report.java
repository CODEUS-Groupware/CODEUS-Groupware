package com.codeusgroup.codeus.admin.model.vo;

import java.sql.Date;

public class Report {
	private int reportNo;
	private String reportType;
	private Date reportDate;
	private int reportStatus;
	private int bNum;
	private String bTitle;
	private String bType;
	private String bStatus;
	private int replyNo;
	private String replyContent;
	private int rStatus;
	private String writerName;
	private String writerJobName;
	
	public Report() {}

	public Report(int reportNo, String reportType, Date reportDate, int reportStatus, int bNum, String bTitle,
			String bType, String bStatus, int replyNo, String replyContent, int rStatus, String writerName,
			String writerJobName) {
		super();
		this.reportNo = reportNo;
		this.reportType = reportType;
		this.reportDate = reportDate;
		this.reportStatus = reportStatus;
		this.bNum = bNum;
		this.bTitle = bTitle;
		this.bType = bType;
		this.bStatus = bStatus;
		this.replyNo = replyNo;
		this.replyContent = replyContent;
		this.rStatus = rStatus;
		this.writerName = writerName;
		this.writerJobName = writerJobName;
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
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

	public int getbNum() {
		return bNum;
	}

	public void setbNum(int bNum) {
		this.bNum = bNum;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbType() {
		return bType;
	}

	public void setbType(String bType) {
		this.bType = bType;
	}

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public int getrStatus() {
		return rStatus;
	}

	public void setrStatus(int rStatus) {
		this.rStatus = rStatus;
	}

	public String getWriterName() {
		return writerName;
	}

	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}

	public String getWriterJobName() {
		return writerJobName;
	}

	public void setWriterJobName(String writerJobName) {
		this.writerJobName = writerJobName;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportType=" + reportType + ", reportDate=" + reportDate
				+ ", reportStatus=" + reportStatus + ", bNum=" + bNum + ", bTitle=" + bTitle + ", bType=" + bType
				+ ", bStatus=" + bStatus + ", replyNo=" + replyNo + ", replyContent=" + replyContent + ", rStatus="
				+ rStatus + ", writerName=" + writerName + ", writerJobName=" + writerJobName + "]";
	}

}
