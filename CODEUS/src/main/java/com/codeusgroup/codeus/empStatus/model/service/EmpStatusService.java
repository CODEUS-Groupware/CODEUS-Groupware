package com.codeusgroup.codeus.empStatus.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.member.model.vo.Member;

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

	ArrayList<EmpStatus> selectDeptEmpStatus(String id);

	ArrayList<EmpStatus> selectDeptWorkTime(HashMap<String, String> map);

	ArrayList<EmpStatus> commuteList(HashMap<String, String> map);

	ArrayList<EmpStatus> overworkList(HashMap<String, String> map);

	EmpStatus monthTotalTime(HashMap<String, String> map);

	ArrayList<EmpStatus> selectDeptWeekList(HashMap<String, String> map);

	

	
	


}
