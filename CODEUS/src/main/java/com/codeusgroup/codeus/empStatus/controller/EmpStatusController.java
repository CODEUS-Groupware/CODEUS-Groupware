package com.codeusgroup.codeus.empStatus.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.codeusgroup.codeus.annualLeave.model.service.AnnualLeaveService;
import com.codeusgroup.codeus.annualLeave.model.vo.AnnualLeave;
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
	@Autowired
	private AnnualLeaveService alService;

	@RequestMapping("empStatusMain.em")
	public String empStatusMain(HttpSession session, HttpServletRequest request, Model model) {
		
		session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		EmpStatus empStatus = new EmpStatus(0, null, null, null, null, null, id, null, null);
		EmpStatus empStatus1 = esService.selectOffTime(id);
		if(empStatus1 != null) {
			//EmpStatus empStatus1 = esService.selectComTime(id);
			
	
			//이번주 누적시간 구하기
			EmpStatus empWeekTime = esService.selectWeekTime(id);
	
			//이번달 누적시간 구하기
			EmpStatus empMonthTime = esService.selectMonthTime(id);
	
			model.addAttribute("empStatus1", empStatus1);	
			model.addAttribute("empWeekTime", empWeekTime);
			model.addAttribute("empMonthTime", empMonthTime);
	
			System.out.println("시간빌때"+empWeekTime.getStrGapTime());
			String gap = empWeekTime.getStrGapTime();
			//주간 근무시간이 0일때 ::이 출력되서 ""으로 대체
			if(gap.equals("::")) {
				empWeekTime.setStrGapTime("");
			}
			if(empWeekTime.getStrOverTime().equals("::")) {
				empWeekTime.setStrOverTime("");
			}
			if(empMonthTime.getStrGapTime().equals("::")) {
				empMonthTime.setStrGapTime("");
			}
			if(empMonthTime.getStrOverTime().equals("::")) {
				empMonthTime.setStrOverTime("");
			}
			System.out.println("시간빌때11:"+empWeekTime.getStrOverTime());
		}
			
		
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

	@RequestMapping("comTime.em")
	public void insertComTime(@ModelAttribute EmpStatus empStatus, @RequestParam("nowTime") String nowTime,
			@RequestParam("day") Date day, HttpServletResponse response, HttpServletRequest request, Model model) {

		response.setContentType("application/json; charset=UTF-8");
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		String statusValue = "업무";
		empStatus = new EmpStatus(0, null, null, null, statusValue, null, id, null, null);
		EmpStatus emp = esService.selectComTime(id);
		if(emp == null) {
			int result = esService.insertComTime(empStatus);
		}
		// 로그인 정보 담아서 보내기..
		EmpStatus empStatus1 = esService.selectComTime(id);
		System.out.println("출근:" + empStatus1);

		model.addAttribute("empStatus1", empStatus1);
		
		Gson gson = new GsonBuilder().create();
		try {

			gson.toJson(empStatus1, response.getWriter());
		} catch (JsonIOException | IOException e) {

			e.printStackTrace();
		}
		
		//출근버튼 클릭할 때 로그인된 사원의 연차현황을 조회 후 1년미만/1년이상 구분-?입사일자가 지났으면 연차발생
		//직원 연차조회
		AnnualLeave al = alService.selectAnnual(id);
		System.out.println("미:"+al);

		
		HashMap<String, String> map = new HashMap<>();
		  map.put("id", id);
		  //아예신입이면 al이 null이라서 insert해주고 그 이후에는 update하기?
		  //comYear가 0이면 신입..
		  int annualCount = 0;
		  String annualCountStr = null;
			/*
			 * Date date = new Date(); SimpleDateFormat getYearFormat = new SimpleDateFormat("yyyy"); 
			 * SimpleDateFormat getMonthFormat = new SimpleDateFormat("mm"); 
			 * int currentYear = Integer.parseInt(getYearFormat.format(date)); 
			 * int currentMonth =Integer.parseInt(getMonthFormat.format(date));
			 */
	       
	       Calendar now = Calendar.getInstance();
	       int currentYear = now.get(Calendar.YEAR);
	       int currentMonth = now.get(Calendar.MONTH) + 1;
	       
	      // System.out.println("디비년도:"+al.getRegiYear());
			System.out.println("1년이상 근무연도:"+currentYear);
			System.out.println("1년이상 근무월:"+currentMonth);
			//System.out.println("al.getRegiMonth():"+al.getRegiMonth());
			/*
			 * System.out.println("getMonthFormat:"+getMonthFormat);
			 * System.out.println("date:"+date);
			 */
	        
		if(al == null) {
			//한달도 안지난 신입일 경우....			
			annualCountStr = 0+"";
			 map.put("annualCountStr", annualCountStr);
			int result2 = alService.insertAnnualCount(map);
			System.out.println("인서트:"+result2);

		}else if(al != null) {
			
		       
			if(al.getComYear()<1 && al.getRegiMonth() != currentMonth) {//1년미만 근무자 1개월마다 update
				//System.out.println("1년이상 근무월:"+currentMonth);
				annualCount = al.getAnnualCount() + 1;
				annualCountStr = annualCount+"";
				map.put("annualCountStr", annualCountStr);
				System.out.println("cc연차갯수:"+annualCountStr);
				int result3 = alService.updateAnnualCount(map);
	  
			}else if(al.getComYear()>=1 && al.getRegiYear() != currentYear) {//1년 이상 근무자 update
				//올해와 regiDate의 년도를 비교하여 올해연도가 아니면 update
				System.out.println("디비년도111:"+al.getRegiYear());
				System.out.println("1년이상 근무연도111:"+currentYear);
				//연차 휴가일수 = 1년차 15일 + (근속년수 - 1년)/2
				int count = (int)(15 + (al.getComYear()/2));
				
				annualCount = count + al.getAnnualCount();
				System.out.println("연차갯수:"+annualCount);
				annualCountStr = annualCount+"";
				 map.put("annualCountStr", annualCountStr);
				int result4 = alService.updateAnnualCount(map);
				
				
			}
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
			
		}else{
			Timestamp gapTimeStamp = new Timestamp(gapTime.getTime()); 
			
			emp = new EmpStatus(0, null, null, null, null, null, id, gapTimeStamp, null); 
			System.out.println(emp);
		}
		
	int result3 =  esService.updateGapTime(emp);
	empStatus1 = esService.selectOffTime(id);

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
		  EmpStatus empStatus1 = null;
		 
		  if(!statusValue.equals("업무상태선택")) {
			  //아이디 가져오기
			  int result = esService.updateStatus(empStatus);
			  empStatus1 = esService.selectOffTime(id);
			  //업무 종료를 클릭하면 현재시간이 퇴근시간으로  DB에 저장되게 함
			 if(statusValue.equals("업무종료")) {
				
				result = esService.updateOffTime(empStatus);
				empStatus1 = updateStatus(id);
				
			 }
			 Gson gson = new GsonBuilder().create();

			try {
				//empStatus = new EmpStatus(0, null, null, null, null, null, id, null, null);
				// EmpStatus empStatus1 = esService.selectOffTime(id);
				 System.out.println("툌ㅋㅋㅋㅋㅋ:"+empStatus1);

				 model.addAttribute("empStatus1", empStatus1);
				gson.toJson(empStatus1,response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			} 
		  
		  }
	  }
	  
	  @RequestMapping("monthWorkTime.em")
	  public void monthWorkTime(@RequestParam("currentYearMonth") String currentYearMonth, 
			  					@RequestParam("currentYear") int currentYear,
			  					@RequestParam("currentMonth") int currentMonth,
			  					@RequestParam("weekSeq") int weekSeq,
			  					HttpServletRequest request,
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

	@RequestMapping("deptEmpStatus.em")
	  public String selectDeptEmpStatus(HttpServletRequest request) {
		  HttpSession session = request.getSession();
		  Member m = (Member)session.getAttribute("loginUser");
		  String id = m.getmId();
		  System.out.println("1/10:"+m);
		  System.out.println("부서:"+m.getDeptId());
		//  ArrayList<EmpStatus> deptList = esService.selectDeptEmpStatus(id);
		  return "deptEmpStatus";
	  }
	  
	  @RequestMapping("deptWorkTime.em")
	  @ResponseBody
	  public void deptWorkTime(@RequestParam("currentYearMonth") String currentYearMonth, @RequestParam("weekSeq") int weekSeq, 
			  					@RequestParam("currentYear") String currentYear,@RequestParam("currentMonth1") String currentMonth1,
							   HttpServletRequest request,  Model model, HttpServletResponse response) {
		  HttpSession session = request.getSession();
		  Member m = (Member)session.getAttribute("loginUser");
		  String id = m.getmId();
		  //currentMonth가 1자리수이면 앞에 0붙이기
		  HashMap<String, String> map = new HashMap<>();
		  map.put("currentYearMonth", currentYearMonth);
		  map.put("id", id);
		  map.put("currentYear", currentYear);
		  map.put("currentMonth1", currentMonth1);
		  
		  ArrayList<EmpStatus> deptList = esService.selectDeptWorkTime(map);
		 // ArrayList<EmpStatus> deptWeekList = esService.selectDeptWeekList(map);
		  
		  //deptList.addAll(deptWeekList);
		 
		  System.out.println("부서별:" + deptList);
		  for(int i= 0; i < deptList.size(); i++) {
			  if(deptList.get(i).getMonthWork().equals("::")) {
				  deptList.get(i).setMonthWork("");
			  }
			  if(deptList.get(i).getMonthOver().equals("::")) {
				  deptList.get(i).setMonthOver("");
			  }
		  }
		  System.out.println("부서별111111:" + deptList);
		  model.addAttribute("deptList", deptList);
		  model.addAttribute("weekSeq", weekSeq);



		  GsonBuilder gb = new GsonBuilder();
		  gb.setDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		  Gson gson = gb.create();
		  try {
				gson.toJson(deptList, response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			} 
	  }

	  public HashMap<String, String> getDate(int check, String selectedMonthStart, String selectedMonthEnd) {
			SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
			Calendar cal = Calendar.getInstance(Locale.KOREA);
			Date date = new Date(System.currentTimeMillis());
			cal.setTime(date);
			
			// 이번 주 일요일 날짜 
			cal.add(Calendar.DATE, 1 - cal.get(Calendar.DAY_OF_WEEK));
			//이번주 월요일 날짜
			//cal.add(Calendar.DATE, 2 - cal.get(Calendar.DAY_OF_WEEK));	
			String weekStart = sdf.format(cal.getTime());
			
			
			// 이번 주 마지막날 날짜
			cal.add(Calendar.DATE, 7 - cal.get(Calendar.DAY_OF_WEEK));	
			String weekEnd = sdf.format(cal.getTime());
			
			int year = cal.get(Calendar.YEAR);
			int mon = cal.get(Calendar.MONTH)+1;
			int monthStart = cal.getMinimum(Calendar.DAY_OF_MONTH);	    // 이번 달 시작 날짜
			int monthEnd = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	// 이번 달 마지막 날짜
			
			String monStart = year+"/"+mon+"/"+monthStart;
			String monEnd = year+"/"+mon+"/"+monthEnd;
			
			String start = null;
			String end = null;
			if(check == 1) {
				// 이번 주
				start = weekStart;
				end = weekEnd;
			} else if(check == 2) {
				// 이번 달
				start = monStart;
				end = monEnd;
			} else if(check == 3) {
				// 선택한 달
				start = selectedMonthStart;
				end = selectedMonthEnd;
			}
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("start", start);
			map.put("end", end);
			System.out.println("start:"+start);
			System.out.println("end:"+end);
			return map;
		}
	  
	  public EmpStatus updateStatus(String id) {
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
		   
		  return empStatus1;
	  }
	  
	  @RequestMapping("monthEmpStatus.em")
	  public void monthEmpStatus(@RequestParam("currentYearMonth") String currentYearMonth, 
								@RequestParam("currentYear") int currentYear,
								@RequestParam("currentMonth") int currentMonth,
								@RequestParam("weekSeq") int weekSeq,
								HttpServletRequest request,
								HttpServletResponse response, Model model) {
		  HttpSession session = request.getSession();
		  Member m = (Member)session.getAttribute("loginUser");
		  String id = m.getmId();
		  HashMap<String, String> map = new HashMap<>();
		  map.put("currentYearMonth", currentYearMonth);
		  map.put("id", id);
		  System.out.println(currentYearMonth);
		  EmpStatus monthTotal = esService.monthTotalTime(map);
		  System.out.println("시작");
		  System.out.println("한달 워크타임:"+monthTotal);
		  if(monthTotal.getStrGapTime().equals("::")) {
			  monthTotal.setStrGapTime("");
		  }
		  if(monthTotal.getStrOverTime().equals("::")) {
			  monthTotal.setStrOverTime("");
		  }
		  System.out.println("한달 워크타임1111:"+monthTotal);

		  model.addAttribute("mwList", monthTotal);
		  GsonBuilder gb = new GsonBuilder();
		  gb.setDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
			
			Gson gson = gb.create();
			try {
				gson.toJson(monthTotal, response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			}
		  	  
	  }  
	  @RequestMapping("personalWorkTime.em")
	  public void personalWorkTime(@RequestParam("currentYearMonth") String currentYearMonth, @RequestParam("weekSeq") int weekSeq, 
				@RequestParam("currentYear") String currentYear,@RequestParam("currentMonth1") String currentMonth1,
			   HttpServletRequest request,  Model model, HttpServletResponse response) {
		  HttpSession session = request.getSession();
		  Member m = (Member)session.getAttribute("loginUser");
		  String id = m.getmId();
		  //currentMonth가 1자리수이면 앞에 0붙이기
		  HashMap<String, String> map = new HashMap<>();
		  map.put("currentYearMonth", currentYearMonth);
		  map.put("id", id);
		  map.put("currentYear", currentYear);
		  map.put("currentMonth1", currentMonth1);

		  ArrayList<EmpStatus> deptWeekList = esService.selectDeptWeekList(map);
	
	
		  System.out.println("부서별 주간:" + deptWeekList);
		  for(int i= 0; i < deptWeekList.size(); i++) {
			  if(deptWeekList.get(i).getStrGapTime().equals("::")) {
				  deptWeekList.get(i).setStrGapTime("");
			  }
			  if(deptWeekList.get(i).getStrOverTime().equals("::")) {
				  deptWeekList.get(i).setStrOverTime("");
			  }
		  }
		  System.out.println("부서별주간111111:" + deptWeekList);
		
		  model.addAttribute("weekSeq", weekSeq);
		  model.addAttribute("deptWeekList", deptWeekList);
		  GsonBuilder gb = new GsonBuilder();
		  gb.setDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		  Gson gson = gb.create();
		  try {
				gson.toJson(deptWeekList, response.getWriter());
			} catch (JsonIOException | IOException e) {
				
				e.printStackTrace();
			} 
		  
	  }

	
}
