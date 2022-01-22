package com.codeusgroup.codeus.chatting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.address.model.dao.AddressDAO;
import com.codeusgroup.codeus.chatting.model.dao.ChatDAO;
import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("chetService")
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatDAO chDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Message> selectChatroom(String userId) {
		return chDAO.selectChatroom(sqlSession, userId);
	}

	@Override
	public ArrayList<Message> selectMessage(String roomNum, String userId) {
		return chDAO.selectMessage(sqlSession, roomNum, userId);
	}

	@Override
	public int insertMessage(HashMap<String, Object> map) {
		return chDAO.insertMessage(sqlSession, map);
	}

	@Override
	public ArrayList<Member> selectChatMember(String userId) {
		return chDAO.selectChatMember(sqlSession, userId);
	}
}
