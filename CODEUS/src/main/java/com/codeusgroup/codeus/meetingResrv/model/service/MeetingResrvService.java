package com.codeusgroup.codeus.meetingResrv.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingResrv;
import com.codeusgroup.codeus.meetingResrv.model.vo.PageInfo;

public interface MeetingResrvService {
    
    int getListCount();
    
    ArrayList<MeetingResrv> selectList(PageInfo pi);
    
    int getMyListCount(String mId);
    
    ArrayList<MeetingResrv> selectMyList(HashMap map);
    
}
