package com.codeusgroup.codeus.document.model.vo;

import java.sql.Date;

public class Document {
	private int docNum;
	private String docName;
	private String docContent;
	private Date docCreateDate;
	private Date docUpdateDate;
	private String docDeleteYn;
	private int docApprovalStatus;
	private Date docApprovalDate;
	private Date docStartDate;
	private Date docEndDate;
	private String drafterMId;
	private String approvalMId;
	private int formNum;
	
	public Document() {}

	public Document(int docNum, String docName, String docContent, Date docCreateDate, Date docUpdateDate,
			String docDeleteYn, int docApprovalStatus, Date docApprovalDate, Date docStartDate, Date docEndDate,
			String drafterMId, String approvalMId, int formNum) {
		super();
		this.docNum = docNum;
		this.docName = docName;
		this.docContent = docContent;
		this.docCreateDate = docCreateDate;
		this.docUpdateDate = docUpdateDate;
		this.docDeleteYn = docDeleteYn;
		this.docApprovalStatus = docApprovalStatus;
		this.docApprovalDate = docApprovalDate;
		this.docStartDate = docStartDate;
		this.docEndDate = docEndDate;
		this.drafterMId = drafterMId;
		this.approvalMId = approvalMId;
		this.formNum = formNum;
	}

	public int getDocNum() {
		return docNum;
	}

	public void setDocNum(int docNum) {
		this.docNum = docNum;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	public String getDocContent() {
		return docContent;
	}

	public void setDocContent(String docContent) {
		this.docContent = docContent;
	}

	public Date getDocCreateDate() {
		return docCreateDate;
	}

	public void setDocCreateDate(Date docCreateDate) {
		this.docCreateDate = docCreateDate;
	}

	public Date getDocUpdateDate() {
		return docUpdateDate;
	}

	public void setDocUpdateDate(Date docUpdateDate) {
		this.docUpdateDate = docUpdateDate;
	}

	public String getDocDeleteYn() {
		return docDeleteYn;
	}

	public void setDocDeleteYn(String docDeleteYn) {
		this.docDeleteYn = docDeleteYn;
	}

	public int getDocApprovalStatus() {
		return docApprovalStatus;
	}

	public void setDocApprovalStatus(int docApprovalStatus) {
		this.docApprovalStatus = docApprovalStatus;
	}

	public Date getDocApprovalDate() {
		return docApprovalDate;
	}

	public void setDocApprovalDate(Date docApprovalDate) {
		this.docApprovalDate = docApprovalDate;
	}

	public Date getDocStartDate() {
		return docStartDate;
	}

	public void setDocStartDate(Date docStartDate) {
		this.docStartDate = docStartDate;
	}

	public Date getDocEndDate() {
		return docEndDate;
	}

	public void setDocEndDate(Date docEndDate) {
		this.docEndDate = docEndDate;
	}

	public String getDrafterMId() {
		return drafterMId;
	}

	public void setDrafterMId(String drafterMId) {
		this.drafterMId = drafterMId;
	}

	public String getApprovalMId() {
		return approvalMId;
	}

	public void setApprovalMId(String approvalMId) {
		this.approvalMId = approvalMId;
	}

	public int getFormNum() {
		return formNum;
	}

	public void setFormNum(int formNum) {
		this.formNum = formNum;
	}

	@Override
	public String toString() {
		return "Document [docNum=" + docNum + ", docName=" + docName + ", docContent=" + docContent + ", docCreateDate="
				+ docCreateDate + ", docUpdateDate=" + docUpdateDate + ", docDeleteYn=" + docDeleteYn
				+ ", docApprovalStatus=" + docApprovalStatus + ", docApprovalDate=" + docApprovalDate
				+ ", docStartDate=" + docStartDate + ", docEndDate=" + docEndDate + ", drafterMId=" + drafterMId
				+ ", approvalMId=" + approvalMId + ", formNum=" + formNum + "]";
	}

}