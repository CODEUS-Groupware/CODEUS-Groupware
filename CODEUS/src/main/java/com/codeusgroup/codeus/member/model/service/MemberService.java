package com.codeusgroup.codeus.member.model.service;

import com.codeusgroup.codeus.member.model.vo.Member;

public interface MemberService {

	Member memberLogin(Member m);

	Member searchMember(Member m);
	
	int duplicateId(String inputId);

	int joinMember(Member m);

}
