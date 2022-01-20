package com.codeusgroup.codeus.admin.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.admin.common.Pagination;
import com.codeusgroup.codeus.admin.model.exception.AdminException;
import com.codeusgroup.codeus.admin.model.service.AdminService;
import com.codeusgroup.codeus.admin.model.vo.Department;
import com.codeusgroup.codeus.admin.model.vo.Job;
import com.codeusgroup.codeus.admin.model.vo.PageInfo;
import com.codeusgroup.codeus.admin.model.vo.Report;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService aService;
	
    /**
     * 사원 목록 조회
     */
	@RequestMapping("admin/mlist.ad")
	public ModelAndView selectMemberList(@RequestParam(value="page", required=false) Integer page, 
										@RequestParam(value="message", required=false) String message, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = aService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Integer> memberCount = aService.getMemberCount();
		ArrayList<Member> mList = aService.selectMemberList(pi);
		ArrayList<Member> mList2 = aService.selectMemberList(null); // 사원 이름 검색시 자동완성 기능 제공하기 위한 memberList
		ArrayList<Department> dList = aService.selectDepartmentList();
		ArrayList<Job> jList = aService.selectJobList();
		
		if(memberCount != null && mList != null && mList2 != null && dList != null && jList != null) {
			mv.addObject("memberCount", memberCount);
			mv.addObject("pi", pi);
			mv.addObject("mList", mList);
			mv.addObject("mList2", mList2);
			mv.addObject("dList", dList);
			mv.addObject("jList", jList);
			mv.addObject("message", message);
			mv.setViewName("memberList");
		} else {
			throw new AdminException("멤버 리스트 조회에 실패하엿습니다.");
		}
		
		return mv;
	}
	
    /**
     * 사원 검색
     */	
	@RequestMapping("admin/msearch.ad")
	public ModelAndView selectSearchMemberList(@RequestParam(value="page", required=false) Integer page, 
										 @RequestParam(value="selectDept", required=false) String selectDept,
										 @RequestParam(value="selectJob",  required=false) String selectJob,
										 @RequestParam(value="searchValue", required=false) String searchValue, ModelAndView mv) {
		
		HashMap<String, String> map = new HashMap();
		map.put("selectDept", selectDept);
		map.put("selectJob", selectJob);
		map.put("searchValue", searchValue.trim());

		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = aService.getSearchListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Integer> memberCount = aService.getMemberCount();
		ArrayList<Member> mList = aService.selectSearchMemberList(pi, map);
		ArrayList<Member> mList2 = aService.selectMemberList(null);
		ArrayList<Department> dList = aService.selectDepartmentList();
		ArrayList<Job> jList = aService.selectJobList();
	
		if(memberCount != null && mList != null && mList2 != null && dList != null && jList != null) {
			mv.addObject("memberCount", memberCount);
			mv.addObject("pi", pi);
			mv.addObject("mList", mList);
			mv.addObject("mList2", mList2);
			mv.addObject("dList", dList);
			mv.addObject("jList", jList);
			mv.addObject("selectDept", selectDept);
			mv.addObject("selectJob", selectJob);
			mv.addObject("searchValue", searchValue);
			mv.setViewName("memberList");
		} else {
			throw new AdminException("멤버 검색 결과 조회에 실패하엿습니다.");
		}
		
		return mv;
	}
	
    /**
     * 사원 정보 수정(여러 명)
     */
	@RequestMapping("admin/mupdatemulti.ad")
	public String updateMultiMember(@RequestParam("mId") String[] mIdArr, @RequestParam("mStatus") int mStatus, HttpSession session) {
		
		int result = aService.updateMultiMember(mIdArr, mStatus);
		
		if (mStatus == 1) {
			Member loginUser = (Member)session.getAttribute("loginUser");
			String loginUserId = loginUser.getmId();
			
			for (String mId : mIdArr) {
				if (loginUserId.equals(mId)) {
					session.invalidate();
					return "redirect:/";
				}
			}
		}
		
		if (result != mIdArr.length) {
			throw new AdminException("멤버 정보 수정에 실패하엿습니다.");
		}
		
		return "redirect:mlist.ad?message=u";
	}
	
	/**
     * 사원 삭제
     */
	@RequestMapping("admin/mdelete.ad")
	public String deleteMember(@RequestParam("mId") String[] mIdArr, HttpSession session) {
		
		int result = aService.deleteMember(mIdArr);
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getmId();
		
		for (String mId : mIdArr) {
			if (loginUserId.equals(mId)) {
				session.invalidate();
				return "redirect:/";
			}
		}
		
		if (result != mIdArr.length) {
			throw new AdminException("멤버 삭제에 실패하엿습니다.");
		}
		
		return "redirect:mlist.ad?message=d";
	}	
	
    /**
     * 사원 상새
     */
	@RequestMapping("admin/mdetail.ad")
	public ModelAndView memberDetail(@RequestParam("mId") String mId, @RequestParam("page") int page, 
									 @RequestParam(value="selectDept", required=false) String selectDept,
									 @RequestParam(value="selectJob",  required=false) String selectJob,
									 @RequestParam(value="searchValue", required=false) String searchValue, 
									 @RequestParam(value="message", required=false) String message, ModelAndView mv) {
		Member member = aService.selectMember(mId);
		ArrayList<Department> dList = aService.selectDepartmentList();
		ArrayList<Job> jList = aService.selectJobList();
		
		if (member != null && dList != null && jList != null) {
			mv.addObject("member", member);
			mv.addObject("dList", dList);
			mv.addObject("jList", jList);
			mv.addObject("page", page);
			mv.addObject("selectDept", selectDept);
			mv.addObject("selectJob", selectJob);
			mv.addObject("searchValue", searchValue);
			mv.addObject("message", message);
			mv.setViewName("memberDetail");
		} else {
			throw new AdminException("멤버 상세 조회에 실패하엿습니다.");
		}
		
		return mv;
	}
	
    /**
     * 사원 정보 수정(1명)
     */
	@RequestMapping("admin/mupdate.ad")
	public String updateMember(@ModelAttribute Member m, @RequestParam("inputHireDate") String inputHireDate, 
							   @RequestParam("inputEndDate") String inputEndDate, @RequestParam("page") int page,
							   @RequestParam(value="selectDept", required=false) String selectDept,
							   @RequestParam(value="selectJob",  required=false) String selectJob,
							   @RequestParam(value="searchValue", required=false) String searchValue, Model model, HttpSession session) {
		if (!inputHireDate.equals("")) {
			String[] hSplit = inputHireDate.split("-");
			int hYear = Integer.parseInt(hSplit[0]);
			int hMonth = Integer.parseInt(hSplit[1]) - 1;
			int hDate = Integer.parseInt(hSplit[2]);
			Date hireDate = new Date(new GregorianCalendar(hYear, hMonth, hDate).getTimeInMillis());
			m.setHireDate(hireDate);
		}
		
		if(!inputEndDate.equals("")) {
			String[] eSplit = inputEndDate.split("-");
			int eYear = Integer.parseInt(eSplit[0]);
			int eMonth = Integer.parseInt(eSplit[1]) - 1;
			int eDate = Integer.parseInt(eSplit[2]);
			Date endDate = new Date(new GregorianCalendar(eYear, eMonth, eDate).getTimeInMillis());	
			m.setEndDate(endDate);
		}
		
		if (m.getManagerYn() == null) {
			m.setManagerYn("N");
		}
		
		int result = aService.updateMember(m);
		
		if (result <= 0) {
			throw new AdminException("멤버 정보 수정에 실패하엿습니다.");
		}
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getmId();
			
		if (loginUserId.equals(m.getmId())) {
			Member loginMember = aService.selectMember(m.getmId());
			session.setAttribute("loginUser", loginMember);
		}
		

		model.addAttribute("mId", m.getmId()).addAttribute("message", "success").addAttribute("page", page);
		model.addAttribute("selectDept", selectDept).addAttribute("selectJob", selectJob).addAttribute("searchValue", searchValue);
		
		return "redirect:mdetail.ad";
	}
	
    /**
     * 직위 목록
     */
	@RequestMapping("admin/joblist.ad")
	public String selectJobList(Model model) {
		
		ArrayList<Job> jList = aService.selectJobList();
		
		if(jList != null) {
			model.addAttribute("jList", jList);
		} else {
			throw new AdminException("직위 목록 조회에 실패하엿습니다.");
		}
		
		return "jobList";
	}
	
    /**
     * 직위 삭제
     */
	@RequestMapping("admin/jdelete.ad")
	public void deleteJob(@RequestParam("jobIdArr") String[] jobIdArr, HttpServletResponse response) {
		
		int result = aService.deleteJob(jobIdArr);
		
		if (result != jobIdArr.length) {
			throw new AdminException("직위 삭제에 실패하엿습니다.");
		}
		
		ArrayList<Job> jList = aService.selectJobList();
		if(jList == null) {
			throw new AdminException("직위 목록을 불러오는데 실패하였습니다.");
		} 
		
		Gson gson = new Gson();
		try {
			gson.toJson(jList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}	
	
    /**
     * 직위 등록
     */
	@RequestMapping("admin/jinsert.ad")
	public void insertJob(@ModelAttribute Job job, HttpServletResponse response) {
		
		int result = aService.insertJob(job);
		
		if (result <= 0) {
			throw new AdminException("직위 등록에 실패하였습니다.");
		}
		
		ArrayList<Job> jList = aService.selectJobList();
		if(jList == null) {
			throw new AdminException("직위 목록을 불러오는데 실패하였습니다.");
		} 
		
		Gson gson = new Gson();
		try {
			gson.toJson(jList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
    /**
     * 직위 수정
     */
	@RequestMapping("admin/jupdate.ad")
	public void updateJob(@ModelAttribute Job job, HttpServletResponse response) {
		
		int result = aService.updateJob(job);
		
		if (result <= 0) {
			throw new AdminException("직위 수정에 실패하였습니다.");
		}
		
		ArrayList<Job> jList = aService.selectJobList();
		if(jList == null) {
			throw new AdminException("직위 목록을 불러오는데 실패하였습니다.");
		} 
		
		Gson gson = new Gson();
		try {
			gson.toJson(jList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
    /**
     * 부서 목록 조회
     */
	@RequestMapping("admin/deptlist.ad")
	public String selectDepartmentList(Model model, @RequestParam(value="message", required=false) String message) {
		
		ArrayList<Department> dList = aService.selectDepartmentList();
		ArrayList<Member> mList = aService.selectDeptMemberList(null);
		
		if(dList != null && mList != null) {
			model.addAttribute("dList", dList);
			model.addAttribute("mList", mList);
			model.addAttribute("message", message);
		} else {
			throw new AdminException("직위 목록 조회에 실패하엿습니다.");
		}
		
		return "deptList";		
	}	
	
    /**
     * 하위 부서 목록 조회
     */
	@RequestMapping("admin/subDeptList.ad")
	@ResponseBody
	public String getSubDeptList(@RequestParam("upperDept") Integer upperDept) {
		
		ArrayList<Department> subDeptList = aService.getSubDeptList(upperDept);
		ArrayList<Member> deptMemberList = aService.selectDeptMemberList(upperDept);
		
		if(subDeptList == null || deptMemberList == null) {
			throw new AdminException("하위 부서 목록 불러오기에 실패하였습니다.");
		}
		
		// 해당 부서의 하위 부서 목록과 해당 부서의 부서원 목록을 한 JSONArry객체에 담아서 view로 전송
		JSONArray jArr = new JSONArray();
		JSONObject jObj = null;
		for (Member m : deptMemberList) {
			jObj = new JSONObject();
			jObj.put("nodeId", m.getmId());
			jObj.put("nodeType", "member");
			jObj.put("nodeName", m.getmName());
			jObj.put("hasChildren", null);
			jObj.put("jobName", m.getJobName());
			
			jArr.add(jObj);
		}
		
		for (Department d : subDeptList) {
			jObj = new JSONObject();
			jObj.put("nodeId", d.getDeptId());
			jObj.put("nodeType", "dept");
			jObj.put("nodeName", d.getDeptName());
			jObj.put("hasChildren", d.getHasChildren());
			jObj.put("jobName", null);
			
			jArr.add(jObj);
		}
		
		return jArr.toJSONString();
	}
	
    /**
     * 부서 등록
     */
	@RequestMapping("admin/dinsert.ad")
	public void insertDept(@ModelAttribute Department dept, HttpServletResponse response) {
		
		if (dept.getUpperDept() != null) {
			ArrayList<Department> subDeptList = aService.getSubDeptList(dept.getUpperDept());
			// dept.setDeptOrder(subDeptList.size() + 1); // 정렬순서 마지막이 되도록 설정
			
			// 같은 상위부서를 가지고 있는 하위부서들의 정렬순서 중 가장 큰 것으로 저장되게 함
			int deptOrder = 0;
			if (subDeptList.size() > 0) {
				for (Department d : subDeptList) {
					if (deptOrder < d.getDeptOrder()) { 
						deptOrder = d.getDeptOrder(); 
					}
				}
				dept.setDeptOrder(deptOrder + 1);
			} else {
				dept.setDeptOrder(1);
			}
			
		} else {
			dept.setDeptOrder(1);
		}
		
		Department d = aService.insertDept(dept);
		if (d == null) {
			throw new AdminException("부서 등록에 실패하였습니다.");
		}
		System.out.println(d);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(d, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	
    /**
     * 부서 삭제
     */
	@RequestMapping("admin/ddelete.ad")
	public String deleteDept(@RequestParam("deptId") int deptId) {
		System.out.println(deptId);
		int result = aService.deleteDept(deptId);
		
		if (result <= 0) {
			throw new AdminException("부서 삭제에 실패하였습니다.");
		} else {
			return "redirect:deptlist.ad?message=d";
		}
	}
	
    /**
     * 부서 수정
     */
	@RequestMapping("admin/dupdate.ad")
	@ResponseBody
	public String updateDept(@ModelAttribute Department dept) {
		
		int result = aService.updateDept(dept);
		
		if (result <= 0) {
			throw new AdminException("부서 수정에 실패하였습니다.");
		} else {
			return "success";
		}
	}	
	
    /**
     * 조직도 내 부서 위치 이동
     */
	@RequestMapping("admin/dmove.ad")
	@ResponseBody
	public String moveDept(@RequestParam("moveDeptId") int moveDeptId, @RequestParam("upperDeptId") int upperDeptId, 
						  @RequestParam("upperDeptLevel") int upperDeptLevel, HttpServletResponse response) {
		
		int deptLevel = upperDeptLevel + 1; // 이동하려는 상위부서의 부서level + 1
		
		ArrayList<Department> subDeptList = aService.getSubDeptList(upperDeptId);
		int deptOrder = 0;
		
		// 같은 상위부서를 가지고 있는 하위부서들의 정렬순서 중 가장 큰 것으로 저장되게 함
		if (subDeptList.size() > 0) {
			for (Department d : subDeptList) {
				if (deptOrder < d.getDeptOrder()) { 
					deptOrder = d.getDeptOrder(); 
				}
			}
			deptOrder += 1;
		} else {
			deptOrder = 1;
		}
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("moveDeptId", moveDeptId);
		map.put("upperDeptId", upperDeptId);
		map.put("deptLevel", deptLevel);
		map.put("deptOrder", deptOrder);
		int result = aService.moveDept(map);
		
		if (result <= 0) {
			throw new AdminException("부서 위치 이동에 실패하였습니다.");
		} else {
			return "success";
		}
	}
	
	@RequestMapping("admin/reportList.ad")
	public ModelAndView reportList(@RequestParam(value="page", required=false) Integer page, 
								   @RequestParam(value="message", required=false) String message, ModelAndView mv) {

		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = aService.getReportListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
		ArrayList<Report> boardReportList = aService.selectBoardReportList(pi);
		ArrayList<Report> replyReportList = aService.selectReplyReportList(pi);
		
		if (boardReportList != null && replyReportList != null) {
			mv.addObject("boardReportList", boardReportList);
			mv.addObject("replyReportList", replyReportList);
			mv.addObject("pi", pi);
			mv.addObject("message", message);
			mv.setViewName("reportList");
		} else {
			throw new AdminException("신고글 목록 조회에 실패하였습니다.");
		}
			
		return mv;
	}
	
	@RequestMapping("admin/handingBoardReport.ad")
	public String handingBoardReport(@ModelAttribute Report report, 
						@RequestParam(value="page", required=false) Integer page, Model model) {
		
		int result = aService.handingBoardReport(report);
		
		String message = "";
		if (report.getReportStatus() == 1) {
			message = "d";
		} else {
			message = "c";
		}
		
		if (result > 0) {
			model.addAttribute("page", page);
			model.addAttribute("message", page);
		} else {
			throw new AdminException("신고글 처리에 실패하였습니다.");
		}
			
		return "redirect:reportList";
	}
	
	@RequestMapping("admin/handingReplyReport.ad")
	public String handingReplyReport(@ModelAttribute Report report, 
						@RequestParam(value="page", required=false) Integer page, Model model) {
		
		int result = aService.handingReplyReport(report);
		
		String message = "";
		if (report.getReportStatus() == 1) {
			message = "d";
		} else {
			message = "c";
		}
		
		if (result > 0) {
			model.addAttribute("page", page);
			model.addAttribute("message", page);
		} else {
			throw new AdminException("신고글 처리에 실패하였습니다.");
		}
			
		return "redirect:reportList";
	}
	
}