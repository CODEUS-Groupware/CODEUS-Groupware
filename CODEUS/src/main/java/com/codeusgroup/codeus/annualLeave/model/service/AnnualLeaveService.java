package com.codeusgroup.codeus.annualLeave.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.annualLeave.model.vo.AnnualLeave;
import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;
import com.codeusgroup.codeus.member.model.vo.Member;

public interface AnnualLeaveService {

	ArrayList<Member> selectAnnualCount();

	int insertAnnualCount(AnnualLeave al);

	int selectAnnualStatus(AnnualLeave al);

	int selectAnnualStatus(String id);

	int selectAddAnnual();


	ArrayList<Member> selectMember();

	ArrayList<AnnualLeave> selectCheckAnnual(String id);

	AnnualLeave selectAnnual(String id);

	int insertAnnualCount(HashMap<String, String> map);




	

	

}
