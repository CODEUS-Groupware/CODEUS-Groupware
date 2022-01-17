package com.codeusgroup.codeus.noticeBoard.model.vo;

import java.sql.Date;

public class NoticeBoard {
	private int bNum;
	private String bType;
	private String bTitle;
	private String bContent;
	private int views;
	private Date createDate;
	private Date modifyDate;
	private int status;
	private String pin;
	private String mId;
	private String mName;
	private String jobName;
	private int replyCount;
	
	public NoticeBoard() {}

	public NoticeBoard(int bNum, String bType, String bTitle, String bContent, int views, Date createDate,
			Date modifyDate, int status, String pin, String mId, String mName, String jobName, int replyCount) {
		super();
		this.bNum = bNum;
		this.bType = bType;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.views = views;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.status = status;
		this.pin = pin;
		this.mId = mId;
		this.mName = mName;
		this.jobName = jobName;
		this.replyCount = replyCount;
	}

	public int getbNum() {
		return bNum;
	}

	public void setbNum(int bNum) {
		this.bNum = bNum;
	}

	public String getbType() {
		return bType;
	}

	public void setbType(String bType) {
		this.bType = bType;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	@Override
	public String toString() {
		return "NoticeBoard [bNum=" + bNum + ", bType=" + bType + ", bTitle=" + bTitle + ", bContent=" + bContent
				+ ", views=" + views + ", createDate=" + createDate + ", modifyDate=" + modifyDate + ", status="
				+ status + ", pin=" + pin + ", mId=" + mId + ", mName=" + mName + ", jobName=" + jobName
				+ ", replyCount=" + replyCount + "]";
	}

}
