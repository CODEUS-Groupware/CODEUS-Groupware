package com.codeusgroup.codeus.annualLeave.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.annualLeave.model.dao.AnnualLeaveDAO;
import com.codeusgroup.codeus.annualLeave.model.vo.AnnualLeave;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("alService")
public class AnnualLeaveServiceImpl implements AnnualLeaveService{
	
	@Autowired
	private AnnualLeaveDAO alDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Member> selectAnnualCount() {
		ArrayList<Member> list = alDAO.selectAnnualCount(sqlSession);
		return list;
	}

	@Override
	public int insertAnnualCount(AnnualLeave al) {
		
		return alDAO.insertAnnualCount(sqlSession, al);
	}

	@Override
	public int selectAnnualStatus(AnnualLeave al) {
		
		return alDAO.selectAnnualStatus(sqlSession, al);
	}

	@Override
	public int selectAnnualStatus(String id) {
		return alDAO.selectAnnualStatus(sqlSession, id);
		
	}

	@Override
	public int selectAddAnnual() {
		
		return alDAO.selectAddAnnual(sqlSession);
	}

	
	@Override
	public ArrayList<Member> selectMember() {
		
		return alDAO.selectMember(sqlSession);
	}

	@Override
	public ArrayList<AnnualLeave> selectCheckAnnual(String id) {
		
		return alDAO.selectCheckAnnual(sqlSession, id);
	}

	@Override
	public AnnualLeave selectAnnual(String id) {
		
		return alDAO.selectAnnual(sqlSession, id);
	}

	@Override
	public int insertAnnualCount(HashMap<String, String> map) {
		
		return alDAO.insertAnnualCount(sqlSession, map);
	}



	

	

}
