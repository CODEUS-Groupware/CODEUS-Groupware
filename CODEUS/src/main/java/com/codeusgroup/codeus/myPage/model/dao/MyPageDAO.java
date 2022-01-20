package com.codeusgroup.codeus.myPage.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.member.model.vo.Member;
import com.codeusgroup.codeus.myPage.model.vo.Scrap;

@Repository("mpDAO")
public class MyPageDAO {

	public int updateMember(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("myPageMapper.updateMember", member);
	}
	
	public int updatePwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("myPageMapper.updatePwd", m);
	}

	public List<Scrap> selectScrapList(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectList("myPageMapper.selectScrapList", mId);
	}

	public int deleteScrap(SqlSessionTemplate sqlSession, ArrayList<Scrap> deleteList) {
		
		int result = 0;
		for (Scrap s : deleteList) {
			result += sqlSession.delete("myPageMapper.deleteScrap", s);
		}
		
		return result;
	}



}
