package com.codeusgroup.codeus.empStatus.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.codeusgroup.codeus.empStatus.model.service.EmpStatusService;
import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.member.model.vo.Member;
@SessionAttributes("empStatus1")

@Controller
public class EmpStatusController {

	
	@Autowired
	private EmpStatusService esService;

	@RequestMapping("empStatusMain.em")
	public String empStatusMain(HttpSession session, HttpServletRequest request, Model model) {
		
		session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		EmpStatus empStatus = new EmpStatus(0, null, null, null, null, null, id);
		EmpStatus empStatus1 = esService.selectComTime(id);
		EmpStatus empOffTime = esService.selectOffTime(id);

		model.addAttribute("empStatus1", empStatus1);
		model.addAttribute("empOffTime", empOffTime);	
		
		System.out.println("안녕");
		return "empStatusMain";
	}

	@RequestMapping("empStatusTotal.em")
	public String empStatusTotal(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		
		 EmpStatus empStatus1 = esService.selectComTime(id);
		 
		 model.addAttribute("empStatus1", empStatus1);
		return "empStatusTotal";
	}

//	@RequestMapping("annualLeaveMain.em")
//	public String annualLeaveMain(HttpServletRequest request, Model model) {
//		HttpSession session = request.getSession();
//		Member member = (Member)session.getAttribute("loginUser");
//		String id = member.getmId();
//		
//		 EmpStatus empStatus1 = esService.selectComTime(id);
//		 
//		 model.addAttribute("empStatus1", empStatus1);
//		return "annualLeaveMain";
//	}

	@RequestMapping("comTime.em")
	public void insertComTime(@ModelAttribute EmpStatus empStatus, @RequestParam("nowTime") String nowTime,
			@RequestParam("day") Date day, HttpServletResponse response, HttpServletRequest request, Model model) {

		response.setContentType("application/json; charset=UTF-8");
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		empStatus = new EmpStatus(0, null, null, null, null, null, id);

		int result = esService.insertComTime(empStatus);

		// 로그인 정보 담아서 보내기..
		EmpStatus empStatus1 = esService.selectComTime(id);
		System.out.println("출근:" + empStatus1);

		model.addAttribute("empStatus1", empStatus1);
		System.out.println("empStatus.get():" + empStatus1.getEmpOnTime());
		
		Gson gson = new GsonBuilder().create();
		try {

			gson.toJson(empStatus1, response.getWriter());
		} catch (JsonIOException | IOException e) {

			e.printStackTrace();
		}
	}

	
	  @RequestMapping("offTime.em") 
	  public void updateOffTime(@ModelAttribute EmpStatus empStatus, @RequestParam("offTime") String offTime, 
			                    @RequestParam("off") Date off, HttpServletResponse response, HttpServletRequest request, Model model) {
	  
	  response.setContentType("application/json; charset=UTF-8");
	  
	  HttpSession session = request.getSession();
	  Member member = (Member)session.getAttribute("loginUser");
	  String id = member.getmId();

	  //java.sql.Date sqlDate = new java.sql.Date(day.getTime());
	
	  empStatus = new EmpStatus(0, null, null, null, null, null, id);

	  int result = esService.updateOffTime(empStatus);

	  //로그인 정보 담아서 보내기.. 
	  EmpStatus empStatus1 = esService.selectOffTime(id);
	  System.out.println("퇴근:"+empStatus1);
	 
	//  session.setAttribute("empStatus", empOffTime);

	  Gson gson = new GsonBuilder().create(); 
	  try { 
		  model.addAttribute("empStatus1", empStatus1);
		  gson.toJson(empStatus1,response.getWriter()); 
		  } catch (JsonIOException | IOException e) {
	  
			  e.printStackTrace();
		  }	  
	  }
	  
	  @RequestMapping("updateStatus.em")
	  public void updateStatus(@RequestParam(value="statusValue", required=false) String statusValue,
			  				   @ModelAttribute EmpStatus empStatus, @RequestParam("offTime") String offTime, 
			                    @RequestParam("off") Date off, HttpServletResponse response, HttpServletRequest request, Model model) {
		  response.setContentType("application/json; charset=UTF-8");
		  
		  HttpSession session = request.getSession();
		  Member member = (Member)session.getAttribute("loginUser");
		  String id = member.getmId();
		  
		  empStatus = new EmpStatus(0, null, null, null, statusValue, null, id);
		  Gson gson = new GsonBuilder().create();
		 
		  if(!statusValue.equals("업무상태선택")) {
			  //아이디 가져오기
			  int result = esService.updateStatus(empStatus);
			  //업무 종료를 클릭하면 현재시간이 퇴근시간으로  DB에 저장되게 함
			 if(statusValue.equals("업무종료")) {

				result = esService.updateOffTime(empStatus);
			 }

			try {
				empStatus = new EmpStatus(0, null, null, null, null, null, id);
				 EmpStatus empStatus1 = esService.selectComTime(id);
				 System.out.println("퇴근:"+empStatus1);

				 model.addAttribute("empStatus1", empStatus1);
				gson.toJson(empStatus1,response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			} 
		  
		  }
	  }	  
}
