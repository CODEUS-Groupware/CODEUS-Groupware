package com.codeusgroup.codeus.member.model.service;

import com.codeusgroup.codeus.member.model.vo.Member;

public interface MemberService {

	Member memberLogin(Member m);

	int insertMember(Member m);

	Member idSearchMember(Member m);

	Member pwdSearchMember(Member m);

	void updatePwdMember(Member m);

}
