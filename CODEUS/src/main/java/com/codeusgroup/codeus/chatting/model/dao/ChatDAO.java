package com.codeusgroup.codeus.chatting.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;

@Repository("chetDAO")
public class ChatDAO {

	public ArrayList<Message> selectChatroom(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chattingMapper.selectChatroom", userId);
	}
}
