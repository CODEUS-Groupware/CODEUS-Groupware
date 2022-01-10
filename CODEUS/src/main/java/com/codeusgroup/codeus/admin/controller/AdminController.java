package com.codeusgroup.codeus.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.admin.common.Pagination;
import com.codeusgroup.codeus.admin.model.exception.AdminException;
import com.codeusgroup.codeus.admin.model.service.AdminService;
import com.codeusgroup.codeus.admin.model.vo.Department;
import com.codeusgroup.codeus.admin.model.vo.Job;
import com.codeusgroup.codeus.admin.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService aService;
	
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
			mv.addObject("message", message);
			mv.setViewName("memberList");
		} else {
			throw new AdminException("멤버 리스트 조회에 실패하엿습니다.");
		}
		
		return mv;
	}
	
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
	
	@RequestMapping("admin/mupdatemulti.ad")
	public String updateMultiMember(@RequestParam("mId") String[] mIdArr, @RequestParam("mStatus") int mStatus) {
		
		int result = aService.updateMultiMember(mIdArr, mStatus);
		
		if (result != mIdArr.length) {
			throw new AdminException("멤버 정보 수정에 실패하엿습니다.");
		}
		
		return "redirect:mlist.ad?message=u";
	}

	@RequestMapping("admin/mdelete.ad")
	public String deleteMember(@RequestParam("mId") String[] mIdArr) {
		
		int result = aService.deleteMember(mIdArr);
		
		if (result != mIdArr.length) {
			throw new AdminException("멤버 삭제에 실패하엿습니다.");
		}
		
		return "redirect:mlist.ad?message=d";
	}	
	
	@RequestMapping("admin/mdetail.ad")
	public ModelAndView memberDetail(@RequestParam("mId") String mId, @RequestParam("page") int page, 
									 @RequestParam(value="selectDept", required=false) String selectDept,
									 @RequestParam(value="selectJob",  required=false) String selectJob,
									 @RequestParam(value="searchValue", required=false) String searchValue, 
									 @RequestParam(value="message", required=false) String message, ModelAndView mv) {
		Member member = aService.selectMember(mId);
		ArrayList<Department> dList = aService.selectDepartmentList();
		ArrayList<Job> jList = aService.selectJobList();
		mv.addObject("dList", dList);
		mv.addObject("jList", jList);
		
		if (member != null && dList != null && jList != null) {
			mv.addObject("member", member);
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
	
	@RequestMapping("admin/mupdate.ad")
	public String updateMember(@ModelAttribute Member m, @RequestParam("inputHireDate") String inputHireDate, 
							   @RequestParam("inputEndDate") String inputEndDate, @RequestParam("page") int page,
							   @RequestParam(value="selectDept", required=false) String selectDept,
							   @RequestParam(value="selectJob",  required=false) String selectJob,
							   @RequestParam(value="searchValue", required=false) String searchValue, Model model) {
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

		model.addAttribute("mId", m.getmId()).addAttribute("message", "success").addAttribute("page", page);
		model.addAttribute("selectDept", selectDept).addAttribute("selectJob", selectJob).addAttribute("searchValue", searchValue);
		
		return "redirect:mdetail.ad";
	}
	
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
	
	@RequestMapping("admin/jinsert.ad")
	public void insertJob(@ModelAttribute Job job, HttpServletResponse response) {
		
		int result = aService.insertJob(job);
		
		if (result < 0) {
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
	
	@RequestMapping("admin/jupdate.ad")
	public void updateJob(@ModelAttribute Job job, HttpServletResponse response) {
		
		int result = aService.updateJob(job);
		
		if (result < 0) {
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
	
	@RequestMapping("admin/deptlist.ad")
	public String selectDepartmentList(Model model) {
		
		ArrayList<Department> dList = aService.selectDepartmentList();
		ArrayList<Member> mList = aService.selectDeptMemberList(null);
		
		if(dList != null && mList != null) {
			model.addAttribute("dList", dList);
			model.addAttribute("mList", mList);
		} else {
			throw new AdminException("직위 목록 조회에 실패하엿습니다.");
		}
		
		return "deptList";		
	}	
	
	@RequestMapping("admin/subDeptList.ad")
	@ResponseBody
	public String getSubDeptList(@RequestParam("upperDept") Integer upperDept, HttpServletResponse response) {
		
		ArrayList<Department> subDeptList = aService.getSubDeptList(upperDept);
		ArrayList<Member> deptMemberList = aService.selectDeptMemberList(upperDept);
		
		if(subDeptList == null || deptMemberList == null) {
			throw new AdminException("하위 부서 목록 불러오기에 실패하였습니다.");
		}
		
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
	
	@RequestMapping("admin/dinsert.ad")
	public void insertDept(@ModelAttribute Department dept, HttpServletResponse response) {
		
		ArrayList<Department> subDeptList = aService.getSubDeptList(dept.getUpperDept());
		dept.setDeptOrder(subDeptList.size() + 1);
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
	
}
