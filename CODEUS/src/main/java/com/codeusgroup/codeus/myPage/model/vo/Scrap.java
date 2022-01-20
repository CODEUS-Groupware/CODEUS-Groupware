package com.codeusgroup.codeus.myPage.model.vo;

import java.sql.Date;

public class Scrap {
	private String mId;
	private int bNum;
	private String bType;
	private String bTitle;
	private Date createDate;
	private String boardStatus;
	private String boardWriterName;
	private String boardWriterJob;
	
	public Scrap() {}

	public Scrap(String mId, int bNum, String bType, String bTitle, Date createDate, String boardStatus,
			String boardWriterName, String boardWriterJob) {
		super();
		this.mId = mId;
		this.bNum = bNum;
		this.bType = bType;
		this.bTitle = bTitle;
		this.createDate = createDate;
		this.boardStatus = boardStatus;
		this.boardWriterName = boardWriterName;
		this.boardWriterJob = boardWriterJob;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
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

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}

	public String getBoardWriterName() {
		return boardWriterName;
	}

	public void setBoardWriterName(String boardWriterName) {
		this.boardWriterName = boardWriterName;
	}

	public String getBoardWriterJob() {
		return boardWriterJob;
	}

	public void setBoardWriterJob(String boardWriterJob) {
		this.boardWriterJob = boardWriterJob;
	}

	@Override
	public String toString() {
		return "Scrap [mId=" + mId + ", bNum=" + bNum + ", bType=" + bType + ", bTitle=" + bTitle + ", createDate="
				+ createDate + ", boardStatus=" + boardStatus + ", boardWriterName=" + boardWriterName
				+ ", boardWriterjob=" + boardWriterJob + "]";
	}

	
}
