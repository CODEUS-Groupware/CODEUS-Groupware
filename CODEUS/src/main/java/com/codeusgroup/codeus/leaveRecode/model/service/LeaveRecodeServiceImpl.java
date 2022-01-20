package com.codeusgroup.codeus.leaveRecode.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.annualLeave.model.vo.PageInfo;
import com.codeusgroup.codeus.leaveRecode.model.dao.LeaveRecodeDAO;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;

@Service("lrService")
public class LeaveRecodeServiceImpl implements LeaveRecodeService{
	@Autowired
	private LeaveRecodeDAO lrDAO;
	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public int selectLrCount(String id) {
		
		return lrDAO.selectLrCount(sqlSession, id);
	}


	@Override
	public LeaveRecode selectUsedCount(String id) {
		
		return lrDAO.selectUsedCount(sqlSession, id);
	}


	@Override
	public ArrayList<LeaveRecode> selectAnnualList(String id) {
		
		return lrDAO.selectAnnualList(sqlSession, id);
	}
	@Override
	public int getAnnualListCount(String id) {
		
		return lrDAO.getAnnualList(sqlSession, id);
	}
	
	@Override
	public ArrayList<LeaveRecode> selectAnnualList(HashMap<String, String> map, PageInfo pi) {
		
		return lrDAO.selectAnnualList(sqlSession, pi, map);
	}
	

	@Override
	public int getAnnualSearchResultListCount(HashMap<String, String> map) {
		
		return lrDAO.getAnnualSearchResultListCount(sqlSession, map);
	}
	
	@Override
	public ArrayList<LeaveRecode> selectSearchAnnualResultList(PageInfo pi, HashMap<String, String> map) {
		
		return lrDAO.selectSearchAnnualResultList(sqlSession, pi, map);
	}


	

}
