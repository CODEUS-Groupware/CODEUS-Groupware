package com.codeusgroup.codeus.calendar.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.calendar.model.dao.CalendarDAO;
import com.codeusgroup.codeus.calendar.model.vo.Calendar;

@Service("cService")
public class CalendarServiceImpl implements CalendarService{
	
	@Autowired
	private CalendarDAO cDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Calendar> readCalList(String mId) {
		return cDAO.selectCalList(sqlSession, mId);
	}

	@Override
	public int addCal(Calendar cal) {
		return cDAO.addCal(sqlSession, cal);
	}

	@Override
	public int addModalSch(HashMap<String, String> map) {
		String seq = cDAO.scheNo(sqlSession);
		map.put("seq", seq);
		int result = 0;
		int result2 = cDAO.addModalSch(sqlSession, map);
		
		return result;
	}

}
