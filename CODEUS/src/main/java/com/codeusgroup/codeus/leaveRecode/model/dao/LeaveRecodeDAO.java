package com.codeusgroup.codeus.leaveRecode.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.leaveRecode.model.vo.LeaveRecode;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("lrDAO")
public class LeaveRecodeDAO {

	

	public int selectLrCount(SqlSessionTemplate sqlSession, String id) {
		System.out.println("연차현황");
		System.out.println("연차아이디:"+id);
		return sqlSession.selectOne("leaveRecodeMapper.selectLrCount", id);
	}

}
