package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeusgroup.codeus.commBoard.model.dao.CommbDAO;
import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;
import com.codeusgroup.codeus.commBoard.model.vo.Search;


@Service("bService")
public class CommBoardServiceImpl implements CommBoardService {

		@Autowired
		private CommbDAO bDAO;
		
		@Autowired
		private SqlSessionTemplate sqlSession;

		@Override
		public int getCommBoardListCount() {
			return bDAO.getListCount(sqlSession);
		}
		@Override
		public ArrayList<CommBoard> CommBoardselectList(PageInfo pi) {
			return bDAO.selectNoticeList(sqlSession, pi);
		}
		@Override
		@Transactional // 트랜잭션 제어 어노테이션
		public CommBoard selectCommBoard(int bId) {
			
			int result = bDAO.addReadCount(sqlSession, bId);
			
			CommBoard b = null;
			if(result > 0) {
				b = bDAO.selectCommBoard(sqlSession, bId);
			}
			
			return b;
		}
		
		@Override
		public int commInsertBoard(CommBoard b) {
			return bDAO.insertBoard(sqlSession, b);
			
		}
		@Override
		public int commUpdateBoard(CommBoard b) {
			return bDAO.commUpdateBoard(sqlSession, b);
		}
		
		
		@Override
		public int CommBoardDelete(int bId) {
			return bDAO.commBoardDelete(sqlSession, bId);
		}
		
		@Override
		public Report ckReportPost(int bId) {
			return bDAO.selectPostReport(sqlSession,bId);
		}
		
	
		// 댓글 
		
		@Override
		public ArrayList<Reply> selectReplyList(int bId) {
			return bDAO.selectReplyList(sqlSession, bId);
		}
	
		@Override
		public int addCommReply(Reply r) {
			return bDAO.addCommReply(sqlSession, r);
		}
		@Override
		public int modifyReply(Reply r) {
			return bDAO.modifyReply(sqlSession,r);

		}

		@Override
		public int deleteReply(Reply r) {
			return bDAO.deleteReply(sqlSession,r);

	
		}
		@Override
		public Report ckReportReply(int rId) {
			return bDAO.selectReplyReport(sqlSession,rId);
		}
		@Override
		public int reportReply(Report rep) {
			return bDAO.insertReportReply(sqlSession,rep);
		}
		@Override
		public int reportPost(Report rep) {
			return bDAO.insertReportPost(sqlSession,rep);
		}
		
		
		//자유게시판 검색 
		@Override
		public int commsearchListCount(Search search) {
			return bDAO.commsearchListCount(sqlSession,search);
		}
		@Override
		public ArrayList<CommBoard> commSearchList(Search search, PageInfo pi) {
			return bDAO.commSearchList(sqlSession,search, pi);
		}
		

//		@Override
//		public void updateReplyCount(int bId) {
//			// TODO Auto-generated method stub
//			
//		}
//		@Override
//		public List<Reply> readReply(int getbId) {
//			// TODO Auto-generated method stub
//			return null;
//		}

	}

