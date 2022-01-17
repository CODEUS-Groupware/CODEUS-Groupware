package com.codeusgroup.codeus.chetting.model.vo;

import java.sql.Timestamp;

public class Chetting {
	private int msgNum;
	private String msgContent;
	private Timestamp msgTime;
	private int roomNum;
	private int groupNum;
	private String sander;
	private String myMid;
	private int msgStatus;
	private int roomStatus;
	
	public Chetting() {}

	public Chetting(int msgNum, String msgContent, Timestamp msgTime, int roomNum, int groupNum, String sander,
			String myMid, int msgStatus, int roomStatus) {
		super();
		this.msgNum = msgNum;
		this.msgContent = msgContent;
		this.msgTime = msgTime;
		this.roomNum = roomNum;
		this.groupNum = groupNum;
		this.sander = sander;
		this.myMid = myMid;
		this.msgStatus = msgStatus;
		this.roomStatus = roomStatus;
	}

	public int getMsgNum() {
		return msgNum;
	}

	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public Timestamp getMsgTime() {
		return msgTime;
	}

	public void setMsgTime(Timestamp msgTime) {
		this.msgTime = msgTime;
	}

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}

	public String getSander() {
		return sander;
	}

	public void setSander(String sander) {
		this.sander = sander;
	}

	public String getMyMid() {
		return myMid;
	}

	public void setMyMid(String myMid) {
		this.myMid = myMid;
	}

	public int getMsgStatus() {
		return msgStatus;
	}

	public void setMsgStatus(int msgStatus) {
		this.msgStatus = msgStatus;
	}

	public int getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(int roomStatus) {
		this.roomStatus = roomStatus;
	}

	@Override
	public String toString() {
		return "Chetting [msgNum=" + msgNum + ", msgContent=" + msgContent + ", msgTime=" + msgTime + ", roomNum="
				+ roomNum + ", groupNum=" + groupNum + ", sander=" + sander + ", myMid=" + myMid + ", msgStatus="
				+ msgStatus + ", roomStatus=" + roomStatus + "]";
	}
	
	
}
