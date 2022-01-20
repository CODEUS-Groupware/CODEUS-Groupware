package com.codeusgroup.codeus.meetingResrv.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.meetingResrv.common.Pagination;
import com.codeusgroup.codeus.meetingResrv.model.exception.MeetingResrvException;
import com.codeusgroup.codeus.meetingResrv.model.service.MeetingResrvService;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingResrv;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;
import com.codeusgroup.codeus.meetingResrv.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;

@Controller
public class MeetingResrvController {
    
    @Autowired
    private MeetingResrvService mrService;
    
    @RequestMapping("mrlist.mr")
    public ModelAndView meetingRoomResrvList(@RequestParam(value = "page1", required = false) Integer page1,
            @RequestParam(value = "page2", required = false) Integer page2, ModelAndView mv, HttpSession session) {
        // 예약 종료 시간 이후에는 자동적으로 사용 완료로 변경
        Timestamp tNow = new Timestamp(System.currentTimeMillis());
        
        int result = mrService.autoUpdate(tNow);
        
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
        
        // view에 출력할 예약날짜 형태 설정(Rev_time)
        SimpleDateFormat sdf_date = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdf_time = new SimpleDateFormat("HH:mm");
        
        for (MeetingResrv meetingResrv : list1) {
            Date rev_date = meetingResrv.getRev_date();
            Timestamp rev_start_time = meetingResrv.getRev_start_time();
            Timestamp rev_end_time = meetingResrv.getRev_end_time();
            
            meetingResrv.setRev_time(sdf_date.format(rev_date) + "   " + sdf_time.format(rev_start_time) + " ~ "
                    + sdf_time.format(rev_end_time));
        }
        
        for (MeetingResrv meetingResrv : list2) {
            Date rev_date = meetingResrv.getRev_date();
            Timestamp rev_start_time = meetingResrv.getRev_start_time();
            Timestamp rev_end_time = meetingResrv.getRev_end_time();
            
            meetingResrv.setRev_time(sdf_date.format(rev_date) + "   " + sdf_time.format(rev_start_time) + " ~ "
                    + sdf_time.format(rev_end_time));
        }
        
        // view로 데이터 전달
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
        // 캘린더 연동 데이터 출력
        return "meetCalcView";
    }
    
    @RequestMapping("mrinsertview.mr")
    public String meetingResrvInsertView() {
        return "meetResrvInsertForm";
    }
    
    @RequestMapping("mrinsert.mr")
    public String meetingResrvInsert(@RequestParam("datepicker") Date r_date,
            @RequestParam("r_start_time") String r_start_time, @RequestParam("r_end_time") String r_end_time,
            @RequestParam("r_room") int r_room, @RequestParam("r_content") String r_content, HttpSession session) {
        // 예약 정보 입력
        MeetingResrv mr = new MeetingResrv();
        
        mr.setRev_date(r_date);   // 예약 날짜 입력
        
        // Timestamp 양식으로 변하기 위한 조건(예시 : String timeStr = "2022-01-01 12:30:00.0";)으로 변경
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String start_time = sdf.format(r_date) + " " + r_start_time + ":00";
        String end_time = sdf.format(r_date) + " " + r_end_time + ":00";
        
        mr.setRev_start_time(Timestamp.valueOf(start_time));    // 예약 시작시간 입력
        mr.setRev_end_time(Timestamp.valueOf(end_time));    // 예약 종료 시간 입력
        mr.setRev_content(r_content);   // 예약목적 내용 입력
        mr.setMeet_no(r_room);  // 예약 회의실 번호 입력
        mr.setmId(((Member) session.getAttribute("loginUser")).getmId());   // 예약자 아이디 입력
        
        int result = mrService.insertMeetingResrv(mr);
        
        if (result > 0)
            return "redirect:mrlist.mr";
        else
            throw new MeetingResrvException("회의실 예약 등록에 실패하였습니다.");
    }
    
    @RequestMapping(value = "mrcheckrooms.mr", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String checkRooms(@RequestParam("inputDate") Date inputDate,
            @RequestParam("inputStartTime") String inputStartTime, @RequestParam("inputEndTime") String inputEndTime) {
        // 입력된 날짜, 시간 정보 담기
        HashMap map = new HashMap();
        
        // Timestamp 양식으로 변하기 위한 조건(예시 : String timeStr = "2022-01-01 12:30:00.0";)으로 변경
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String start_time = sdf.format(inputDate) + " " + inputStartTime + ":00";
        String end_time = sdf.format(inputDate) + " " + inputEndTime + ":00";
        
        map.put("inputDate", inputDate);
        map.put("inputStartTime", Timestamp.valueOf(start_time));
        map.put("inputEndTime", Timestamp.valueOf(end_time));
        
        ArrayList<MeetingRoom> list = mrService.selectRoomList(map);
        
        Gson gson = new Gson();
        
        return gson.toJson(list);
    }
    
    @RequestMapping("mrupdateview.mr")
    public String meetingResrvUpdateView() {
        return "meetResrvUpdateForm";
    }
    
    @RequestMapping("mrdetail.mr")
    public String meetingDetail() {
        return "meetDetailView";
    }
    
}
