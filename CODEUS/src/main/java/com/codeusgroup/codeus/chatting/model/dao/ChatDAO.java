package com.codeusgroup.codeus.chatting.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;

@Repository("chetDAO")
public class ChatDAO {

	public ArrayList<Message> selectChatroom(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chattingMapper.selectChatroom", userId);
	}

	public ArrayList<Message> selectMessage(SqlSessionTemplate sqlSession, String roomNum, String userId) {
		HashMap<String, String> map = new HashMap<>();
		map.put("roomNum", roomNum);
		map.put("userId", userId);
		
		return (ArrayList)sqlSession.selectList("chattingMapper.selectMessage", map);
	}

	public int insertMessage(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.insert("chattingMapper.insertMessage", map);
	}
}
