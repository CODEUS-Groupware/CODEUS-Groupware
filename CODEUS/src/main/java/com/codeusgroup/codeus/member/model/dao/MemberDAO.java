package com.codeusgroup.codeus.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("mDAO")
public class MemberDAO {

	public Member memberLogin(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.memberLogin", m);
	}

//	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
//		return sqlSession.insert("memberMapper.insertMember", m);
//	}
	
	public Member searchMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.searchMember", m);
	}

	public int duplicateId(SqlSessionTemplate sqlSession, String inputId) {
		return sqlSession.selectOne("memberMapper.duplicateId", inputId);
	}

	public int joinMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}



}
