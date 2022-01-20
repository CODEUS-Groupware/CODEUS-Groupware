package com.codeusgroup.codeus.address.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.address.model.dao.AddressDAO;
import com.codeusgroup.codeus.address.model.vo.Address;
import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("addrService")
public class AddressServiceImpl implements AddressService {
	
	@Autowired
	private AddressDAO addrDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getListCount() {
		return addrDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectMemebrList(PageInfo pi) {
		return addrDAO.selectMemberList(sqlSession, pi);
	}

	@Override
	public ArrayList<Member> searchMemebrList(PageInfo pi, String input, String field) {
		return addrDAO.searchMemebrList(sqlSession, pi, input, field);
	}

	@Override
	public int addAddress(String userId, String mId) {
		return addrDAO.addAddress(sqlSession, userId, mId);
	}

	@Override
	public ArrayList<Member> selectMyList(PageInfo pi) {
		return addrDAO.selectMyList(sqlSession, pi);
	}

}
