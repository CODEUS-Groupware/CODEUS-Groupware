package com.codeusgroup.codeus.calendar.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.calendar.model.vo.CalArrTemp;
import com.codeusgroup.codeus.calendar.model.vo.Calendar;

public interface CalendarService {

	ArrayList<Calendar> readCalList(String mId);

	int addCal(Calendar cal);

	int addModalSch(HashMap<String, String> map);

	ArrayList<Calendar> selectSchList(CalArrTemp cat);

	ArrayList<Calendar> selectNoCalSchList(CalArrTemp cat);

}
