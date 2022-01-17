package com.codeusgroup.codeus.chetting.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.address.model.dao.AddressDAO;
import com.codeusgroup.codeus.chetting.model.dao.ChetDAO;
import com.codeusgroup.codeus.chetting.model.vo.Chetting;

@Service("chetService")
public class ChetServiceImpl implements ChetService {
	
	@Autowired
	private ChetDAO chDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Chetting> selectChatroom(String userId) {
		return chDAO.selectChatroom(sqlSession, userId);
	}
}
