package com.codeusgroup.codeus.document.model.vo;

import java.sql.Date;

public class DocumentAgreement {
	private int agreeNum;
	private int agreeState;
	private Date agreeDate;
	private int docNum;
	private String mId;
	
	public DocumentAgreement() {}

	public DocumentAgreement(int agreeNum, int agreeState, Date agreeDate, int docNum, String mId) {
		super();
		this.agreeNum = agreeNum;
		this.agreeState = agreeState;
		this.agreeDate = agreeDate;
		this.docNum = docNum;
		this.mId = mId;
	}

	public int getAgreeNum() {
		return agreeNum;
	}

	public void setAgreeNum(int agreeNum) {
		this.agreeNum = agreeNum;
	}

	public int getAgreeState() {
		return agreeState;
	}

	public void setAgreeState(int agreeState) {
		this.agreeState = agreeState;
	}

	public Date getAgreeDate() {
		return agreeDate;
	}

	public void setAgreeDate(Date agreeDate) {
		this.agreeDate = agreeDate;
	}

	public int getDocNum() {
		return docNum;
	}

	public void setDocNum(int docNum) {
		this.docNum = docNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	@Override
	public String toString() {
		return "DocumentAgreement [agreeNum=" + agreeNum + ", agreeState=" + agreeState + ", agreeDate=" + agreeDate
				+ ", docNum=" + docNum + ", mId=" + mId + "]";
	}
	
}
