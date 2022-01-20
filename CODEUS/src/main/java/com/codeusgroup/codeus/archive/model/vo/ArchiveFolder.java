package com.codeusgroup.codeus.archive.model.vo;

public class ArchiveFolder {
	private Integer folderId;
	private String folderName;
	private Integer upperFolderId;
	private int folderLevel;
	
	public ArchiveFolder() {}

	public ArchiveFolder(Integer folderId, String folderName, Integer upperFolderId, int folderLevel) {
		super();
		this.folderId = folderId;
		this.folderName = folderName;
		this.upperFolderId = upperFolderId;
		this.folderLevel = folderLevel;
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

	public Integer getUpperFolderId() {
		return upperFolderId;
	}

	public void setUpperFolderId(Integer upperFolderId) {
		this.upperFolderId = upperFolderId;
	}

	public int getFolderLevel() {
		return folderLevel;
	}

	public void setFolderLevel(int folderLevel) {
		this.folderLevel = folderLevel;
	}

	@Override
	public String toString() {
		return "ArchiveFolder [folderId=" + folderId + ", folderName=" + folderName + ", upperFolderId=" + upperFolderId
				+ ", folderLevel=" + folderLevel + "]";
	}

	
}
