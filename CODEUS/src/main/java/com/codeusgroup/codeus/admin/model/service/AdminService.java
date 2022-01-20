package com.codeusgroup.codeus.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.codeusgroup.codeus.admin.model.vo.Department;
import com.codeusgroup.codeus.admin.model.vo.Job;
import com.codeusgroup.codeus.admin.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

public interface AdminService {

	int getListCount();
	
	ArrayList<Member> selectMemberList(PageInfo pi);

	ArrayList<Department> selectDepartmentList();

	ArrayList<Job> selectJobList();

	int getSearchListCount(HashMap<String, String> map);

	ArrayList<Member> selectSearchMemberList(PageInfo pi, HashMap<String, String> map);

	ArrayList<Integer> getMemberCount();

	int updateMultiMember(String[] mIdArr, int mStatus);

	int updateMember(Member m);

	int deleteMember(String[] mIdArr);

	Member selectMember(String mId);

	int deleteJob(String[] jobIdArr);

	int insertJob(Job job);

	int updateJob(Job job);

	ArrayList<Member> selectDeptMemberList(Integer upperDept);

	ArrayList<Department> getSubDeptList(int upperDept);

	Department insertDept(Department dept);

	int deleteDept(int deptId);

	int updateDept(Department dept);

	int moveDept(HashMap<String, Integer> map);


}
