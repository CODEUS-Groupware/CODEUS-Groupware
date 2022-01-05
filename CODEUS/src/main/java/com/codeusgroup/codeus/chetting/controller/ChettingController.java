package com.codeusgroup.codeus.chetting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChettingController {
	
	@RequestMapping("chetList.ch")
	public String chetListView() {
		return "chetListView";
	}
	
	@RequestMapping("chetSearch.ch")
	public String chetSearchView() {
		return "chetSearchView";
	}
	
	@RequestMapping("chetRoom.ch")
	public String chetRoomView() {
		return "chetRoomView";
	}
}
