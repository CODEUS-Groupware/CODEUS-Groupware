package com.codeusgroup.codeus.commBoard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;
import com.codeusgroup.codeus.commBoard.model.vo.Search;


@Repository("bDAO")
public class CommbDAO {


	// 자유게시판
	
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getListCount");
	}

	public ArrayList<CommBoard> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.CommBoardSelectList", null, rowBounds);
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("boardMapper.addReadCount", bId);
	}

	public CommBoard selectCommBoard(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("boardMapper.selectBoard", bId);
		
		}
	public int commUpdateBoard(SqlSessionTemplate sqlSession, CommBoard b) {
		return sqlSession.update("boardMapper.commUpdateBoard", b);
	}
	
	public int commBoardDelete(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("boardMapper.CommBoardDelete", bId);
	}
	
	
	public int insertBoard(SqlSessionTemplate sqlSession, CommBoard b) {
		return sqlSession.insert("boardMapper.insertcommBoard", b);
	}
	
	public ArrayList<CommBoard> selectListSearch(SqlSessionTemplate sqlSession, Search search) {
		return (ArrayList)sqlSession.selectList("boardMapper.searchList",search);
	}


	
	//댓글

	
	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int bId) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectReplyList", bId);
		}

	public int addCommReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("boardMapper.addReply", r);
	}


	public int deleteReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("boardMapper.deleteReply",r);
	
	}


	public int modifyReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("boardMapper.updateReply",r);
	}

	
	//게시글 신고
	
	
		public int insertReportPost(SqlSessionTemplate sqlSession, Report rep) {
			return sqlSession.insert("boardMapper.insertPostReport",rep);
		}

		public Report selectPostReport(SqlSessionTemplate sqlSession, int bId) {
			return sqlSession.selectOne("boardMapper.selectPostReport",bId);
		}
		
		
	
	//댓글 신고

	public int insertReportReply(SqlSessionTemplate sqlSession, Report rep) {
		return sqlSession.insert("boardMapper.insertReplyReport",rep);
	}
	
	public Report selectReplyReport(SqlSessionTemplate sqlSession, int rId) {
		return sqlSession.selectOne("boardMapper.selectReplyReport",rId);
	}
	
	
	//자유게시판 검색 
	public int commsearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("boardMapper.commsearchListCount", search);
	}

	
		

	public ArrayList<CommBoard> commSearchList(SqlSessionTemplate sqlSession, Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.commSearchList", search, rowBounds);
	}


	public int updateReplyCount(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("boardMapper.updateReplyCount", bId);
	}
	
	}





