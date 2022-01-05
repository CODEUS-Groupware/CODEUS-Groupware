package com.codeusgroup.codeus.commBoard.model.vo;

import java.sql.Date;

public class CommBoard {

	
	private int bId;
	private String bType;
	private String bTitle;
	private String bContent;
	private int bViews;
	private String originalFileName;
	private String renameFileName;
	private Date bCreateDate;
	private Date bModifyDate;
	private String bStatus;
	private String bPin;
	private String bWriter;

	
	public CommBoard() {}


	public CommBoard(int bId, String bType, String bTitle, String bContent, int bViews, String originalFileName,
			String renameFileName, Date bCreateDate, Date bModifyDate, String bStatus, String bPin, String bWriter) {
		super();
		this.bId = bId;
		this.bType = bType;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bViews = bViews;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
		this.bCreateDate = bCreateDate;
		this.bModifyDate = bModifyDate;
		this.bStatus = bStatus;
		this.bPin = bPin;
		this.bWriter = bWriter;
	}


	public int getbId() {
		return bId;
	}


	public void setbId(int bId) {
		this.bId = bId;
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


	public int getbViews() {
		return bViews;
	}


	public void setbViews(int bViews) {
		this.bViews = bViews;
	}


	public String getOriginalFileName() {
		return originalFileName;
	}


	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}


	public String getRenameFileName() {
		return renameFileName;
	}


	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}


	public Date getbCreateDate() {
		return bCreateDate;
	}


	public void setbCreateDate(Date bCreateDate) {
		this.bCreateDate = bCreateDate;
	}


	public Date getbModifyDate() {
		return bModifyDate;
	}


	public void setbModifyDate(Date bModifyDate) {
		this.bModifyDate = bModifyDate;
	}


	public String getbStatus() {
		return bStatus;
	}


	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}


	public String getbPin() {
		return bPin;
	}


	public void setbPin(String bPin) {
		this.bPin = bPin;
	}


	public String getbWriter() {
		return bWriter;
	}


	public void setbWriter(String bWriter) {
		this.bWriter = bWriter;
	}


	@Override
	public String toString() {
		return "CommBoard [bId=" + bId + ", bType=" + bType + ", bTitle=" + bTitle + ", bContent=" + bContent
				+ ", bViews=" + bViews + ", originalFileName=" + originalFileName + ", renameFileName=" + renameFileName
				+ ", bCreateDate=" + bCreateDate + ", bModifyDate=" + bModifyDate + ", bStatus=" + bStatus + ", bPin="
				+ bPin + ", bWriter=" + bWriter + "]";
	}
	
}
	
