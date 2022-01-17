package com.codeusgroup.codeus.calendar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
//	@RequestMapping("admin/calendar.ca")
//	public String adminClendarView() {
//		
//		return "0_calendar2";
//	}
	@RequestMapping("calendar2.ca")
	public String calendar2View() {
		
		return "0_calendar3";
	}
	// 회사 전체 일정 사이드바에 내 캘린더 리스트 조회
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
	// 사이드바에 내 캘린더 리스트 조회
	@ResponseBody
	@RequestMapping(value="readAdminCalList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public void readAdminCalList(HttpServletRequest request, HttpServletResponse response) {
		
//		HttpSession session = request.getSession();
//		Member loginUser = (Member)session.getAttribute("loginUser");
//		
//		String mId = String.valueOf(loginUser.getmId());
//		
		ArrayList<Calendar> cList = cService.readAdminCalList();
		
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
									@RequestParam ("scheNo") int scheNo, 
									@RequestParam ("title") String title, @RequestParam ("startday") String startday,
									@RequestParam ("endday") String endday, @RequestParam ("content") String content ) {
			
			String cWriter = ((Member)session.getAttribute("loginUser")).getmId();
			cal.setmId(cWriter);
			
//			HashMap<String, String> map = new HashMap<String, String>();
//			map.put("cWriter", cWriter);
//			map.put("scheNo", scheNo);
//			map.put("title", title);
//			map.put("startday", startday);
//			map.put("endday", endday);
//			map.put("content", content);
			
			int result = 0;
			try {
				result = cService.addModalSch(cal);
				System.out.println("result cal : " + result);
				result = 1;
			} catch (Throwable e) {
				e.printStackTrace();
			}

			JSONObject job = new JSONObject();
			job.put("result", result);
			System.out.println("result" + result );
			return job.toString();
		
		}
		
		// 일정 불러오기
		@ResponseBody
		@RequestMapping(value="/selectSchList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public void selectSchList(HttpServletRequest request, HttpServletResponse response, 
								  @RequestParam ("sCalNo") String sCalNo) {
			
			HttpSession session = request.getSession();
			Member loginUser = (Member)session.getAttribute("loginUser");
			
			String mId = String.valueOf(loginUser.getmId());
			String[] calNoArr = sCalNo.split(",");
			//System.out.println("sCalNo : " + sCalNo);
			System.out.println("calNoArr : " + calNoArr);
			
			//Map<String, Object> map = new HashMap<String, Object>();
			
			CalArrTemp cat = new CalArrTemp();
			cat.setmId(mId);
			cat.setCalNoArr(calNoArr);
			
			//System.out.println("cat : " + cat);
			ArrayList<Calendar> calList = cService.selectSchList(cat);
			System.out.println("유저calList : " + calList);
			
			JSONArray jArr = new JSONArray();
			
			for (Calendar cal : calList) {
				JSONObject job = new JSONObject();
				job.put("mId", cal.getmId());
				job.put("scheNo", cal.getScheNo());
				job.put("title", cal.getScheTitle());
				job.put("startday", cal.getScheStartDate().toString());
				job.put("endday", cal.getScheEndDate().toString());
				job.put("content", cal.getScheContent());
				job.put("color", cal.getColor());
							//job.put("schedule_no", cal.getScheNo());
							//job.put("startday", cal.getScheStartString());
							//job.put("endday", cal.getScheEndString());
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
			// 일정 불러오기
			@ResponseBody
			@RequestMapping(value="/selectadminSchList.ca", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
			public void selectadminSchList(HttpServletRequest request, HttpServletResponse response, 
					@RequestParam ("sCalNo") String sCalNo) {
				
//				HttpSession session = request.getSession();
//				Member loginUser = (Member)session.getAttribute("loginUser");
//				
//				String mId = String.valueOf(loginUser.getmId());
				String[] calNoArr = sCalNo.split(",");
				System.out.println("calNoArr : " + calNoArr);
				
				CalArrTemp cat = new CalArrTemp();
		//		cat.setmId(mId);
				cat.setCalNoArr(calNoArr);
				
				ArrayList<Calendar> calList = cService.selectadminSchList(cat);
				System.out.println("어드민 calList : " + calList);
				
				JSONArray jArr = new JSONArray();
				
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
			
				try {
					response.setContentType("application/json; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println(jArr);
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
		

//	 일정 상세 추가 페이지로 이동(참가자는 로그인한유저)
	@RequestMapping(value = "/goAddDetailSch.ca")
	public ModelAndView requiredLogin_goAddDetailSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
			
			mv.setViewName("0_addDetailSch");
			
			return mv;
		}
	// 일정 상세 추가하기(다수의 참가자)
		@ResponseBody
		@RequestMapping(value="/addDetailSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String addDetailSch(HttpServletRequest request,
									@RequestParam ("title") String title, @RequestParam ("startday") String startday,
									@RequestParam ("endday") String endday, @RequestParam ("content") String content,
									/*@RequestParam ("scheNo") int scheNo, @RequestParam ("scheType") String scheType,*/
									@RequestParam ("mId") String mId)  {
			
			
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("title", title);
			map.put("startday", startday);
			map.put("endday", endday);
	//		map.put("scheType", scheType);
			map.put("content", content);
			map.put("mId", mId);
			
//			// 같은 일정일 시 묶어줄 groupid를 받음
//			ArrayList<String> groupId = cService.selectGroupId(map);
//			map.put("groupId", groupId);
//			System.out.println("addDetailSch.ca map :" +  map + "groupId: " +  groupId);
//			// DB 작업의 성공 여부 확인을 위한 변수
			int result = 0;
			try {
				result  = cService.addDetailSch(map);
				result = 1;
			} catch (Throwable e) {
				result = 0;
			}
			System.out.println("addDetailSch.ca result : " + result);
			
			JSONObject job = new JSONObject();
			job.put("result", result);
			System.out.println("addDetailSch.ca controller job : " + job);
			return job.toString();
		}
	@RequestMapping(value="editSch.ca")
	public ModelAndView editSch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
								@RequestParam ("scheNo") int scheNo) {
		Calendar cal = cService.selectOneSch(scheNo);
		
		System.out.println("cal : " +  cal );
		
		
//		String start = cal.getScheStartDate().toString().substring(0, 10);
//		String startHour = cal.getScheStartDate().toString().substring(11);
//		String end = cal.getScheEndDate().toString().substring(0, 10);
//		String endHour = cal.getScheEndDate().toString().substring(11);
		
//		
//		System.out.println("start : " + start);
//		System.out.println(cal.getScheStartString());
//		// 불러온 일정이 종일일 경우
//		if (start.equals(end) && endHour.equals("23:59:59")) {
//			mv.addObject("bAllday", 1);	// 뷰단의 체크박스를 위해 넘겨줌

		mv.addObject("bAllday", 1);
		System.out.println(cal.getScheStartDate());
		System.out.println(cal.getScheEndDate());
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		cal.setScheStartString(sdf1.format(cal.getScheStartDate()));
		cal.setScheEndString(sdf1.format(cal.getScheEndDate()));
		
		
		System.out.println("데이터 : " + sdf1.format(cal.getScheEndDate()));

		
		mv.addObject("cal", cal);
		System.out.println("realCal : " + cal);
		mv.setViewName("0_editSch");
		
		return mv;
	}
	// 일정이 초대받은 일정인지 검사
	@ResponseBody
	@RequestMapping(value="/checkDelInviteSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
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
		map.put("mId", mId);
		
		// 로그인한 사원의 내 캘린더 번호를 배열로 받아옴
		ArrayList<Calendar> calList = cService.readCalList(mId);
		System.out.println("초대받은 일정인지 calList : " + calList);
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
		@RequestMapping(value="/selectAtd.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
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
	   @RequestMapping(value="/writeAddressSearch.ca", produces="text/plain; charset=UTF-8")
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
		
		@RequestMapping(value = "/goCalendar.ca")
		public ModelAndView requiredLogin_goCalendar(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			mav.setViewName("0_calendar");
			
			return mav;
		}
		// 일정을 수정하는 함수(참석자로 묶인 일정들도 전부 함께 수정)
		@ResponseBody
		@RequestMapping(value="/doEditSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String doEditSch(HttpServletRequest request, 
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
		//	map.put("checkDel", "del");
			System.out.println("doEditSch.ca map : " + map);
			// 삭제할 일정번호 문자열로 받아오기
			
//			String[] fk_schArr = new String[delSchNoList.size()];
//			System.out.println("doEditSch.ca fk_schArr : " + fk_schArr);
//
//			for (int i = 0; i < delSchNoList.size(); i++) {
//				fk_schArr[i] = delSchNoList.get(i);
//				System.out.println("doEditSch.ca fk_schArr[i] : " + fk_schArr[i]);
//			}
			
			// 수정할 내용으로 새로운 일정들 생성
			
			System.out.println("doEditSch.ca map" + map);
//			 DB 작업의 성공 여부 확인을 위한 변수

				int result = 0;
				try {
					result = cService.doEditSch(map);
					result = 1;
				} catch (Throwable e) {
					result = 0;
				}
				System.out.println("result                :              " + result);
			JSONObject job = new JSONObject();
			job.put("result", result);
			
			return job.toString();
//			int result = cService.doEditSch(c);
//			
//			if(result > 0) {
//				model.addAttribute("scheNo", scheNo);
//				model.addAttribute("title", scheTitle);
//				model.addAttribute("startday", scheStartString);
//				model.addAttribute("endday", scheEndString);
//				model.addAttribute("scheType", scheType);
//				model.addAttribute("content", scheContent);
//			} else {
//				throw new CalendarException("일정 수정에 실패하였습니다. ");
//				
//			}
//			return "0_calendar";
		}
		// 일정 삭제하기(참석자로 묶인 일정들도 전부 함께 삭제)
		@ResponseBody
		@RequestMapping(value="/delSch.ca", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String delSch(HttpServletRequest request, @RequestParam ("scheNo") String scheNo) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("scheNo", scheNo);
			System.out.println("일정삭제 map: " + map);
			// 삭제할 일정 번호 받아오기
			ArrayList<String> fk_schedule_noArr = cService.findDelSchNo(map);
//			String[] fk_schArr = new String[fk_schedule_noArr.size()];
//			
//			System.out.println("일정 삭제 fk_schArr : " + fk_schArr );
//			for (int i = 0; i < fk_schedule_noArr.size(); i++) {
//				fk_schArr[i] = fk_schedule_noArr.get(i);
//			}
			
			
			map.put("fk_schedule_noArr", fk_schedule_noArr);
			
			JSONObject job = new JSONObject();
			
			// 위에서 받은 일정번호를 삭제하기
			int result = cService.delSch(map);
			System.out.println("일정삭제 result: " + result);
			if (result == fk_schedule_noArr.size()) {
				job.put("result", 1);
			}

			return job.toString();
		}
		
}
