package com.codeusgroup.codeus.annualLeave.model.vo;

import java.sql.Date;

public class AnnualLeave {
	private int annualNo;
	private int annualCount;
	private String annualType;
	private Date annualRegiDate;
	private String mId;

	
	public AnnualLeave() {}

	

	public AnnualLeave(int annualNo, int annualCount, String annualType, Date annualRegiDate, String mId) {
		super();
		this.annualNo = annualNo;
		this.annualCount = annualCount;
		this.annualType = annualType;
		this.annualRegiDate = annualRegiDate;
		this.mId = mId;
		
	}





	public int getAnnualNo() {
		return annualNo;
	}

	public void setAnnualNo(int annualNo) {
		this.annualNo = annualNo;
	}

	public int getAnnualCount() {
		return annualCount;
	}

	public void setAnnualCount(int annualCount) {
		this.annualCount = annualCount;
	}

	public String getAnnualType() {
		return annualType;
	}

	public void setAnnualType(String annualType) {
		this.annualType = annualType;
	}

	public Date getAnnualRegiDate() {
		return annualRegiDate;
	}

	public void setAnnualRegiDate(Date annualRegiDate) {
		this.annualRegiDate = annualRegiDate;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}



	@Override
	public String toString() {
		return "AnnualLeave [annualNo=" + annualNo + ", annualCount=" + annualCount + ", annualType=" + annualType
				+ ", annualRegiDate=" + annualRegiDate + ", mId=" + mId  + "]";
	}

	
}
