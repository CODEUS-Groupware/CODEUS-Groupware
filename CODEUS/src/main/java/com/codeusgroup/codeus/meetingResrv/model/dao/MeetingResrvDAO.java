package com.codeusgroup.codeus.meetingResrv.model.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingResrv;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;
import com.codeusgroup.codeus.meetingResrv.model.vo.PageInfo;

@Repository("mrDAO")
public class MeetingResrvDAO {
    
    public int getListCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("meetResrvMapper.getListCount");
    }
    
    public ArrayList<MeetingResrv> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
        return (ArrayList) sqlSession.selectList("meetResrvMapper.selectList", pi, rowBounds);
    }
    
    public int getMyListCount(SqlSessionTemplate sqlSession, String mId) {
        return sqlSession.selectOne("meetResrvMapper.getMyListCount", mId);
    }
    
    public ArrayList<MeetingResrv> selectMyList(SqlSessionTemplate sqlSession, HashMap map) {
        int offset = (((PageInfo) map.get("pi2")).getCurrentPage() - 1) * ((PageInfo) map.get("pi2")).getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, ((PageInfo) map.get("pi2")).getBoardLimit());
        
        return (ArrayList) sqlSession.selectList("meetResrvMapper.selectMyList", map, rowBounds);
    }
    
    public int insertMeetingResrv(SqlSessionTemplate sqlSession, MeetingResrv mr) {
        return sqlSession.insert("meetResrvMapper.insertMeetResrv", mr);
    }
    
    public ArrayList<MeetingRoom> selectRoomList(SqlSessionTemplate sqlSession, HashMap map) {
        return (ArrayList) sqlSession.selectList("meetResrvMapper.selectRoomList", map);
    }
    
    public int autoUpdate(SqlSessionTemplate sqlSession, Timestamp tNow) {
        return sqlSession.update("meetResrvMapper.autoUpdate", tNow);
    }
    
    public int searchListCount(SqlSessionTemplate sqlSession, HashMap map) {
        return sqlSession.selectOne("meetResrvMapper.searchListCount", map);
    }
    
    public ArrayList<MeetingResrv> searchList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap map) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
        return (ArrayList) sqlSession.selectList("meetResrvMapper.searchList", map, rowBounds);
    }
    
}
