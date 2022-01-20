package com.codeusgroup.codeus.admin.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.admin.model.dao.MeetRoomDAO;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;

@Service("meetService")
public class MeetRoomServiceImpl implements MeetRoomService {
	
	@Autowired
	private MeetRoomDAO meetDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<MeetingRoom> selectMeetRoomList() {
		return meetDAO.selectMeetRoomList(sqlSession);
	}

	@Override
	public int insertMeetRoom(MeetingRoom meetRoom) {
		return meetDAO.insertMeetRoom(sqlSession, meetRoom);
	}

	@Override
	public MeetingRoom selectMeetRoom(int meet_no) {
		return meetDAO.selectMeetRoom(sqlSession, meet_no);
	}

	@Override
	public int updateMeetRoom(MeetingRoom meetRoom) {
		return meetDAO.updateMeetRoom(sqlSession, meetRoom);
	}

	@Override
	public int deleteMeetRoom(int meet_no) {
		return meetDAO.deleteMeetRoom(sqlSession, meet_no);
	}
	
	
}
