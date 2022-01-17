package com.codeusgroup.codeus.empStatus.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Insert;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("EmpStatusDAO")
public class EmpStatusDAO {

	public int insertComTime(SqlSessionTemplate sqlSession, EmpStatus empStatus) {
		System.out.println("dao");
		int result = sqlSession.insert("empStatusMapper.insertComTime", empStatus);
		System.out.println(result);
		return result;
		
	}

	public EmpStatus selectComTime(SqlSessionTemplate sqlSession, String id) {
		//매개변수 2개짜리로 하기
		return sqlSession.selectOne("empStatusMapper.selectComTime", id);
	}

	public int updateOffTime(SqlSessionTemplate sqlSession, EmpStatus empStatus) {
		
		return sqlSession.update("empStatusMapper.updateOffTime", empStatus);
	}

	public EmpStatus selectOffTime(SqlSessionTemplate sqlSession, String id) {		
		EmpStatus empOffTime = sqlSession.selectOne("empStatusMapper.selectOffTime", id);
		System.out.println("셀렉트 empOffTime:" + empOffTime);
		return empOffTime;
	}

	public int updateStatus(SqlSessionTemplate sqlSession, EmpStatus empStatus) {
		int result = sqlSession.update("empStatusMapper.updateStatus", empStatus);
		System.out.println(result);
		return result;
	}

	public int updateGapTime(SqlSessionTemplate sqlSession, EmpStatus emp) {
		
		return sqlSession.update("empStatusMapper.updateGapTime", emp);
	}

	public EmpStatus selectWeekTime(SqlSessionTemplate sqlSession, String id) {
		
		return sqlSession.selectOne("empStatusMapper.selectWeekTime", id);
	}

	public EmpStatus selectMonthTime(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("empStatusMapper.selectMonthTime", id);
	}

	public ArrayList<EmpStatus> monthWorkTime(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return (ArrayList)sqlSession.selectList("empStatusMapper.monthWorkTime", map);
	}

	public ArrayList<EmpStatus> selectDeptEmpStatus(SqlSessionTemplate sqlSession, String id) {
		
		return (ArrayList)sqlSession.selectList("empStatusMapper.selectDeptEmpStatus", id);
	}

	public ArrayList<EmpStatus> selectDetptWorkTime(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return (ArrayList)sqlSession.selectList("empStatusMapper.selectDeptWorkTime", map);
	}

	public ArrayList<EmpStatus> commuteList(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return (ArrayList)sqlSession.selectList("empStatusMapper.selectCommute", map);
	}




	public ArrayList<EmpStatus> overworkList(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("empStatusMapper.selectOverwork", map);
	}

	public EmpStatus monthTotalTime(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("empStatusMapper.monthTotalTime", map);
	}

	public ArrayList<EmpStatus> selectDeptWeekList(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
	
		System.out.println("현재월:"+map.get("currentMonth1"));
		System.out.println("현재년:"+map.get("currentYear"));
		return (ArrayList)sqlSession.selectList("empStatusMapper.selectDeptWeekList", map);
	}

	

	

	

}
