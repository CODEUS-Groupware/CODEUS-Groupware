package com.codeusgroup.codeus.leaveRecode.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;

public interface LeaveRecodeService {

	ArrayList<LeaveRecode> selectLeaveRecode(String id);

}
