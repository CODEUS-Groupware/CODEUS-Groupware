package com.codeusgroup.codeus.annualLeave.model.vo;

import java.sql.Date;

public class AnnualLeave {
	private int annualNo;
	private int annualCount;
	private String annualType;
	private Date annualRegiDate;
	private String mId;
	private Date hireDate;
	private int comYear;
	private int comMonth;
	private int regiMonth;

	
	public AnnualLeave() {}

	

	public AnnualLeave(int annualNo, int annualCount, String annualType, Date annualRegiDate, String mId, Date hireDate) {
		super();
		this.annualNo = annualNo;
		this.annualCount = annualCount;
		this.annualType = annualType;
		this.annualRegiDate = annualRegiDate;
		this.mId = mId;
		this.hireDate = hireDate;
		
	}
	


	


	public AnnualLeave(int annualNo, int annualCount, String annualType, Date annualRegiDate, String mId, Date hireDate,
			int comYear) {
		super();
		this.annualNo = annualNo;
		this.annualCount = annualCount;
		this.annualType = annualType;
		this.annualRegiDate = annualRegiDate;
		this.mId = mId;
		this.hireDate = hireDate;
		this.comYear = comYear;
	}
	

	



	

	public AnnualLeave(int annualNo, int annualCount, String annualType, Date annualRegiDate, String mId, Date hireDate,
			int comYear, int comMonth, int regiMonth) {
		super();
		this.annualNo = annualNo;
		this.annualCount = annualCount;
		this.annualType = annualType;
		this.annualRegiDate = annualRegiDate;
		this.mId = mId;
		this.hireDate = hireDate;
		this.comYear = comYear;
		this.comMonth = comMonth;
		this.regiMonth = regiMonth;
	}

	

	public int getRegiMonth() {
		return regiMonth;
	}



	public void setRegiMonth(int regiMonth) {
		this.regiMonth = regiMonth;
	}



	public int getComMonth() {
		return comMonth;
	}



	public void setComMonth(int comMonth) {
		this.comMonth = comMonth;
	}



	public int getComYear() {
		return comYear;
	}



	public void setComYear(int comYear) {
		this.comYear = comYear;
	}



	public Date getHireDate() {
		return hireDate;
	}



	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
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
				+ ", annualRegiDate=" + annualRegiDate + ", mId=" + mId + ", hireDate=" + hireDate + ", comYear="
				+ comYear + ", comMonth=" + comMonth + ", regiMonth=" + regiMonth + "]";
	}






	



}
