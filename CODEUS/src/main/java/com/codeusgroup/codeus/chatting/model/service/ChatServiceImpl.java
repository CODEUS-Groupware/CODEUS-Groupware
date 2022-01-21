package com.codeusgroup.codeus.chatting.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.address.model.dao.AddressDAO;
import com.codeusgroup.codeus.chatting.model.dao.ChatDAO;
import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;

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
}
