package com.codeusgroup.codeus.chatting.model.vo;

import java.sql.Timestamp;

public class Chatroom {
	private String roomNum; // 방 번호
	private int groupNum; // 그룹 번호
	
	private String myMid; // 내 아이디
	private String myMname; // 내 이름
	
	private String sander; // 보낸사람 아이디
	private String sanderName; // 보낸사람 이름
	
	private int roomStatus; // 방 상태
	private int unReadCount; // 안 읽은 메시지 수
	
	public Chatroom() {}

	public Chatroom(String roomNum, int groupNum, String myMid, String myMname, String sander, String sanderName,
			int roomStatus, int unReadCount) {
		super();
		this.roomNum = roomNum;
		this.groupNum = groupNum;
		this.myMid = myMid;
		this.myMname = myMname;
		this.sander = sander;
		this.sanderName = sanderName;
		this.roomStatus = roomStatus;
		this.unReadCount = unReadCount;
	}

	public String getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}

	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}

	public String getMyMid() {
		return myMid;
	}

	public void setMyMid(String myMid) {
		this.myMid = myMid;
	}

	public String getMyMname() {
		return myMname;
	}

	public void setMyMname(String myMname) {
		this.myMname = myMname;
	}

	public String getSander() {
		return sander;
	}

	public void setSander(String sander) {
		this.sander = sander;
	}

	public String getSanderName() {
		return sanderName;
	}

	public void setSanderName(String sanderName) {
		this.sanderName = sanderName;
	}

	public int getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(int roomStatus) {
		this.roomStatus = roomStatus;
	}

	public int getUnReadCount() {
		return unReadCount;
	}

	public void setUnReadCount(int unReadCount) {
		this.unReadCount = unReadCount;
	}

	@Override
	public String toString() {
		return "Chatroom [roomNum=" + roomNum + ", groupNum=" + groupNum + ", myMid=" + myMid + ", myMname=" + myMname
				+ ", sander=" + sander + ", sanderName=" + sanderName + ", roomStatus=" + roomStatus + ", unReadCount="
				+ unReadCount + "]";
	}
}
