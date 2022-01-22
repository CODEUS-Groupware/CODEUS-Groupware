package com.codeusgroup.codeus.chatting.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("chetDAO")
public class ChatDAO {
	
	// 채팅방 목록 조회
	public ArrayList<Message> selectChatroom(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chattingMapper.selectChatroom", userId);
	}
	
	// 채팅방 내 메시지 조회
	public ArrayList<Message> selectMessage(SqlSessionTemplate sqlSession, String roomNum, String userId) {
		HashMap<String, String> map = new HashMap<>();
		map.put("roomNum", roomNum);
		map.put("userId", userId);
		
		return (ArrayList)sqlSession.selectList("chattingMapper.selectMessage", map);
	}
	
	// 전송 메시지 저장
	public int insertMessage(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("chattingMapper.insertMessage", map);
	}
	
	// 채팅방 검색 목록 조회
	public ArrayList<Member> selectChatMember(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chattingMapper.selectChatMember", userId);
	}
}
