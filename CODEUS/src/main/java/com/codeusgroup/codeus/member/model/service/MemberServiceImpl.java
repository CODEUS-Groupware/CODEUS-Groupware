package com.codeusgroup.codeus.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.member.model.dao.MemberDAO;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member memberLogin(Member m) {
		return mDAO.memberLogin(sqlSession, m);
	}

	@Override
	public Member searchMember(Member m) {
		return mDAO.searchMember(sqlSession, m);
	}

	@Override
	public int duplicateId(String inputId) {
		return mDAO.duplicateId(sqlSession, inputId);
	}

	@Override
	public int joinMember(Member m) {
		return mDAO.joinMember(sqlSession, m);
	}

}
