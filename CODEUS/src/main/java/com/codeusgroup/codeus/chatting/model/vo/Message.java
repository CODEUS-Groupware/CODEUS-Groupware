package com.codeusgroup.codeus.chatting.model.vo;

import java.sql.Timestamp;

public class Message {
	private int msgNum; // 메세지 번호
	private String msgContent; // 메세지 내용
	private Timestamp msgTime; // 메세지 보낸 시각
	private int msgStatus; // 메세지 상태
	
	private String sander; // 보낸사람 아이디
	private String mId; // 받는사람 아이디
	
	private String roomNum; // 방 번호
	
	public Message() {}
	
	public Message(int msgNum, String msgContent, Timestamp msgTime, int msgStatus, String sander, String mId,
			String roomNum) {
		super();
		this.msgNum = msgNum;
		this.msgContent = msgContent;
		this.msgTime = msgTime;
		this.msgStatus = msgStatus;
		this.sander = sander;
		this.mId = mId;
		this.roomNum = roomNum;
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
	
	public int getMsgStatus() {
		return msgStatus;
	}
	
	public void setMsgStatus(int msgStatus) {
		this.msgStatus = msgStatus;
	}
	
	public String getSander() {
		return sander;
	}
	
	public void setSander(String sander) {
		this.sander = sander;
	}
	
	public String getmId() {
		return mId;
	}
	
	public void setmId(String mId) {
		this.mId = mId;
	}
	
	public String getRoomNum() {
		return roomNum;
	}
	
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}
	
	@Override
	public String toString() {
		return "Message [msgNum=" + msgNum + ", msgContent=" + msgContent + ", msgTime=" + msgTime + ", msgStatus="
				+ msgStatus + ", sander=" + sander + ", mId=" + mId + ", roomNum=" + roomNum + "]";
	}
}
