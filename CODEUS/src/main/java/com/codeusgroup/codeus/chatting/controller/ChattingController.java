package com.codeusgroup.codeus.chatting.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.address.model.exception.AddressException;
import com.codeusgroup.codeus.address.model.vo.Address;
import com.codeusgroup.codeus.chatting.exception.ChattingException;
import com.codeusgroup.codeus.chatting.model.service.ChatService;
import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class ChattingController {
	
	@Autowired
	private ChatService chService;
	
	@RequestMapping("chatList.ch")
	public ModelAndView chetListView(@ModelAttribute Chatroom ch, HttpServletRequest request, ModelAndView mv) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		ArrayList<Message> list = chService.selectChatroom(userId);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.setViewName("chatListView");
			return mv;
			
		} else {
			throw new ChattingException("채팅 목록 조회에 실패했습니다.");
		}
	}
	
	@RequestMapping("chatSearch.ch")
	public String chetSearchView() {
		return "chatSearchView";
	}
	
	@RequestMapping("chatRoom.ch")
	public String chetRoomView(@RequestParam("roomNum") String roomNum) {

	    return "chatRoomView";
	}
}
