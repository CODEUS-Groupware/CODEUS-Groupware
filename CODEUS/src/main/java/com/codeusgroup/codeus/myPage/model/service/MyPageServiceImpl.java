package com.codeusgroup.codeus.myPage.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.member.model.vo.Member;
import com.codeusgroup.codeus.myPage.model.dao.MyPageDAO;
import com.codeusgroup.codeus.myPage.model.vo.Scrap;

@Service("mpService")
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	private MyPageDAO mpDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int updateMember(Member member) {
		return mpDAO.updateMember(sqlSession, member);
	}

	@Override
	public int updatePwd(Member m) {
		return mpDAO.updatePwd(sqlSession, m);
	}
	
	@Override
	public List<Scrap> selectScrapList(String mId) {
		return mpDAO.selectScrapList(sqlSession, mId);
	}

	@Override
	public int deleteScrap(ArrayList<Scrap> deleteList) {
		return mpDAO.deleteScrap(sqlSession, deleteList);
	}

}
