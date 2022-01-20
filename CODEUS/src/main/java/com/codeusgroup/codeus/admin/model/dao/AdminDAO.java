package com.codeusgroup.codeus.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.admin.model.vo.Department;
import com.codeusgroup.codeus.admin.model.vo.Job;
import com.codeusgroup.codeus.admin.model.vo.PageInfo;
import com.codeusgroup.codeus.admin.model.vo.Report;
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

	public ArrayList<Member> selectDeptMemberList(SqlSessionTemplate sqlSession, Integer upperDept) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("upperDept", upperDept); // mapper에서 if로 upperDept속성 사용하기 위해 map의 속성으로 추가
		return (ArrayList)sqlSession.selectList("adminMapper.selectDeptMemberList", map);
	}

	public ArrayList<Department> getSubDeptList(SqlSessionTemplate sqlSession, int upperDept) {
		return (ArrayList)sqlSession.selectList("adminMapper.getSubDeptList", upperDept);
	}

	public int insertDept(SqlSessionTemplate sqlSession, Department dept) {
		return sqlSession.insert("adminMapper.insertDept", dept);
	}
	
	public Department selectDept(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMapper.selectDept");
	}

	public int deleteDept(SqlSessionTemplate sqlSession, int deptId) {
		return sqlSession.update("adminMapper.deleteDept", deptId);
	}

	public int updateDept(SqlSessionTemplate sqlSession, Department dept) {
		return sqlSession.update("adminMapper.updateDept", dept);
	}

	public int moveDept(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.update("adminMapper.moveDept", map);
	}

	public int getReportListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMapper.getReportListCount");
	}

	public ArrayList<Report> selectBoardReportList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset  = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectBoardReportList", null, rowBounds);
	}

	public ArrayList<Report> selectReplyReportList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset  = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectReplyReportList", null, rowBounds);
	}

	public int handingBoardReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.update("adminMapper.handingBoardReport", report);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("adminMapper.deleteBoard", bNum);
	}

	public int handingReplyReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.update("adminMapper.handingReplyReport", report);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("adminMapper.deleteReply", replyNo);
	}

}
