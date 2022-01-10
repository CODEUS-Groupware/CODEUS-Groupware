package com.codeusgroup.codeus.address.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.address.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

public interface AddressService {

	int getListCount();

	ArrayList<Member> selectMemebrList(PageInfo pi);

	ArrayList<Member> searchMemebrList(PageInfo pi, String input, String field);

}
