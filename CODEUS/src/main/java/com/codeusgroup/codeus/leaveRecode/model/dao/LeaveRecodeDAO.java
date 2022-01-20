package com.codeusgroup.codeus.leaveRecode.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.annualLeave.model.vo.PageInfo;
import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("lrDAO")
public class LeaveRecodeDAO {

	

	public int selectLrCount(SqlSessionTemplate sqlSession, String id) {
		System.out.println("연차현황");
		System.out.println("연차아이디:"+id);
		return sqlSession.selectOne("leaveRecodeMapper.selectLrCount", id);
	}

	public LeaveRecode selectUsedCount(SqlSessionTemplate sqlSession, String id) {
		
		return sqlSession.selectOne("leaveRecodeMapper.selectUsedCount", id);
	}
	public ArrayList<LeaveRecode> selectAnnualList(SqlSessionTemplate sqlSession, String id) {
		
		return (ArrayList)sqlSession.selectList("leaveRecodeMapper.selectAnnualList", id);
	}

	public int getAnnualList(SqlSessionTemplate sqlSession, String id) {
		
		return sqlSession.selectOne("leaveRecodeMapper.getAnnualListCount", id);
	}
	
	public ArrayList<LeaveRecode> selectAnnualList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		ArrayList<LeaveRecode> lrList = (ArrayList)sqlSession.selectList("leaveRecodeMapper.getSelectAnnualList", map, rowBounds);
		return lrList;
	}
	
	public int getAnnualSearchResultListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("leaveRecodeMapper.getAnnualSearchResultListCount", map);
	}
	
	public ArrayList<LeaveRecode> selectSearchAnnualResultList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int offset = (pi.getCurrentPage() - 1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		ArrayList<LeaveRecode> lrList = (ArrayList)sqlSession.selectList("leaveRecodeMapper.selectSearchAnnualResultList", map, rowBounds);
		return lrList;
	}

}
