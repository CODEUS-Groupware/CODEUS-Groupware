package com.codeusgroup.codeus.leaveRecode.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;


@Repository("lrDAO")
public class LeaveRecodeDAO {

	public ArrayList<LeaveRecode> selectLeaveRecode(SqlSessionTemplate sqlSession, String id) {
		ArrayList<LeaveRecode> list = (ArrayList)sqlSession.selectList("LeaveRecodeMapper.selectLeaveRecode", id);
		System.out.println("리스트:"+list);
		return list;
	}

}
