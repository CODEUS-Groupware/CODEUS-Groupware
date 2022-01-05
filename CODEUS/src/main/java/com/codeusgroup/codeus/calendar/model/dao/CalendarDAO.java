package com.codeusgroup.codeus.calendar.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.calendar.model.vo.Calendar;

@Repository("cDAO")
public class CalendarDAO {

	public ArrayList<Calendar> selectCalList(SqlSessionTemplate sqlSession, String mId) {
		return (ArrayList)sqlSession.selectList("calendarMapper.selectCalList", mId);
	}

	public int addCal(SqlSessionTemplate sqlSession, Calendar cal) {
		return sqlSession.insert("calendarMapper.insertCal", cal);
	}

	public int addModalSch(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.insert("calendarMapper.addModalSch", map);
	}

	public String scheNo(SqlSessionTemplate sqlSession) {
		String seq = sqlSession.selectOne("calendarMapper.scheNo");
		
		return seq;
	}
	

}
