package com.codeusgroup.codeus.chetting.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.chetting.model.vo.Chetting;

@Repository("chetDAO")
public class ChetDAO {

	public ArrayList<Chetting> selectChatroom(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("chettingMapper.selectChatroom", userId);
	}
	
}
