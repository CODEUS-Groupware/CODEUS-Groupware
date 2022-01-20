package com.codeusgroup.codeus.chatting.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.address.model.exception.AddressException;
import com.codeusgroup.codeus.address.model.vo.Address;
import com.codeusgroup.codeus.chatting.exception.ChettingException;
import com.codeusgroup.codeus.chatting.model.service.ChatService;
import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class ChettingController {
	
	@Autowired
	private ChatService chService;
	
	@RequestMapping("chetList.ch")
	public ModelAndView chetListView(@ModelAttribute Chatroom ch, HttpServletRequest request, ModelAndView mv) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		ch.setMyMid(userId);
		
		ArrayList<Message> list = chService.selectChatroom(userId);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.setViewName("chetListView");
			return mv;
			
		} else {
			throw new ChettingException("채팅 목록 조회에 실패했습니다.");
		}
	}
	
	@RequestMapping("chetSearch.ch")
	public String chetSearchView() {
		return "chetSearchView";
	}
	
	@RequestMapping("chetRoom.ch")
	public String chetRoomView(@RequestParam("sander") String sander) {

	    return "chetRoomView";
	}
}
