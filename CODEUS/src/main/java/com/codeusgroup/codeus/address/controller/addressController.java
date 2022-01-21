package com.codeusgroup.codeus.address.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.address.common.Pagination;
import com.codeusgroup.codeus.address.model.exception.AddressException;
import com.codeusgroup.codeus.address.model.service.AddressService;
import com.codeusgroup.codeus.address.model.vo.Address;
import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class addressController {
	
	@Autowired
	private AddressService addrService;
	
	@RequestMapping("list.addr")
	public ModelAndView addressListView(@RequestParam(value="page", required = false) Integer page,
										HttpServletRequest request,
										ModelAndView mv) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = addrService.getMyListCount(userId);
		
		PageInfo pi =  Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Member> list = addrService.selectMyList(pi, userId);
		
		if(list != null) {
			mv.addObject("pi", pi);
			mv.addObject("list", list);
			mv.setViewName("addressListView");
			
		} else {
			throw new AddressException("내 주소록 조회에 실패했습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("search.addr")
	public ModelAndView addressSearchView(@RequestParam(value="page", required = false) Integer page,
										  HttpServletRequest request,
										  ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = addrService.getListCount();
		
		PageInfo pi =  Pagination.getPageInfo(currentPage, listCount);
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		
		ArrayList<Member> list = addrService.selectMemebrList(pi, userId);
		
		if(list != null) {
			mv.addObject("pi", pi);
			mv.addObject("list", list);
			mv.setViewName("addressSearchView");
			
		} else {
			throw new AddressException("주소록 조회에 실패했습니다.");
		}
		
		//return "boardListView";
		return mv;
	}
	
	@RequestMapping("research.addr")
	public ModelAndView addressSearch(@RequestParam(value="input", required = false) String input,
									  @RequestParam(value="field", required = false) String field,
									  @RequestParam(value="page", required = false) Integer page,
									  ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		System.out.println(input);
		System.out.println(field);

		int listCount = addrService.getListCount();
		
		PageInfo pi =  Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Member> list = addrService.searchMemebrList(pi, input, field);
		
		if(list != null) {
			mv.addObject("pi", pi);
			mv.addObject("list", list);
			mv.setViewName("searchResultView");
			
		} else {
			throw new AddressException("주소록 검색에 실패했습니다.");
		}
		return mv;
	}
	
	@RequestMapping(value="add.addr", method = RequestMethod.POST)
	@ResponseBody
	public String addAddress(@ModelAttribute Address addr,
							 @RequestParam(value="mId", required = false) String mId,
							 HttpServletRequest request) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		addr.setMyMId(userId);
		
		System.out.println(userId);
		System.out.println(mId);
		
		int result = addrService.addAddress(userId, mId);
		
		if(result > 0) {
			System.out.println("주소록 추가");
			return "success";
		} else {
			throw new AddressException("주소록 추가에 실패했습니다.");
		}
	}
	
	@RequestMapping(value="minus.addr", method = RequestMethod.POST)
	@ResponseBody
	public String minusAddress(@ModelAttribute Address addr,
							 @RequestParam(value="mId", required = false) String mId,
							 HttpServletRequest request) {
		
		String userId = ((Member)request.getSession().getAttribute("loginUser")).getmId();
		addr.setMyMId(userId);
		
		System.out.println(userId);
		System.out.println(mId);
		
		int result = addrService.minusAddress(userId, mId);
		
		if(result > 0) {
			System.out.println("주소록 삭제");
			return "success";
		} else {
			throw new AddressException("주소록 삭제에 실패했습니다.");
		}
	}
}
