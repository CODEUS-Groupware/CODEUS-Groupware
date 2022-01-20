package com.codeusgroup.codeus.meetingResrv.model.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingResrv;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;
import com.codeusgroup.codeus.meetingResrv.model.vo.PageInfo;

public interface MeetingResrvService {
    
    int getListCount();
    
    ArrayList<MeetingResrv> selectList(PageInfo pi);
    
    int getMyListCount(String mId);
    
    ArrayList<MeetingResrv> selectMyList(HashMap map);
    
    int insertMeetingResrv(MeetingResrv mr);
    
    ArrayList<MeetingRoom> selectRoomList(HashMap map);
    
    int autoUpdate(Timestamp tNow);
    
    int searchListCount(HashMap map);
    
    ArrayList<MeetingResrv> searchList(PageInfo pi, HashMap map);
    
    int searchMyListCount(HashMap map);
    
    ArrayList<MeetingResrv> searchMyList(PageInfo pi, HashMap map);
    
    MeetingResrv selectMeetingResrv(int rNo);
    
    int updateMeetingResrv(MeetingResrv mr);
    
}
