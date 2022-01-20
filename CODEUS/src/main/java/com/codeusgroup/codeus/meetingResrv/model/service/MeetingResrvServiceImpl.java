package com.codeusgroup.codeus.meetingResrv.model.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.meetingResrv.model.dao.MeetingResrvDAO;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingResrv;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;
import com.codeusgroup.codeus.meetingResrv.model.vo.PageInfo;

@Service("mrService")
public class MeetingResrvServiceImpl implements MeetingResrvService {
    
    @Autowired
    private MeetingResrvDAO mrDAO;
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    @Override
    public int getListCount() {
        return mrDAO.getListCount(sqlSession);
    }
    
    @Override
    public ArrayList<MeetingResrv> selectList(PageInfo pi) {
        return mrDAO.selectList(sqlSession, pi);
    }
    
    @Override
    public int getMyListCount(String mId) {
        return mrDAO.getMyListCount(sqlSession, mId);
    }
    
    @Override
    public ArrayList<MeetingResrv> selectMyList(HashMap map) {
        return mrDAO.selectMyList(sqlSession, map);
    }
    
    @Override
    public int insertMeetingResrv(MeetingResrv mr) {
        return mrDAO.insertMeetingResrv(sqlSession, mr);
    }
    
    @Override
    public ArrayList<MeetingRoom> selectRoomList(HashMap map) {
        return mrDAO.selectRoomList(sqlSession, map);
    }
    
    @Override
    public int autoUpdate(Timestamp tNow) {
        return mrDAO.autoUpdate(sqlSession, tNow);
    }
    
}
