package com.codeusgroup.codeus.leaveRecode.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codeusgroup.codeus.leaveRecode.model.service.LeaveRecodeService;

@Controller
public class LeaveRecodeController {
	@Autowired
	private LeaveRecodeService lrService;
	
	@RequestMapping("leaveRecodeSearch.lr")
	public String leaveRecodeSearch(@RequestParam(value="page", required=false) Integer page, Model model) {
		
		return "";
	}
	

}
