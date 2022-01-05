package com.codeusgroup.codeus.leaveRecode.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.codeusgroup.codeus.leaveRecode.model.service.LeaveRecodeService;

@Controller
public class LeaveRecodeController {
	@Autowired
	private LeaveRecodeService lrService;
	

}
