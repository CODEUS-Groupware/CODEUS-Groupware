package com.codeusgroup.codeus.chatting.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;

@Repository("chetDAO")
public class ChatDAO {

	public ArrayList<Message> selectChatList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chattingMapper.selectChatList", userId);
	}

	public Chatroom selectChatRoom(SqlSessionTemplate sqlSession, String roomNum) {
		return sqlSession.selectOne("chatMapper.selectChatRoom", roomNum);
	}

	public int insertMessage(SqlSessionTemplate sqlSession, Message chatMessage) {
		return sqlSession.insert("chatMapper.insertMessage", chatMessage);
	}
	
}
