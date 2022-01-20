package com.codeusgroup.codeus.calendar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
	@RequestMapping("myCalendar.ca")
	public String calendar2View() {
		
		return "0_myCalendar";
	}
	// 사이드바에 내 캘린더 리스트 조회
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
			job.put("color", c.getColor());
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
	// 사이드바에 사내 캘린더 리스트 조회
	@ResponseBody
	@RequestMapping(value="readAdminCalList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public void readAdminCalList(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		String mId = String.valueOf(loginUser.getmId());
		
		ArrayList<Calendar> cList = cService.readAdminCalList(mId);
		
		JSONArray jArr = new JSONArray();
		
		for (Calendar c : cList) {
			JSONObject job = new JSONObject();
			job.put("scheNo", c.getScheNo());
			job.put("mId", c.getmId());
			job.put("name", c.getScheTitle());
			job.put("color", c.getColor());
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
	
//	 관리자가 캘린더(사내 일정)를 추가하기
	@ResponseBody
	@RequestMapping(value="addCal.ca")
	public String addCal(@ModelAttribute Calendar cal, HttpSession session,
						@RequestParam ("name") String shceTitle) {
		
		String addCal = ((Member)session.getAttribute("loginUser")).getmId();
		cal.setmId(addCal);
		cal.setScheTitle(shceTitle);
		
		int result = cService.addCal(cal);
		
		if(result > 0) {
			return "success";
		} else {
			throw new CalendarException();
		}
	}
	
		@ResponseBody
		@RequestMapping(value="addModalSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
			public void addModalSch(HttpSession session, HttpServletResponse response,
									@RequestParam ("title") String title, 
									@RequestParam ("startday") String startday,
									@RequestParam ("endday") String endday, @RequestParam ("content") String content ) {
			
			String cWriter = ((Member)session.getAttribute("loginUser")).getmId();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("cWriter", cWriter);
			map.put("title", title);
			map.put("startday", startday);
			map.put("endday", endday);
			map.put("content", content);
			
			int result = 0;
			try {
				result = cService.addModalSch(map);
				result = 1;
			} catch (Throwable e) {
				e.printStackTrace();
			}

			JSONObject job = new JSONObject();
			job.put("result", result);
			
			
			try {
				response.setContentType("application/json; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println(job);
			} catch (IOException e) {
				e.printStackTrace();
			}	
			
		
		}
		@ResponseBody
		@RequestMapping(value="addModalMySch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public void addModalMySch(HttpSession session, HttpServletResponse response,
				@RequestParam ("title") String title, @RequestParam ("startday") String startday,
				@RequestParam ("endday") String endday, @RequestParam ("content") String content ) {
			
			String cWriter = ((Member)session.getAttribute("loginUser")).getmId();
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("cWriter", cWriter);
			map.put("title", title);
			map.put("startday", startday);
			map.put("endday", endday);
			map.put("content", content);
			
			int result = 0;
			try {
				result = cService.addModalMySch(map);
				result = 1;
			} catch (Throwable e) {
				e.printStackTrace();
			}

			JSONObject job = new JSONObject();
			job.put("result", result);
			
			
			try {
				response.setContentType("application/json; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println(job);
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
		
		// 일정 불러오기
		@ResponseBody
		@RequestMapping(value="selectSchList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public void selectSchList(HttpServletRequest request, HttpServletResponse response, 
								  @RequestParam (value="sCalNo", defaultValue = "0") String sCalNo) {
			
			HttpSession session = request.getSession();
			Member loginUser = (Member)session.getAttribute("loginUser");
			
			String mId = String.valueOf(loginUser.getmId());
			String[] calNoArr = sCalNo.split(",");
			
			CalArrTemp cat = new CalArrTemp();
			cat.setmId(mId);
			cat.setCalNoArr(calNoArr);
			
			ArrayList<Calendar> calList = cService.selectSchList(cat);
			
			JSONArray jArr = new JSONArray();
			
			if(calList != null) {
				for (Calendar cal : calList) {
					JSONObject job = new JSONObject();
					job.put("mId", cal.getmId());
					job.put("scheNo", cal.getScheNo());
					job.put("title", cal.getScheTitle());
					job.put("startday", cal.getScheStartDate().toString());
					job.put("endday", cal.getScheEndDate().toString());
					job.put("content", cal.getScheContent());
					job.put("color", cal.getColor());
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
			// 일정 불러오기
			@ResponseBody
			@RequestMapping(value="selectadminSchList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
			public void selectadminSchList(HttpServletRequest request, HttpServletResponse response, 
					@RequestParam (value="sCalNo", defaultValue = "0") String sCalNo) {
				HttpSession session = request.getSession();
				Member loginUser = (Member)session.getAttribute("loginUser");
				
				String mId = String.valueOf(loginUser.getmId());
				String[] calNoArr = sCalNo.split(",");
				CalArrTemp cat = new CalArrTemp();
				cat.setmId(mId);
				cat.setCalNoArr(calNoArr);
				
				ArrayList<Calendar> calList = cService.selectadminSchList(cat);
				
				JSONArray jArr = new JSONArray();
				
				if(calList != null) {
					for (Calendar cal : calList) {
						JSONObject job = new JSONObject();
						job.put("mId", cal.getmId());
						job.put("scheNo", cal.getScheNo());
						job.put("title", cal.getScheTitle());
						job.put("startday", cal.getScheStartDate().toString());
						job.put("endday", cal.getScheEndDate().toString());
						job.put("content", cal.getScheContent());
						job.put("color", cal.getColor());
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
		

//	 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
	@RequestMapping(value = "goAddCal.ca")
	public ModelAndView goAddCal(ModelAndView mv) {
		
		mv.setViewName("0_addDetailSch");
		
		return mv;
	}

	//	 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
	@RequestMapping(value = "goAddMyCal.ca")
	public ModelAndView goAddMyCal(ModelAndView mv) {
		
		mv.setViewName("0_addDetailMySch");
		
		return mv;
	}
	
	@RequestMapping(value = "goAddDetailSch.ca")
	public ModelAndView goAddDetailSch(HttpServletRequest request, HttpServletResponse response,
			@RequestParam ("title") String title, @RequestParam ("startday") String startday,
			@RequestParam ("endday") String endday, @RequestParam ("content") String content,
			@RequestParam ("bAllday") String bAllday, ModelAndView mv) {
		
		request.setAttribute("title", title);
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		request.setAttribute("bAllday", bAllday);
		request.setAttribute("content", content);
		
		mv.setViewName("0_addDetailSch");
		
		return mv;
	}

	//	 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
	@RequestMapping(value = "goAddDetailMySch.ca")
	public ModelAndView goAddDetailMySch(HttpServletRequest request, HttpServletResponse response,
			@RequestParam ("title") String title, @RequestParam ("startday") String startday,
			@RequestParam ("endday") String endday, @RequestParam ("content") String content,
			@RequestParam ("bAllday") String bAllday, ModelAndView mv) {
		
		request.setAttribute("title", title);
		request.setAttribute("startday", startday);
		request.setAttribute("endday", endday);
		request.setAttribute("bAllday", bAllday);
		request.setAttribute("content", content);
		
		mv.setViewName("0_addDetailMySch");
		
		return mv;
	}
	// 일정 등록 버튼으로 일정 추가
		@ResponseBody
		@RequestMapping(value="addDetailSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String addDetailSch(HttpServletRequest request,
									@RequestParam ("title") String title, @RequestParam ("startday") String startday,
									@RequestParam ("endday") String endday, @RequestParam ("content") String content,
									@RequestParam ("mId") String mId, @RequestParam ("color") String color)  {
			
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("title", title);
			map.put("startday", startday);
			map.put("endday", endday);
			map.put("content", content);
			map.put("mId", mId);
			map.put("color", color);
			
//			// DB 작업의 성공 여부 확인을 위한 변수
			int result = 0;
			try {
				result  = cService.addDetailSch(map);
				result = 1;
			} catch (Throwable e) {
				result = 0;
			}
			
			JSONObject job = new JSONObject();
			job.put("result", result);
			return job.toString();
		}

		// 일정 등록 버튼으로 일정 추가
		@ResponseBody
		@RequestMapping(value="addDetailMySch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String addDetailMySch(HttpServletRequest request,
				@RequestParam ("title") String title, @RequestParam ("startday") String startday,
				@RequestParam ("endday") String endday, @RequestParam ("content") String content,
				@RequestParam ("mId") String mId, @RequestParam ("color") String color)  {
			
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("title", title);
			map.put("startday", startday);
			map.put("endday", endday);
			map.put("content", content);
			map.put("mId", mId);
			map.put("color", color);
//			// DB 작업의 성공 여부 확인을 위한 변수
			int result = 0;
			try {
				result  = cService.addDetailMySch(map);
				result = 1;
			} catch (Throwable e) {
				result = 0;
			}
			JSONObject job = new JSONObject();
			job.put("result", result);
			return job.toString();
		}
		
	@RequestMapping(value="editSch.ca")
	public ModelAndView editSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
								@RequestParam ("scheNo") int scheNo) {
		Calendar cal = cService.selectOneSch(scheNo);
	
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		cal.setScheStartString(sdf1.format(cal.getScheStartDate()));
		cal.setScheEndString(sdf1.format(cal.getScheEndDate()));
		
		if(cal.getScheStartDate().toString().substring(0, 10).equals(cal.getScheEndDate().toString().substring(0, 10)) && cal.getScheEndString().substring(11).equals("21:00:00")) {
			mv.addObject("bAllday", 1);
		} else {
			mv.addObject("bAllday", 0);
		}
		
		
		mv.addObject("cal", cal);
		mv.setViewName("0_editSch");
		
		return mv;
	}

	@RequestMapping(value="editMySch.ca")
	public ModelAndView editMySch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			@RequestParam ("scheNo") int scheNo) {
		Calendar cal = cService.selectOneSch(scheNo);
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		cal.setScheStartString(sdf1.format(cal.getScheStartDate()));
		cal.setScheEndString(sdf1.format(cal.getScheEndDate()));
		
		if(cal.getScheStartDate().toString().substring(0, 10).equals(cal.getScheEndDate().toString().substring(0, 10)) && cal.getScheEndString().substring(11).equals("21:00:00")) {
			mv.addObject("bAllday", 1);
		} else {
			mv.addObject("bAllday", 0);
		}
		
		mv.addObject("cal", cal);
		mv.setViewName("0_editMySch");
		
		return mv;
	}
	// 일정이 초대받은 일정인지 검사
	@ResponseBody
	@RequestMapping(value="checkDelInviteSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String checkDelInviteSch(HttpServletRequest request, HttpSession session,
									@RequestParam ("scheNo") String scheNo, @RequestParam ("scheType") String scheType,
									@RequestParam ("title") String title, @RequestParam ("startday") String startday,
									@RequestParam ("endday") String endday, @RequestParam ("content") String content) {
								
		Member loginUser = (Member)session.getAttribute("loginUser");
		String mId = String.valueOf(loginUser.getmId());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mId", mId);
		map.put("scheNo", scheNo);
		map.put("title", title);
		map.put("startday", startday);
		map.put("endday", endday);
		map.put("scheType", scheType);
		map.put("content", content);
		
		// 로그인한 사원의 내 캘린더 번호를 배열로 받아옴
		ArrayList<Calendar> calList = cService.readAdminCalList(mId);
		int result = 0;
		if (calList != null) {
			for (int i = 0; i < calList.size(); i++) {
				if (calList.get(i).getmId().equalsIgnoreCase(mId)) {
					// 불러온 캘린더와 겹치는 것이 있을 시 => 자신의 캘린더(삭제 가능)
					result = 1;
					break;
				}else {
					// 불러온 캘린더와 겹치는 것이 없을 시 => 자신의 캘린더(삭제 불가)
					result = 0;
				}
			}
		}else {
			// 자신의 캘린더가 아예 생성되지 않았을 경우 초대받은 캘린더만 있음(전부 삭제 불가)
			result = 0;
		}
		JSONObject job = new JSONObject();
		job.put("result", result);
		return job.toString();
	}
	// 일정이 초대받은 일정인지 검사
	@ResponseBody
	@RequestMapping(value="checkDelInviteMySch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String checkDelInviteMySch(HttpServletRequest request, HttpSession session,
			@RequestParam ("scheNo") String scheNo, @RequestParam ("scheType") String scheType,
			@RequestParam ("title") String title, @RequestParam ("startday") String startday,
			@RequestParam ("endday") String endday, @RequestParam ("content") String content) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String mId = String.valueOf(loginUser.getmId());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mId", mId);
		map.put("scheNo", scheNo);
		map.put("title", title);
		map.put("startday", startday);
		map.put("endday", endday);
		map.put("scheType", scheType);
		map.put("content", content);
		
		// 로그인한 사원의 내 캘린더 번호를 배열로 받아옴
		ArrayList<Calendar> calList = cService.readCalList(mId);
		int result = 0;
		if (calList != null) {
			for (int i = 0; i < calList.size(); i++) {
				if (calList.get(i).getmId().equalsIgnoreCase(mId)) {
					// 불러온 캘린더와 겹치는 것이 있을 시 => 자신의 캘린더(삭제 가능)
					result = 1;
					break;
				}else {
					// 불러온 캘린더와 겹치는 것이 없을 시 => 자신의 캘린더(삭제 불가)
					result = 0;
				}
			}
		}else {
			// 자신의 캘린더가 아예 생성되지 않았을 경우 초대받은 캘린더만 있음(전부 삭제 불가)
			result = 0;
		}
		JSONObject job = new JSONObject();
		job.put("result", result);
		return job.toString();
	}
	// 참가자(이름) 불러오기
		@ResponseBody
		@RequestMapping(value="selectAtd.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public void selectAtd(HttpServletRequest request, HttpServletResponse response, @RequestParam ("scheNo") String scheNo) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("scheNo", scheNo);
			
			ArrayList<Member> mList = cService.selectAtd(map);
			
			JSONArray jArr = new JSONArray();
			
			for (Member m : mList) {
				JSONObject job = new JSONObject();
				job.put("mId", m.getmId());
				job.put("mName", m.getmName()); 
			
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
		@ResponseBody
	   @RequestMapping(value="writeAddressSearch.ca", produces="text/plain; charset=UTF-8")
	   public String writeAddressSearch(HttpServletRequest request, @RequestParam ("searchWord") String searchWord) {
	      
	      HashMap<String, String> map = new HashMap<String, String>();
	      map.put("searchWord", searchWord);
	      
	      ArrayList<Member> mSearchList = cService.mSearchList(map);
	     
	      JSONArray jArr = new JSONArray();
	      
	      if(mSearchList != null) {
	         for(Member m : mSearchList) {
	            JSONObject job = new JSONObject();
	            job.put("mName", m.getmName());       
	            job.put("jobId", m.getJobName());    
	            job.put("deptId", m.getDeptName());
	            job.put("mId", m.getmId());
	            
	            jArr.add(job);
	         }
	      }

	      return jArr.toString();
	   }	
		
		@RequestMapping(value = "goCalendar.ca")
		public ModelAndView goCalendar(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			mav.setViewName("0_calendar");
			
			return mav;
		}

		@RequestMapping(value = "goMyCalendar.ca")
		public ModelAndView goMyCalendar(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			mav.setViewName("0_myCalendar");
			
			return mav;
		}
		// 사내 일정을 수정하는 함수(참석자로 묶인 일정들도 전부 함께 수정)
		@ResponseBody
		@RequestMapping(value="doEditSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
			public String doEditSch(HttpServletRequest request, 
					@RequestParam ("title") String scheTitle, @RequestParam ("startday") String scheStartString,
					@RequestParam ("endday") String scheEndString, @RequestParam ("content") String scheContent,
					@RequestParam ("scheNo") String scheNo, @RequestParam ("scheType") String scheType,
					@RequestParam ("mId") String mId, @RequestParam ("color") String color) {
				
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("scheNo", scheNo);	// 같음
				map.put("scheTitle", scheTitle);
				map.put("scheStartDate", scheStartString);
				map.put("scheEndDate", scheEndString);
				map.put("scheType", scheType);
				map.put("scheContent", scheContent);
				map.put("mId", mId);
				map.put("color", color);
				// 삭제할 일정번호 문자열로 받아오기
				
//					 DB 작업의 성공 여부 확인을 위한 변수
				
				int result = 0;
				try {
					result = cService.doEditSch(map);
					result = 1;
				} catch (Throwable e) {
					result = 0;
				}
				JSONObject job = new JSONObject();
				job.put("result", result);
				
				return job.toString();
			}
		// 내 일정을 수정하는 함수(참석자로 묶인 일정들도 전부 함께 수정)
		@ResponseBody
		@RequestMapping(value="doEditMySch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String doEditMySch(HttpServletRequest request, 
				@RequestParam ("title") String scheTitle, @RequestParam ("startday") String scheStartString,
				@RequestParam ("endday") String scheEndString, @RequestParam ("content") String scheContent,
				@RequestParam ("scheNo") String scheNo, @RequestParam ("scheType") String scheType,
				@RequestParam ("mId") String mId, @RequestParam ("color") String color) {
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("scheNo", scheNo);	// 같음
			map.put("scheTitle", scheTitle);
			map.put("scheStartDate", scheStartString);
			map.put("scheEndDate", scheEndString);
			map.put("scheType", scheType);
			map.put("scheContent", scheContent);
			map.put("mId", mId);
			map.put("color", color);
			// 삭제할 일정번호 문자열로 받아오기
			
//			 DB 작업의 성공 여부 확인을 위한 변수
			
			int result = 0;
			try {
				result = cService.doEditMySch(map);
				result = 1;
			} catch (Throwable e) {
				result = 0;
			}
			JSONObject job = new JSONObject();
			job.put("result", result);
			
			return job.toString();
		}

		@ResponseBody
		@RequestMapping(value="delSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public void deleteSche(HttpServletRequest request, HttpServletResponse response, @ModelAttribute Calendar cal, 
				@RequestParam ("title") String scheTitle, @RequestParam ("startday") String scheStartString,
				@RequestParam ("endday") String scheEndString, @RequestParam ("content") String scheContent,
				@RequestParam ("scheNo") String scheNo, @RequestParam ("scheType") String scheType,
				@RequestParam ("mId") String mId) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("scheNo", scheNo);	// 같음
				map.put("scheTitle", scheTitle);
				map.put("scheStartDate", scheStartString);
				map.put("scheEndDate", scheEndString);
				map.put("scheType", scheType);
				map.put("scheContent", scheContent);
				map.put("mId", mId);

			
			// 위에서 받은 일정번호를 삭제하기
			int result = cService.deleteSche(map);
			
			try {
				response.setContentType("application/json; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println(result);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		@RequestMapping(value="/editCal.ca")
		public ModelAndView editCal(ModelAndView mv) {
			
			mv.setViewName("0_editCal");
			return mv;
		}
		// 캘린더(내일정)의 색상 변경하기
		@ResponseBody
		@RequestMapping(value="/editCalColor.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String editCalColor(HttpServletRequest request, @RequestParam ("scheNo") String scheNo,
									@RequestParam ("color") String color) {
			
			HttpSession session = request.getSession();
			Member loginUser = (Member)session.getAttribute("loginUser");
			
			String mId = String.valueOf(loginUser.getmId());
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("mId", mId);
			map.put("scheNo", scheNo);
			map.put("color", color);
			
			int result = cService.editCalColor(map);
			
			JSONObject job = new JSONObject();
			job.put("result", result);
			
			return job.toString();
		}
		
	}

