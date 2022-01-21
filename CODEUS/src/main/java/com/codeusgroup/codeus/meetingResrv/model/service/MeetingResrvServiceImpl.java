package com.codeusgroup.codeus.meetingResrv.model.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
    
    @Override
    public int searchListCount(HashMap map) {
        return mrDAO.searchListCount(sqlSession, map);
    }
    
    @Override
    public ArrayList<MeetingResrv> searchList(PageInfo pi, HashMap map) {
        return mrDAO.searchList(sqlSession, pi, map);
    }
    
    @Override
    public int searchMyListCount(HashMap map) {
        return mrDAO.searchMyListCount(sqlSession, map);
    }
    
    @Override
    public ArrayList<MeetingResrv> searchMyList(PageInfo pi, HashMap map) {
        return mrDAO.searchMyList(sqlSession, pi, map);
    }
    
    @Override
    public MeetingResrv selectMeetingResrv(int rNo) {
        return mrDAO.selectMeetingResrv(sqlSession, rNo);
    }
    
    @Override
    public int updateMeetingResrv(MeetingResrv mr) {
        return mrDAO.updateMeetingResrv(sqlSession, mr);
    }
    
    @Override
    public int completeMeetingResrv(int rNo) {
        return mrDAO.completeMeetingResrv(sqlSession, rNo);
    }
    
    @Override
    public int cancelMeetingResrv(int rNo) {
        return mrDAO.cancelMeetingResrv(sqlSession, rNo);
    }
    
    @Override
    public int completesMeetingResrv(List<Integer> chksList) {
        return mrDAO.completesMeetingResrv(sqlSession, chksList);
    }
    
    @Override
    public int cancelsMeetingResrv(List<Integer> chksList) {
        return mrDAO.cancelsMeetingResrv(sqlSession, chksList);
    }
    
}
