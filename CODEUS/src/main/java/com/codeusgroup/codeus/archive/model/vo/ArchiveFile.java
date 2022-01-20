package com.codeusgroup.codeus.archive.model.vo;

import java.sql.Date;

public class ArchiveFile {
	private int archNo;
	private String path;
	private Date uploadDate;
	private String originName;
	private String changeName;
	private long size;
	private String extension;
	private int status;
	private String mId;
	private Integer folderId;
	private String folderName;
	
	public ArchiveFile() {}

	public ArchiveFile(int archNo, String path, Date uploadDate, String originName, String changeName, long size,
			String extension, int status, String mId, Integer folderId, String folderName) {
		super();
		this.archNo = archNo;
		this.path = path;
		this.uploadDate = uploadDate;
		this.originName = originName;
		this.changeName = changeName;
		this.size = size;
		this.extension = extension;
		this.status = status;
		this.mId = mId;
		this.folderId = folderId;
		this.folderName = folderName;
	}

	public int getArchNo() {
		return archNo;
	}

	public void setArchNo(int archNo) {
		this.archNo = archNo;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public Integer getFolderId() {
		return folderId;
	}

	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}

	public String getFolderName() {
		return folderName;
	}

	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}

	@Override
	public String toString() {
		return "ArchiveFile [archNo=" + archNo + ", path=" + path + ", uploadDate=" + uploadDate + ", originName="
				+ originName + ", changeName=" + changeName + ", size=" + size + ", extension=" + extension + ", status="
				+ status + ", mId=" + mId + ", folderId=" + folderId + ", folderName=" + folderName + "]";
	}
	
}
