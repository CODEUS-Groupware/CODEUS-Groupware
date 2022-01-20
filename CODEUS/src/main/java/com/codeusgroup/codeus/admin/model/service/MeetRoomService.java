package com.codeusgroup.codeus.admin.model.service;

import java.util.List;

import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;

public interface MeetRoomService {

	List<MeetingRoom> selectMeetRoomList();

	int insertMeetRoom(MeetingRoom meetRoom);

	MeetingRoom selectMeetRoom(int meet_no);

	int updateMeetRoom(MeetingRoom meetRoom);

	int deleteMeetRoom(int meet_no);

}
