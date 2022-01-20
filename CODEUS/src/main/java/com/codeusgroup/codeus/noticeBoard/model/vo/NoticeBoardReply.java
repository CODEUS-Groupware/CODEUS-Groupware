package com.codeusgroup.codeus.noticeBoard.model.vo;

import java.sql.Date;

public class NoticeBoardReply {
	
	private int replyNo;
	private String replyContent;
	private Date replyCreateDate;
	private Date replyModifyDate;
	private int replyStatus;
	private String replyWriter;
	private String writerName;
	private String writerJobName;
	private Integer parentReplyNo;
	private int level;
	private int isLeaf; // 자식 노드가 있으면 0, 없으면 1
	private int refBNum;
	
	public NoticeBoardReply() {}

	public NoticeBoardReply(int replyNo, String replyContent, Date replyCreateDate, Date replyModifyDate,
			int replyStatus, String replyWriter, String writerName, String writerJobName, Integer parentReplyNo, int level,
			int isLeaf, int refBNum) {
		super();
		this.replyNo = replyNo;
		this.replyContent = replyContent;
		this.replyCreateDate = replyCreateDate;
		this.replyModifyDate = replyModifyDate;
		this.replyStatus = replyStatus;
		this.replyWriter = replyWriter;
		this.writerName = writerName;
		this.writerJobName = writerJobName;
		this.parentReplyNo = parentReplyNo;
		this.level = level;
		this.isLeaf = isLeaf;
		this.refBNum = refBNum;
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

	public Date getReplyCreateDate() {
		return replyCreateDate;
	}

	public void setReplyCreateDate(Date replyCreateDate) {
		this.replyCreateDate = replyCreateDate;
	}

	public Date getReplyModifyDate() {
		return replyModifyDate;
	}

	public void setReplyModifyDate(Date replyModifyDate) {
		this.replyModifyDate = replyModifyDate;
	}

	public int getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(int replyStatus) {
		this.replyStatus = replyStatus;
	}

	public String getReplyWriter() {
		return replyWriter;
	}

	public void setReplyWriter(String replyWriter) {
		this.replyWriter = replyWriter;
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

	public Integer getParentReplyNo() {
		return parentReplyNo;
	}

	public void setParentReplyNo(Integer parentReplyNo) {
		this.parentReplyNo = parentReplyNo;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(int isLeaf) {
		this.isLeaf = isLeaf;
	}

	public int getRefBNum() {
		return refBNum;
	}

	public void setRefBNum(int refBNum) {
		this.refBNum = refBNum;
	}

	@Override
	public String toString() {
		return "NoticeBoardReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyCreateDate="
				+ replyCreateDate + ", replyModifyDate=" + replyModifyDate + ", replyStatus=" + replyStatus
				+ ", replyWriter=" + replyWriter + ", writerName=" + writerName + ", writerJobName=" + writerJobName
				+ ", parentReplyNo=" + parentReplyNo + ", level=" + level + ", isLeaf=" + isLeaf + ", refBNum="
				+ refBNum + "]";
	}
	
}
