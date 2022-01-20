package com.codeusgroup.codeus.annualLeave.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.annualLeave.common.Pagination;
import com.codeusgroup.codeus.annualLeave.model.exception.AnnualLeaveException;
import com.codeusgroup.codeus.annualLeave.model.service.AnnualLeaveService;
import com.codeusgroup.codeus.annualLeave.model.vo.PageInfo;
import com.codeusgroup.codeus.document.model.vo.Document;
import com.codeusgroup.codeus.empStatus.model.service.EmpStatusService;
import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.leaveRecode.model.service.LeaveRecodeService;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;
import com.codeusgroup.codeus.member.model.vo.Member;


@Controller
public class AnnualLeaveController {
	
	@Autowired
	private AnnualLeaveService alService;
	@Autowired
	private EmpStatusService esService;
	@Autowired
	private LeaveRecodeService lrService;
	
	@RequestMapping("annualLeaveMain.al")
	public String annualLeaveMain(Model model, HttpServletRequest request) {
		//연차현황페이지 이동 시 근속연수 구하여 연차갯수 증가(만약 연차등록일이 null' '일 때는 증가x)
		
		HttpSession session = request.getSession();
		session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		EmpStatus empStatus = new EmpStatus(0, null, null, null, null, null, id, null, null);
		EmpStatus empStatus1 = esService.selectComTime(id);
		EmpStatus empOffTime = esService.selectOffTime(id);

		model.addAttribute("empStatus1", empStatus1);
		model.addAttribute("empOffTime", empOffTime);	
		
		//연차신청현황 불러오기
		ArrayList<LeaveRecode> lrList = lrService.selectAnnualList(id);
			if(!lrList.isEmpty()) {
			System.out.println("연차신청:"+lrList);
			for(int i = 0; i < lrList.size(); i++) {
				if(lrList.get(i).getLeaveStatus().equals("0")) {
					lrList.get(i).setLeaveStatus("예정");
				}else if(lrList.get(i).getLeaveStatus().equals("1")) {
					lrList.get(i).setLeaveStatus("대기");
				}else if(lrList.get(i).getLeaveStatus().equals("2")) {
					lrList.get(i).setLeaveStatus("승인");
				}else if(lrList.get(i).getLeaveStatus().equals("3")) {
					lrList.get(i).setLeaveStatus("반려");
				}
			}
	
			model.addAttribute("lrList", lrList);	
			//총 연차갯수 가져오기
			
			}
			int alCount = alService.selectAnnualStatus(id);
			if(alCount > 0) {
				alCount = alCount;
			}else {
				alCount = 0;
			}
			model.addAttribute("alCount", alCount);
			
			//사용한 연차 가져오기
			LeaveRecode lr = lrService.selectUsedCount(id);
			System.out.println("사용한 연차11:"+lr);
			/*if(lr == null) {
				System.out.println("1111111111111111111111111111111111111111");
				lr.setUsedLeave(0);
				System.out.println("사용한 연차:"+lr.getUsedLeave());
			}*/
			model.addAttribute("lr", lr);	

		return "annualLeaveMain";
	}
	//연차신청리스트페이지
	@RequestMapping("annualLeaveTotal.al")
	public String annualLeaveTotal(@RequestParam(value="page", required=false) Integer page, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		EmpStatus empStatus1 = esService.selectComTime(id);		 
		 model.addAttribute("empStatus1", empStatus1);
		 
		 int currentPage = 1;
			if(page != null) {
				currentPage = page;
			}
			
			int listCount = lrService.getAnnualListCount(id);
			System.out.println("게시글수:"+listCount);
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			HashMap<String, String> map = new HashMap<>();
			map.put("id", id);
		
			ArrayList<LeaveRecode> lrList = lrService.selectAnnualList(map, pi);
			
			System.out.println("연차신청리스트:"+lrList);
			if(lrList != null) {
				for(int i = 0; i < lrList.size(); i++) {
					if(lrList.get(i).getLeaveStatus().equals("0")) {
						lrList.get(i).setLeaveStatus("예정");
					}else if(lrList.get(i).getLeaveStatus().equals("1")) {
						lrList.get(i).setLeaveStatus("대기");
					}else if(lrList.get(i).getLeaveStatus().equals("2")) {
						lrList.get(i).setLeaveStatus("승인");
					}else if(lrList.get(i).getLeaveStatus().equals("3")) {
						lrList.get(i).setLeaveStatus("반려");
					}
				}
				//1. 반환값이 String인 상태에서 view에 데이터 전달 : Model추가
				model.addAttribute("pi", pi);
				model.addAttribute("lrList", lrList);

			}else {
				throw new AnnualLeaveException("연차신청 전체 조회에 실패하였습니다.");
			}
		 
		 
		return "annualLeaveTotal";
	}
	
	@RequestMapping("annualStatus.al")
	public void selectAnnualStatus(HttpServletResponse response, HttpSession session) {
		response.setContentType("application/json; charset=UTF-8");
	}
	
	/*@RequestMapping("addAnnualLeave.al")
	public void addAnnualLeave(HttpServletResponse response) {
		int annual = 0;
		String strResult = null;
		//근속연수구함
		ArrayList<Member> list = alService.selectAnnualCount();
		System.out.println("리스트:"+list);
		//만약 현재년도의 데이터가 없으면 연차 추가하기--> 아니면 알림창뜨기	
		int checkCount = 0;
		int checkAl = alService.selectAddAnnual();
		System.out.println("연차리스트:"+checkAl);

	}
	
	*/
	
	@RequestMapping("leaveSearch.al")
	public ModelAndView searchAnnualLeaveDoc(HttpServletRequest request, @RequestParam("searchCondition") String searchCondition, 
									 @RequestParam("searchValue") String searchValue, @RequestParam(value="page", required=false) Integer page,
									 ModelAndView mv) {
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginUser");
		String id = member.getmId();
		
		if(searchCondition.equals("status")) {
			if(searchValue.equals("예정")) {
				searchValue = "0";
			}else if(searchValue.equals("대기")) {
				searchValue = "1";
			}else if(searchValue.equals("승인")) {
				searchValue = "2";
			}else if(searchValue.equals("반려")) {
				searchValue = "3";
			}
		}
		
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("condition", searchCondition);
		map.put("value", searchValue);
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		System.out.println("컨디션:"+searchCondition);
		System.out.println("밸류:"+searchValue);
		int listCount = lrService.getAnnualSearchResultListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		 
		ArrayList<LeaveRecode> lrList = lrService.selectSearchAnnualResultList(pi, map);
		
		if(lrList != null) {
			for(int i = 0; i < lrList.size(); i++) {
				if(lrList.get(i).getLeaveStatus().equals("0")) {
					lrList.get(i).setLeaveStatus("예정");
				}else if(lrList.get(i).getLeaveStatus().equals("1")) {
					lrList.get(i).setLeaveStatus("대기");
				}else if(lrList.get(i).getLeaveStatus().equals("2")) {
					lrList.get(i).setLeaveStatus("승인");
				}else if(lrList.get(i).getLeaveStatus().equals("3")) {
					lrList.get(i).setLeaveStatus("반려");
				}
			}
			mv.addObject("lrList", lrList);
			mv.addObject("alSearchCondition", searchCondition);
			mv.addObject("alSearchValue", searchValue);
			mv.addObject("pi", pi);
			mv.setViewName("annualLeaveTotal");			
		} else {
			throw new AnnualLeaveException("게시글 목록 검색 실패");
		}
		
		return mv;
	}
	

	

}
