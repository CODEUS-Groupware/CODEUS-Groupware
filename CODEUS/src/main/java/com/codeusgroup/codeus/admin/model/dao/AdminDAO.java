package com.codeusgroup.codeus.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.admin.model.vo.Department;
import com.codeusgroup.codeus.admin.model.vo.Job;
import com.codeusgroup.codeus.admin.model.vo.PageInfo;
import com.codeusgroup.codeus.member.model.vo.Member;

@Repository("aDAO")
public class AdminDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		int listCount = sqlSession.selectOne("adminMapper.getListCount");
		
		return listCount;
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		ArrayList<Member> mList = null;
		if (pi != null) {
			int offset  = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
			RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			mList = (ArrayList)sqlSession.selectList("adminMapper.selectMemberList", null, rowBounds);
		} else {
			mList = (ArrayList)sqlSession.selectList("adminMapper.selectMemberList2");
		}
		
		return mList;
	}

	public ArrayList<Department> selectDepartmentList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectDepartmentList");
	}

	public ArrayList<Job> selectJobList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectJobList");
	}

	public int getSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("adminMapper.getSearchListCount", map);
	}

	public ArrayList<Member> selectSearchMemberList(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		int offset  = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectSearchMemberList", map, rowBounds);
	}

	public ArrayList<Integer> getMemberCount(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.getMemberCount");
	}

	public int updateMultiMember(SqlSessionTemplate sqlSession, String[] mIdArr, int mStatus) {
		int result = 0;
		for(String mId : mIdArr) {
//			HashMap<String, String> map = new HashMap<String, String>();
//			map.put("mId", mId);
//			map.put("mStatus", String.valueOf(mStatus));
			Member m = new Member();
			m.setmId(mId);
			m.setStatus(mStatus);
			result += sqlSession.update("adminMapper.updateMultiMember", m);
		}
		
		return result;
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("adminMapper.updateMember", m);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, String[] mIdArr) {
		int result = 0;
		for (String mId : mIdArr) {
			result += sqlSession.update("adminMapper.deleteMember", mId);
		}
		return result;
	}

	public Member selectMember(SqlSessionTemplate sqlSession, String mId) {
		return sqlSession.selectOne("adminMapper.selectMember", mId);
	}

	public int deleteJob(SqlSessionTemplate sqlSession, String[] jobIdArr) {
		int result = 0;
		for (String jobId : jobIdArr) {
			result += sqlSession.update("adminMapper.deleteJob", jobId);
		}
		
		return result;
	}

	public int insertJob(SqlSessionTemplate sqlSession, Job job) {
		return sqlSession.insert("adminMapper.insertJob", job);
	}

	public int updateJob(SqlSessionTemplate sqlSession, Job job) {
		return sqlSession.update("adminMapper.updateJob", job);
	}

	public ArrayList<Member> selectDeptMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectDeptMemberList");
	}

	public ArrayList<Department> getSubDeptList(SqlSessionTemplate sqlSession, int upperDept) {
		return (ArrayList)sqlSession.selectList("adminMapper.getSubDeptList", upperDept);
	}

}
