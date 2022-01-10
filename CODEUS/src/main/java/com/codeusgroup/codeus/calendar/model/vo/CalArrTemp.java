package com.codeusgroup.codeus.calendar.model.vo;

import java.util.Arrays;

public class CalArrTemp {
	private String mId;
	private String[] calNoArr;
	private int[] noInvitecalArr;
	
	public CalArrTemp() {
		// TODO Auto-generated constructor stub
	}

	public CalArrTemp(String mId, String[] calNoArr, int[] noInvitecalArr) {
		super();
		this.mId = mId;
		this.calNoArr = calNoArr;
		this.noInvitecalArr = noInvitecalArr;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String[] getCalNoArr() {
		return calNoArr;
	}

	public void setCalNoArr(String[] calNoArr) {
		this.calNoArr = calNoArr;
	}

	public int[] getNoInvitecalArr() {
		return noInvitecalArr;
	}

	public void setNoInvitecalArr(int[] noInvitecalArr) {
		this.noInvitecalArr = noInvitecalArr;
	}

	@Override
	public String toString() {
		return "CalArrTemp [mId=" + mId + ", calNoArr=" + Arrays.toString(calNoArr) + ", noInvitecalArr="
				+ Arrays.toString(noInvitecalArr) + "]";
	}
	
	
}
