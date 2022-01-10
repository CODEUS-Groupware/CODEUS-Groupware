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
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.calendar.model.exception.CalendarException;
import com.codeusgroup.codeus.calendar.model.service.CalendarService;
import com.codeusgroup.codeus.calendar.model.vo.CalArrTemp;
import com.codeusgroup.codeus.calendar.model.vo.Calendar;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class CalendarController {
	
	@Autowired
	private CalendarService cService;
	
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
	public void readCalList(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		String mId = String.valueOf(loginUser.getmId());
		
		ArrayList<Calendar> cList = cService.readCalList(mId);
		
		JSONArray jArr = new JSONArray();
		
		for (Calendar c : cList) {
			JSONObject job = new JSONObject();
			
			job.put("scheNo", c.getScheNo());
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
	public String addCal(@ModelAttribute Calendar cal, HttpSession session) {
		
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
			public String addModalSch(@ModelAttribute Calendar cal,
									HttpSession session,
									@RequestParam ("scheNo") String scheNo, 
									@RequestParam ("title") String title, @RequestParam ("startday") String startday,
									@RequestParam ("endday") String endday, @RequestParam ("content") String content ) {
			
			String cWriter = ((Member)session.getAttribute("loginUser")).getmId();
			cal.setmId(cWriter);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("cWriter", cWriter);
			map.put("scheNo", scheNo);
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

			JSONObject job = new JSONObject();
			job.put("result", result);
			
			return job.toString();
		
		}
//		@RequestMapping(value = "/goAddDetailSch.ca")
//		public ModelAndView requiredLogin_goAddDetailSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
//				@RequestParam ("title") String title, @RequestParam ("startday") String startday,
//				@RequestParam ("endday") String endday, @RequestParam ("bAllday") String bAllday,
//				@RequestParam ("shceNo") Integer shceNo, @RequestParam ("content") String content) {
//			
//			request.setAttribute("title", title);
//			request.setAttribute("startday", startday);
//			request.setAttribute("endday", endday);
//			request.setAttribute("bAllday", bAllday);
//			request.setAttribute("shceNo", shceNo);
//			request.setAttribute("content", content);
//			
//			mv.setViewName("0_addDetailSch");
//			
//			return mv;
//		}
		
		// 일정 불러오기
		@ResponseBody
		@RequestMapping(value="/selectSchList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public void selectSchList(HttpServletRequest request, HttpServletResponse response) {
			
			HttpSession session = request.getSession();
			Member loginUser = (Member)session.getAttribute("loginUser");
			
			String mId = String.valueOf(loginUser.getmId());
			String sCalNo = request.getParameter("sCalNo");
			String[] calNoArr = sCalNo.split(",");
			System.out.println("sCalNo : " + sCalNo);
			System.out.println("calNoArr : " + calNoArr);
			for(String c: calNoArr) {
				System.out.println(c);
			}
			
			
			//Map<String, Object> map = new HashMap<String, Object>();
			
			CalArrTemp cat = new CalArrTemp();
			cat.setmId(mId);
			cat.setCalNoArr(calNoArr);
			
			System.out.println("cat : " + cat);
			ArrayList<Calendar> calList = cService.selectSchList(cat);
			System.out.println("calList : " + calList);
			
			JSONArray jArr = new JSONArray();
			for (Calendar cal : calList) {
				JSONObject job = new JSONObject();
				//job.put("schedule_no", cal.getScheNo());
				job.put("mId", cal.getmId());
				job.put("scheNo", cal.getScheNo());
				job.put("title", cal.getScheTitle());
				job.put("startday", cal.getScheStartDate().toString());
				job.put("endday", cal.getScheEndDate().toString());
				job.put("content", cal.getScheContent());
				//job.put("color", cal.getColor());

				jArr.add(job);
			}
			
			
			System.out.println("jArr : " + jArr);
			
			// -9999를 초대받은 일정 캘린더로 설정하고 -9999를 받으면 내 캘린더와 비교해서 없는 캘린더를 받아서 list에 넣어주기
			
			// 사용자가 초대받은 일정을 체크했는지 확인
			// 0: 미체크, 1: 체크
			int isInvite = 0;
			for (String calNo : calNoArr) {
				if ("-9999".equals(calNo)) {
					isInvite = 1;
					System.out.println("calNo" + calNo);
				}
			}
			
			// 초대받은 일정에 체크했을 시
			if (isInvite == 1) {
				// 로그인한 사원의 내 캘린더 번호를 배열로 받아옴

				ArrayList<Calendar> calenList = cService.readCalList(mId);
				
				int[] noInvitecalArr = null;
				if (calenList != null) {
					noInvitecalArr = new int[calList.size()];
					for (int i = 0; i < calList.size(); i++) {
						//noInvitecalArr[i] = calList.get(i).getCalendar_no();
						noInvitecalArr[i] = calList.get(i).getScheNo();
					}
				}
				cat.setNoInvitecalArr(noInvitecalArr);
				
				// 받아온 배열로 not in(받아온 배열)을 사용해서 내 캘린더에 없는 일정 받아오기
				ArrayList<Calendar> noCalschList = cService.selectNoCalSchList(cat);
				
				System.out.println("noCalschList : " + noCalschList);
				// 받아온 초대받은 일정을 view단으로 보내줄 jsonArr에 담기
				if (noCalschList != null) {
					for (Calendar c : noCalschList) {
						JSONObject job = new JSONObject();
					//	job.put("schedule_no", c.getSchedule_no());
						job.put("mId", c.getmId());
						job.put("scheNo", c.getScheNo());
						job.put("title", c.getScheTitle());
						job.put("startday", c.getScheStartDate().toString());
						job.put("endday", c.getScheEndDate().toString());
						job.put("content", c.getScheContent());
						//jsonObj.put("color", "violet");

						jArr.add(job);
					}
				}
				try {
					response.setContentType("application/json; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println(jArr);
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
		}

//	 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
	@RequestMapping(value = "/goAddDetailSch.ca")
	public ModelAndView requiredLogin_goAddDetailSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String title = request.getParameter("title");
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		String bAllday = request.getParameter("bAllday");
		String shceNo = request.getParameter("shceNo");
		String content = request.getParameter("content");
		
		request.setAttribute("title", title);
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		request.setAttribute("bAllday", bAllday);
		request.setAttribute("shceNo", shceNo);
		request.setAttribute("content", content);

		mav.setViewName("0_addDetailSch");
		
		return mav;
		}
	
}
