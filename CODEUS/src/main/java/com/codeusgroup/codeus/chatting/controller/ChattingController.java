package com.codeusgroup.codeus.chatting.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.address.common.Pagination;
import com.codeusgroup.codeus.address.model.exception.AddressException;
import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.chatting.exception.ChattingException;
import com.codeusgroup.codeus.chatting.model.service.ChatService;
import com.codeusgroup.codeus.chatting.model.vo.Chatroom;
import com.codeusgroup.codeus.chatting.model.vo.Message;
import com.codeusgroup.codeus.member.model.vo.Member;

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
	public ModelAndView chetSearchView(@RequestParam(value="page", required = false) Integer page,
			  					 HttpServletRequest request,
			  					 ModelAndView mv) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		ArrayList<Member> list = chService.selectChatMember(userId);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.setViewName("chatSearchView");
			
		} else {
			throw new AddressException("주소록 조회에 실패했습니다.");
		}
		
		//return "boardListView";
		return mv;
	}
	
	@RequestMapping("chatRoom.ch")
	public ModelAndView chetRoomView(HttpServletRequest request,
							   @RequestParam("roomNum") String roomNum,
							   ModelAndView mv) {
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		ArrayList<Message> list = chService.selectMessage(roomNum, userId);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.setViewName("chatRoomView");
			
		} else {
			throw new ChattingException("채팅 목록 조회에 실패했습니다.");
		}
		
	    return mv;
	}
	
	@RequestMapping("sandMsg.ch")
	@ResponseBody
	public String insertMessage(@RequestParam("msg") String msg,
							    @RequestParam("sander") String sander,
							    @RequestParam("roomNum") int roomNum,
							    HttpServletRequest request) {
	
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("msg", msg);
		map.put("sander", sander);
		map.put("userId", userId);
		map.put("roomNum", roomNum);
		
		int result = chService.insertMessage(map);
		
		if(result > 0) {
			
			System.out.println("메세지 전송");
			return "success";
			
		} else {
			throw new ChattingException("메세지 전송에 실패했습니다.");
		}
	}
	
	@RequestMapping("research.ch")
	public ModelAndView searchChatMember(@RequestParam(value="input", required = false) String input,
			  ModelAndView mv) {
	
	System.out.println(input);

	ArrayList<Member> list = chService.searchChatMember(input);
	
	if(list != null) {
	mv.addObject("list", list);
	mv.setViewName("chatResultView");
	
	} else {
	throw new ChattingException("대화상대 검색에 실패했습니다.");
	}
	return mv;
	}
	
	@RequestMapping("createChat.ch")
	@ResponseBody
	public String createChatting(@RequestParam("sander") String sander,
								 HttpServletRequest request) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		int result = chService.createChatting(userId, sander);
		
		if(result > 0) {
			
			System.out.println("채팅방 생성");
			return "success";
			
		} else {
			throw new ChattingException("채팅방 생성에 실패했습니다.");
		}
	}
}
