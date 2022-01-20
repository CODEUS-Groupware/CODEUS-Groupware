package com.codeusgroup.codeus.leaveRecode.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.annualLeave.model.vo.PageInfo;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;

public interface LeaveRecodeService {



	int selectLrCount(String id);

	LeaveRecode selectUsedCount(String id);
	
	ArrayList<LeaveRecode> selectAnnualList(String id);

	int getAnnualListCount(String id);
	
	ArrayList<LeaveRecode> selectAnnualList(HashMap<String, String> map, PageInfo pi);
	
	int getAnnualSearchResultListCount(HashMap<String, String> map);
	

	ArrayList<LeaveRecode> selectSearchAnnualResultList(PageInfo pi, HashMap<String, String> map);

}
