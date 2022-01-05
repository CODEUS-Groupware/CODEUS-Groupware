package com.codeusgroup.codeus.leaveRecode.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.leaveRecode.model.dao.LeaveRecodeDAO;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;

@Service("lrService")
public class LeaveRecodeServiceImpl implements LeaveRecodeService{
	@Autowired
	private LeaveRecodeDAO lrDAO;
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<LeaveRecode> selectLeaveRecode(String id) {
		
		return lrDAO.selectLeaveRecode(sqlSession, id);
	}

}
