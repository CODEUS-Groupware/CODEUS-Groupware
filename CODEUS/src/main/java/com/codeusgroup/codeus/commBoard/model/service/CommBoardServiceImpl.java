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
		public ArrayList<Reply> selectReplyList(int bId) {
			return bDAO.selectReplyList(sqlSession, bId);
		}
	
		@Override
		public int addReply(Reply r) {
			return bDAO.addReply(sqlSession, r);
		}
		@Override
		public int CommBoardDelete(int bId) {
			return sqlSession.update("boardMapper.CommBoardDelete", bId);
		}
		@Override
		public int commInsertBoard(CommBoard b) {
			return sqlSession.update("boardMapper.commInsertBoard", b);
			
		}
	
	}

