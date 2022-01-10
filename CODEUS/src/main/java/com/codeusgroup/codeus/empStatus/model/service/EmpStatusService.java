package com.codeusgroup.codeus.empStatus.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;

public interface EmpStatusService {

	int insertComTime(EmpStatus empStatus);

	EmpStatus selectComTime(String id);

	int updateOffTime(EmpStatus empStatus);

	EmpStatus selectOffTime(String id);

	int updateStatus(EmpStatus empStatus);

	int updateGapTime(EmpStatus emp);

	EmpStatus selectWeekTime(String id);

	EmpStatus selectMonthTime(String id);

	ArrayList<EmpStatus> monthWorkTime(HashMap<String, String> map);

	

	
	


}
