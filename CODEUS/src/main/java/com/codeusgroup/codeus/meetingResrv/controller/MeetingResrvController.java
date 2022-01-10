package com.codeusgroup.codeus.meetingResrv.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.meetingResrv.common.Pagination;
import com.codeusgroup.codeus.meetingResrv.model.exception.MeetingResrvException;
import com.codeusgroup.codeus.meetingResrv.model.service.MeetingResrvService;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingResrv;
import com.codeusgroup.codeus.meetingResrv.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class MeetingResrvController {
    
    @Autowired
    private MeetingResrvService mrService;
    
    @RequestMapping("/mrlist.mr")
    public ModelAndView meetingRoomResrvList(@RequestParam(value = "page1", required = false) Integer page1,
            @RequestParam(value = "page2", required = false) Integer page2, ModelAndView mv, HttpSession session) {
        // 전체 예약 목록 조회
        int currentPage1 = 1;
        if (page1 != null)
            currentPage1 = page1;
        
        int listCount1 = mrService.getListCount();
        
        PageInfo pi1 = Pagination.getPageInfo(currentPage1, listCount1);
        
        ArrayList<MeetingResrv> list1 = mrService.selectList(pi1);
        
        // 내 예약 목록 조회
        int currentPage2 = 1;
        if (page2 != null)
            currentPage2 = page2;
        
        String loginUserId = ((Member) session.getAttribute("loginUser")).getmId();
        
        int listCount2 = mrService.getMyListCount(loginUserId);
        
        PageInfo pi2 = Pagination.getPageInfo(currentPage2, listCount2);
        
        HashMap map = new HashMap();
        map.put("mId", loginUserId);
        map.put("pi2", pi2);
        ArrayList<MeetingResrv> list2 = mrService.selectMyList(map);
        
        if (list1 != null && list2 != null) {
            mv.addObject("pi1", pi1);
            mv.addObject("list1", list1);
            
            mv.addObject("pi2", pi2);
            mv.addObject("list2", list2);
            
            mv.setViewName("meetListView");
        } else
            throw new MeetingResrvException("예약 내역 조회에 실패하였습니다.");
        
        return mv;
    }
    
    @RequestMapping("mrcal.mr")
    public String meetingResrvCal() {
        return "meetCalcView";
    }
    
    @RequestMapping("mrresrvinsert.mr")
    public String meetingResrvInsertView() {
        return "meetResrvInsertForm";
    }
    
    @RequestMapping("mrresrvupdate.mr")
    public String meetingResrvUpdateView() {
        return "meetResrvUpdateForm";
    }
    
}
