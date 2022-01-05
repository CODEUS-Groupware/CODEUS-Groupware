package com.codeusgroup.codeus.address.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.address.model.exception.AddressException;
import com.codeusgroup.codeus.address.model.service.AddressService;
import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.address.common.Pagination;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class addressController {
	
	@Autowired
	private AddressService addrService;
	
	@RequestMapping("list.addr")
	public String addressListView() {
		return "addressListView";
	}
	
	@RequestMapping("search.addr")
	public ModelAndView addressSearchView(@RequestParam(value="page", required = false) Integer page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = addrService.getListCount();
		
		PageInfo pi =  Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Member> list = addrService.selectMemebrList(pi);
		
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
}
