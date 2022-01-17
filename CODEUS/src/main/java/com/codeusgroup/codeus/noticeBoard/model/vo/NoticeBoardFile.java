package com.codeusgroup.codeus.noticeBoard.model.vo;

import java.sql.Date;

public class NoticeBoardFile {
	private int fileNo;
	private String filePath;
	private Date uploadDate;
	private String fileOriginName;
	private String fileChangeName;
	private String fileThumbYn;
	private int fileStatus;
	private String tableName;
	private int bNum;
	private long fileSize;
	
	public NoticeBoardFile() {}

	public NoticeBoardFile(int fileNo, String filePath, Date uploadDate, String fileOriginName, String fileChangeName,
			String fileThumbYn, int fileStatus, String tableName, int bNum, long fileSize) {
		super();
		this.fileNo = fileNo;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.fileOriginName = fileOriginName;
		this.fileChangeName = fileChangeName;
		this.fileThumbYn = fileThumbYn;
		this.fileStatus = fileStatus;
		this.tableName = tableName;
		this.bNum = bNum;
		this.fileSize = fileSize;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getFileOriginName() {
		return fileOriginName;
	}

	public void setFileOriginName(String fileOriginName) {
		this.fileOriginName = fileOriginName;
	}

	public String getFileChangeName() {
		return fileChangeName;
	}

	public void setFileChangeName(String fileChangeName) {
		this.fileChangeName = fileChangeName;
	}

	public String getFileThumbYn() {
		return fileThumbYn;
	}

	public void setFileThumbYn(String fileThumbYn) {
		this.fileThumbYn = fileThumbYn;
	}

	public int getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(int fileStatus) {
		this.fileStatus = fileStatus;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public int getbNum() {
		return bNum;
	}

	public void setbNum(int bNum) {
		this.bNum = bNum;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long l) {
		this.fileSize = l;
	}

	@Override
	public String toString() {
		return "NoticeBoardFile [fileNo=" + fileNo + ", filePath=" + filePath + ", uploadDate=" + uploadDate
				+ ", fileOriginName=" + fileOriginName + ", fileChangeName=" + fileChangeName + ", fileThumbYn="
				+ fileThumbYn + ", fileStatus=" + fileStatus + ", tableName=" + tableName + ", bNum=" + bNum
				+ ", fileSize=" + fileSize + "]";
	}

}
