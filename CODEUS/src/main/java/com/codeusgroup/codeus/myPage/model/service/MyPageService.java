package com.codeusgroup.codeus.myPage.model.service;

import java.util.ArrayList;
import java.util.List;

import com.codeusgroup.codeus.member.model.vo.Member;
import com.codeusgroup.codeus.myPage.model.vo.Scrap;

public interface MyPageService {

	int updateMember(Member member);

	int updatePwd(Member m);
	
	List<Scrap> selectScrapList(String mId);

	int deleteScrap(ArrayList<Scrap> deleteList);


}
