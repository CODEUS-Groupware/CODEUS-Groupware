package com.codeusgroup.codeus.chatting.model.vo;

import java.sql.Timestamp;

public class Chatroom {
	private String roomNum; // 방 번호
	private int roomStatus; // 방 상태
	
	public Chatroom() {}

	public Chatroom(String roomNum, int roomStatus) {
		super();
		this.roomNum = roomNum;
		this.roomStatus = roomStatus;
	}

	public String getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}

	public int getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(int roomStatus) {
		this.roomStatus = roomStatus;
	}

	@Override
	public String toString() {
		return "Chatroom [roomNum=" + roomNum + ", roomStatus=" + roomStatus + "]";
	}

	
}
