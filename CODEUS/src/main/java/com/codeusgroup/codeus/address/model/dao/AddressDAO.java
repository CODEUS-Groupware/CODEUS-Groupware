package com.codeusgroup.codeus.address.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
}
