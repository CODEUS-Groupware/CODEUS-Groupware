package com.codeusgroup.codeus.address.model.vo;

public class Address {
	private int addrNum;
	private String myMId;
	private String mId;
	
	public Address() {}
	
	public Address(int addrNum, String myMId, String mId) {
		super();
		this.addrNum = addrNum;
		this.myMId = myMId;
		this.mId = mId;
	}

	public int getAddrNum() {
		return addrNum;
	}

	public void setAddrNum(int addrNum) {
		this.addrNum = addrNum;
	}

	public String getMyMId() {
		return myMId;
	}

	public void setMyMId(String myMId) {
		this.myMId = myMId;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	@Override
	public String toString() {
		return "Address [addrNum=" + addrNum + ", myMId=" + myMId + ", mId=" + mId + "]";
	}
}
