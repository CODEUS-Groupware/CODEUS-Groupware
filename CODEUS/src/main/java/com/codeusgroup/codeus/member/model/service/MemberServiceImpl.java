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
	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public Member idSearchMember(Member m) {
		return mDAO.idSearchMember(sqlSession, m);
	}

	@Override
	public Member pwdSearchMember(Member m) {
		return mDAO.pwdSearchMember(sqlSession, m);
	}

	@Override
	public void updatePwdMember(Member m) {
		mDAO.updatePwdMember(sqlSession, m);
		
	}

}
