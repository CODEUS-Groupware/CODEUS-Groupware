package com.codeusgroup.codeus.commBoard.model.vo;

public class jjim {
	
	private String userid;
	private int bId;

	
	public jjim() {}


	public jjim(String userid, int bId) {
		super();
		this.userid = userid;
		this.bId = bId;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public int getbId() {
		return bId;
	}


	public void setbId(int bId) {
		this.bId = bId;
	}


	@Override
	public String toString() {
		return "jjim [userid=" + userid + ", bId=" + bId + "]";
	}
	
	
	
}
