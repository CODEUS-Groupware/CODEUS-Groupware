package com.codeusgroup.codeus.commBoard.model.vo;

import java.sql.Date;

public class Reply {
	private int rId;
	private String rContent;
	private Date rCreateDate;
	private Date rModifyDate;
	private String rStatus;
	private int refBid;
	private String rWriter;
	
	public Reply() {}

	public Reply(int rId, String rContent, Date rCreateDate, Date rModifyDate, String rStatus, int refBid,
			String rWriter) {
		super();
		this.rId = rId;
		this.rContent = rContent;
		this.rCreateDate = rCreateDate;
		this.rModifyDate = rModifyDate;
		this.rStatus = rStatus;
		this.refBid = refBid;
		this.rWriter = rWriter;
	}

	public int getrId() {
		return rId;
	}

	public void setrId(int rId) {
		this.rId = rId;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public Date getrCreateDate() {
		return rCreateDate;
	}

	public void setrCreateDate(Date rCreateDate) {
		this.rCreateDate = rCreateDate;
	}

	public Date getrModifyDate() {
		return rModifyDate;
	}

	public void setrModifyDate(Date rModifyDate) {
		this.rModifyDate = rModifyDate;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}

	public int getRefBid() {
		return refBid;
	}

	public void setRefBid(int refBid) {
		this.refBid = refBid;
	}

	public String getrWriter() {
		return rWriter;
	}

	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}

	@Override
	public String toString() {
		return "Reply [rId=" + rId + ", rContent=" + rContent + ", rCreateDate=" + rCreateDate + ", rModifyDate="
				+ rModifyDate + ", rStatus=" + rStatus + ", refBid=" + refBid + ", rWriter=" + rWriter + "]";
	}

	
	
}
