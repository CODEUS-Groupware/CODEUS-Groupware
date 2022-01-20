package com.codeusgroup.codeus.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;

@Repository("meetDAO")
public class MeetRoomDAO {

	public List<MeetingRoom> selectMeetRoomList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("meetRoomMapper.selectMeetRoomList");
	}

	public int insertMeetRoom(SqlSessionTemplate sqlSession, MeetingRoom meetRoom) {
		return sqlSession.insert("meetRoomMapper.insertMeetRoom", meetRoom);
	}

	public MeetingRoom selectMeetRoom(SqlSessionTemplate sqlSession, int meet_no) {
		return sqlSession.selectOne("meetRoomMapper.selectMeetRoom", meet_no);
	}

	public int updateMeetRoom(SqlSessionTemplate sqlSession, MeetingRoom meetRoom) {
		return sqlSession.update("meetRoomMapper.updateMeetRoom", meetRoom);
	}

	public int deleteMeetRoom(SqlSessionTemplate sqlSession, int meet_no) {
		return sqlSession.update("meetRoomMapper.deleteMeetRoom", meet_no);
	}
	
}
