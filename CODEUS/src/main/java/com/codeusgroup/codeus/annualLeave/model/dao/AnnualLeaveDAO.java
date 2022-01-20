package com.codeusgroup.codeus.annualLeave.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.annualLeave.model.vo.AnnualLeave;
import com.codeusgroup.codeus.annualLeave.model.vo.PageInfo;
import com.codeusgroup.codeus.document.model.vo.Document;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("AnnualLeaveDAO")
public class AnnualLeaveDAO {

	public ArrayList<Member> selectAnnualCount(SqlSessionTemplate sqlSession) {
		ArrayList<Member> list = (ArrayList)sqlSession.selectList("annualLeaveMapper.selectAnnualCount");
		return list;
	}

	public int insertAnnualCount(SqlSessionTemplate sqlSession, AnnualLeave al) {
		int result = sqlSession.insert("annualLeaveMapper.insertAnnualCount", al);
		return result;
	}

	public int selectAnnualStatus(SqlSessionTemplate sqlSession, AnnualLeave al) {
		int result = sqlSession.selectOne("annualLeaveMapper.selectAnnualStatus", al);
		System.out.println("결과1:"+result);
		return result;
	}

	public int selectAnnualStatus(SqlSessionTemplate sqlSession, String id) {
		
		return sqlSession.selectOne("annualLeaveMapper.selectAnnualStatusId", id);
	}

	public int selectAddAnnual(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("annualLeaveMapper.selectAddAnnual");
				
	}

	public ArrayList<Member> selectMember(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("annualLeaveMapper.selectMember");
	}

	public ArrayList<AnnualLeave> selectCheckAnnual(SqlSessionTemplate sqlSession, String id) {
		
		return (ArrayList)sqlSession.selectList("annualLeaveMapper.selectCheckAnnual", id);
	}

	public AnnualLeave selectAnnual(SqlSessionTemplate sqlSession, String id) {
		
		return sqlSession.selectOne("annualLeaveMapper.selectAnnual", id);
	}

	public int insertAnnualCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		System.out.println("map:"+map);
		return sqlSession.insert("annualLeaveMapper.insertAnnual", map);
	}

	public int updateAnnualCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.update("annualLeaveMapper.updateAnnual", map);
	}

	

	

	

	

	




}
