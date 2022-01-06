package com.codeusgroup.codeus.meetingResrv.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codeusgroup.codeus.meetingResrv.model.service.MeetingResrvService;

@Controller
public class MeetingResrvController {
    
    @Autowired
    private MeetingResrvService mrService;
    
    @RequestMapping("mrlist.mr")
    public String meetingRoomList() {
        return "meetListView";
    }
    
    @RequestMapping("mrcal.mr")
    public String meetingResrvCal() {
        return "meetCalcView";
    }
    
    @RequestMapping("mrresrvlist.mr")
    public String meetingResrvList() {
        return "meetResrvListView";
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
