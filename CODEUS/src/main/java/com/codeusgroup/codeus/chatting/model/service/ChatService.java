package com.codeusgroup.codeus.chatting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;

public interface ChatService {

	ArrayList<Message> selectChatroom(String userId);

	ArrayList<Message> selectMessage(String roomNum, String userId);

	int insertMessage(HashMap<String, String> map);

}
