package com.codeusgroup.codeus.address.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

public interface AddressService {

	int getListCount();
	
	int getMyListCount(String userId);

	ArrayList<Member> selectMemebrList(PageInfo pi, String userId);

	ArrayList<Member> searchMemebrList(PageInfo pi, String input, String field);

	int addAddress(String userId, String mId);

	ArrayList<Member> selectMyList(PageInfo pi, String userId);

	int minusAddress(String userId, String mId);

}
