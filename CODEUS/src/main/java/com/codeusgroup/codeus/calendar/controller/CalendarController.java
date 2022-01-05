package com.codeusgroup.codeus.calendar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.codeusgroup.codeus.calendar.model.exception.CalendarException;
import com.codeusgroup.codeus.calendar.model.service.CalendarService;
import com.codeusgroup.codeus.calendar.model.vo.Calendar;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class CalendarController {
	
	@Autowired
	private com.codeusgroup.codeus.calendar.model.service.CalendarService cService;
	
	@RequestMapping("calendar.ca")
	public String calendarView() {
		
		return "0_calendar";
	}
	@RequestMapping("calendar2.ca")
	public String calendar2View() {
		
		return "calendar3";
	}

	@ResponseBody
	@RequestMapping(value="readCalList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public void readCalList(HttpServletRequest request, HttpServletResponse response ) {
		
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		String mId = String.valueOf(loginUser.getmId());
		
		ArrayList<Calendar> cList = cService.readCalList(mId);
		
		JSONArray jArr = new JSONArray();
		
		for (Calendar c : cList) {
			JSONObject job = new JSONObject();
			
			job.put("scheType", c.getScheType());
			job.put("mId", c.getmId());
			job.put("name", c.getScheTitle());
			
			jArr.add(job);
		}
		
		try {
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println(jArr);
		} catch (IOException e) {
			e.printStackTrace();
		}
				
	}
	
	// 캘린더(내 일정)를 추가하기
	@ResponseBody
	@RequestMapping(value="addCal.ca")
	public String addCal(@ModelAttribute Calendar cal, HttpSession session, @RequestParam ("scheTitle") String scheTitle) {
		
		String addCal = ((Member)session.getAttribute("loginUser")).getmId();
		cal.setmId(addCal);
		
		int result = cService.addCal(cal);
		
		if(result > 0) {
			return "success";
		} else {
			throw new CalendarException();
		}
	}
		@ResponseBody
		@RequestMapping(value="addModalSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
			public String addModalSch(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			Member loginUser = (Member)session.getAttribute("logineUser");
			
			String mId = String.valueOf(loginUser.getmId());
			String shceNo = request.getParameter("shceNo");
			String title = request.getParameter("title");
			String startday = request.getParameter("startday");
			String endday = request.getParameter("endday");
			String content = request.getParameter("content");
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("mId", mId);
			map.put("shceNo", shceNo);
			map.put("title", title);
			map.put("startday", startday);
			map.put("endday", endday);
			map.put("content", content);
			
			int result = 0;
			try {
				result = cService.addModalSch(map);
			} catch (Throwable e) {
				e.printStackTrace();
			}

			JSONObject jsonObj = new JSONObject();
			jsonObj.put("result", result);
			
			return jsonObj.toString();
		}
		


	// 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
//	@RequestMapping(value = "/goAddDetailSch.os")
//	public ModelAndView requiredLogin_goAddDetailSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//		
//		String title = request.getParameter("title");
//		String startday = request.getParameter("startday");
//		String endday = request.getParameter("endday");
//		String bAllday = request.getParameter("bAllday");
//		String fk_calendar_no = request.getParameter("fk_calendar_no");
//		String content = request.getParameter("content");
//		
//		request.setAttribute("title", title);
//		request.setAttribute("startday", startday);
//		request.setAttribute("endday", endday);
//		request.setAttribute("bAllday", bAllday);
//		request.setAttribute("fk_calendar_no", fk_calendar_no);
//		request.setAttribute("content", content);
//
//		mav.setViewName("subin/calendar/addDetailSch.tiles1");
//		
//		return mav;
//		}
//	
}
