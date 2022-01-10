package com.codeusgroup.codeus.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeusgroup.codeus.admin.model.dao.AdminDAO;
import com.codeusgroup.codeus.admin.model.vo.Department;
import com.codeusgroup.codeus.admin.model.vo.Job;
import com.codeusgroup.codeus.admin.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("aService")
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO aDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getListCount() {
		return aDAO.getListCount(sqlSession); 
	}

	@Override
	public ArrayList<Member> selectMemberList(PageInfo pi) {
		
		ArrayList<Member> mList = null;
		if (pi != null) {
			mList = aDAO.selectMemberList(sqlSession, pi);
		} else {
			mList = aDAO.selectMemberList(sqlSession, null);
		}
		
		return mList;
	}

	@Override
	public ArrayList<Department> selectDepartmentList() {
		return aDAO.selectDepartmentList(sqlSession);
	}

	@Override
	public ArrayList<Job> selectJobList() {
		return aDAO.selectJobList(sqlSession);
	}

	@Override
	public int getSearchListCount(HashMap<String, String> map) {
		return aDAO.getSearchListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Member> selectSearchMemberList(PageInfo pi, HashMap<String, String> map) {
		return aDAO.selectSearchMemberList(sqlSession, pi, map);
	}

	@Override
	public ArrayList<Integer> getMemberCount() {
		return aDAO.getMemberCount(sqlSession);
	}

	@Override
	public int updateMultiMember(String[] mIdArr, int mStatus) {
		return aDAO.updateMultiMember(sqlSession, mIdArr, mStatus);
	}

	@Override
	public int updateMember(Member m) {
		return aDAO.updateMember(sqlSession, m);
	}

	@Override
	public int deleteMember(String[] mIdArr) {
		return aDAO.deleteMember(sqlSession, mIdArr);
	}

	@Override
	public Member selectMember(String mId) {
		return aDAO.selectMember(sqlSession, mId);
	}

	@Override
	public int deleteJob(String[] jobIdArr) {
		return aDAO.deleteJob(sqlSession, jobIdArr);
	}

	@Override
	public int insertJob(Job job) {
		return aDAO.insertJob(sqlSession, job);
	}

	@Override
	public int updateJob(Job job) {
		return aDAO.updateJob(sqlSession, job);
	}

	@Override
	public ArrayList<Member> selectDeptMemberList(Integer upperDept) {
		System.out.println(upperDept);
		return aDAO.selectDeptMemberList(sqlSession, upperDept);
		
	}

	@Override
	public ArrayList<Department> getSubDeptList(int upperDept) {
		return aDAO.getSubDeptList(sqlSession, upperDept);
	}

	@Override
	@Transactional // 트랜잭션 관리
	public Department insertDept(Department dept) {
		int result = aDAO.insertDept(sqlSession, dept);
		// 부서 등록 후 등록한 부서 정보 가져오기
		Department d = null;
		if (result > 0) {
			d = aDAO.selectDept(sqlSession);
		}
		
		return d;
				
	}

}
