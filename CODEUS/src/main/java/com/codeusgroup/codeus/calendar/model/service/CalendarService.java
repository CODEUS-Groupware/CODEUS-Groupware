package com.codeusgroup.codeus.calendar.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.calendar.model.vo.CalArrTemp;
import com.codeusgroup.codeus.calendar.model.vo.Calendar;
import com.codeusgroup.codeus.member.model.vo.Member;

public interface CalendarService {

	ArrayList<Calendar> readCalList(String mId);

	ArrayList<Calendar> readAdminCalList();
	
	int addCal(Calendar cal);

	int addModalSch(Calendar cal);

	ArrayList<Calendar> selectSchList(CalArrTemp cat);
	
	ArrayList<Calendar> selectadminSchList(CalArrTemp cat);

	ArrayList<Calendar> selectNoCalSchList(CalArrTemp cat);

	Calendar selectOneSch(int scheNo);

	ArrayList<Member> selectAtd(HashMap<String, String> map);

	ArrayList<Member> mSearchList(HashMap<String, String> map);

	ArrayList<String> findDelSchNo(HashMap<String, Object> map);

	ArrayList<String> selectGroupId(HashMap<String, Object> map);

	int addDetailSch(HashMap<String, Object> map) throws Throwable;

	int delSch(HashMap<String, Object> map);

	int doEditSch(HashMap<String, Object> map);


}
