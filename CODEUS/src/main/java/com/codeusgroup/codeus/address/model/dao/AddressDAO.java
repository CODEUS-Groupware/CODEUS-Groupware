package com.codeusgroup.codeus.address.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.address.model.vo.Address;
import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("addrDAO")
public class AddressDAO {
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("addressMapper.getListCount");
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getAddressLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getAddressLimit());
		
		return (ArrayList)sqlSession.selectList("addressMapper.selectMemberList", null, rowBounds);
	}

	public ArrayList<Member> searchMemebrList(SqlSessionTemplate sqlSession, PageInfo pi, String input, String field) {
		int offset = (pi.getCurrentPage() - 1) * pi.getAddressLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getAddressLimit());
		
		HashMap<String, String> map = new HashMap<>();
		map.put("input", input);
		map.put("field", field);
		
		return (ArrayList)sqlSession.selectList("addressMapper.searchMemebrList", map, rowBounds);
	}

	public int addAddress(SqlSessionTemplate sqlSession, String userId, String mId) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("userId", userId);
		map.put("mId", mId);
		
		return sqlSession.insert("addressMapper.addAddress", map);
	}

	public ArrayList<Member> selectMyList(SqlSessionTemplate sqlSession, PageInfo pi, String userId) {
		int offset = (pi.getCurrentPage() - 1) * pi.getAddressLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getAddressLimit());
		
		return (ArrayList)sqlSession.selectList("addressMapper.selectMyList", userId, rowBounds);
	}
}
