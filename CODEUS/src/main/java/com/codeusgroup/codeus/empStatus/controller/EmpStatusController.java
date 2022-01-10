package com.codeusgroup.codeus.empStatus.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;

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

import com.codeusgroup.codeus.empStatus.model.service.EmpStatusService;
import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
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
		EmpStatus empStatus = new EmpStatus(0, null, null, null, null, null, id, null, null);
		//EmpStatus empStatus1 = esService.selectComTime(id);
		EmpStatus empStatus1 = esService.selectOffTime(id);

		//이번주 누적시간 구하기
		EmpStatus empWeekTime = esService.selectWeekTime(id);
		System.out.println("이번주근무시간"+ empWeekTime);
		
		//이번달 누적시간 구하기
		EmpStatus empMonthTime = esService.selectMonthTime(id);
		//model.addAttribute("empStatus1", empStatus1);
		model.addAttribute("empStatus1", empStatus1);	
		model.addAttribute("empWeekTime", empWeekTime);
		model.addAttribute("empMonthTime", empMonthTime);
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
		String statusValue = "업무";
		empStatus = new EmpStatus(0, null, null, null, statusValue, null, id, null, null);

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
			                    @RequestParam("off") Date off, @RequestParam("status") String status,
			                    HttpServletResponse response, HttpServletRequest request, Model model) {
	  
	  response.setContentType("application/json; charset=UTF-8");
	  
	  HttpSession session = request.getSession();
	  Member member = (Member)session.getAttribute("loginUser");
	  String id = member.getmId();
	  System.out.println("업무상태:"+status);
	  //java.sql.Date sqlDate = new java.sql.Date(day.getTime());
	
	  empStatus = new EmpStatus(0, null, null, null, status, null, id, null, null);

	  int result = esService.updateOffTime(empStatus);

	  EmpStatus empStatus1 = esService.selectOffTime(id);
	  long ti = empStatus1.getEmpOffTime().getTime() - empStatus1.getEmpOnTime().getTime();	  
	  int tiSeconds = (int)(ti / 1000 % 60);
	  int tiMinutes = (int)(ti / (60 * 1000) % 60);
	  int tiHours = (int)(ti / (60 * 60 * 1000) % 24);
	  int tiDays = (int)(ti / (24 * 60 * 60 * 1000));
      int tiHours2 = 0;
      String gap = null;
      String over = null;
     // DateFormat df = new SimpleDateFormat("HH:mm:ss"); // HH=24h, hh=12h
     
		  if(tiHours >= 9) {
			  tiHours = 9;
			  gap =  tiHours + ":" + tiMinutes + ":" + tiSeconds;
			  tiHours2 = tiHours - 1;
			  over = tiHours + ":" + tiMinutes + ":" + tiSeconds;
			  System.out.println("갭타임"+tiMinutes);
		  }else {
			  gap =  tiHours + ":" + tiMinutes + ":" + tiSeconds; 
		  }
	   Date gapTime = new Date(new GregorianCalendar(0, 0, 0, tiHours, tiMinutes, tiSeconds).getTimeInMillis());
	  Date overTime = new Date(new GregorianCalendar(0, 0, 0, tiHours2, tiMinutes, tiSeconds).getTimeInMillis());
	 
	  EmpStatus emp = null;
		if(tiHours >= 9) {
			Timestamp gapTimeStamp = new Timestamp(gapTime.getTime()); 
			Timestamp overTimeStamp = new Timestamp(overTime.getTime()); 
			emp = new EmpStatus(0, null, null, null, null, null, id, gapTimeStamp, overTimeStamp);
			System.out.println("--------");
			System.out.println(emp);
			
		}else{
			Timestamp gapTimeStamp = new Timestamp(gapTime.getTime()); 
			
			emp = new EmpStatus(0, null, null, null, null, null, id, gapTimeStamp, null); 
			System.out.println(emp);
		}
		
	int result3 =  esService.updateGapTime(emp);
	empStatus1 = esService.selectOffTime(id);
	System.out.println("오프타임:"+empStatus1);
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
		  
		  empStatus = new EmpStatus(0, null, null, null, statusValue, null, id, null, null);
		  Gson gson = new GsonBuilder().create();
		 
		  if(!statusValue.equals("업무상태선택")) {
			  //아이디 가져오기
			  int result = esService.updateStatus(empStatus);
			  //업무 종료를 클릭하면 현재시간이 퇴근시간으로  DB에 저장되게 함
			 if(statusValue.equals("업무종료")) {

				result = esService.updateOffTime(empStatus);
			 }

			try {
				empStatus = new EmpStatus(0, null, null, null, null, null, id, null, null);
				 EmpStatus empStatus1 = esService.selectComTime(id);
				 System.out.println("퇴근:"+empStatus1);

				 model.addAttribute("empStatus1", empStatus1);
				gson.toJson(empStatus1,response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			} 
		  
		  }
	  }
	  
	  @RequestMapping("monthWorkTime.em")
	  public void monthWorkTime(@RequestParam("currentYearMonth") String currentYearMonth, HttpServletRequest request,
			  					HttpServletResponse response, Model model) {
		  HttpSession session = request.getSession();
		  Member m = (Member)session.getAttribute("loginUser");
		  String id = m.getmId();
		  HashMap<String, String> map = new HashMap<>();
		  map.put("currentYearMonth", currentYearMonth);
		  map.put("id", id);
		  System.out.println(currentYearMonth);
		  ArrayList<EmpStatus> mwList = esService.monthWorkTime(map);
		 System.out.println("시작");
		  System.out.println("한달 워크타임:"+mwList);
		  
		  model.addAttribute("mwList", mwList);
		  GsonBuilder gb = new GsonBuilder();
		  gb.setDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
			
			Gson gson = gb.create();
			try {
				gson.toJson(mwList, response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			}
		  
	  }
}
