package com.codeusgroup.codeus.marketBoard.model.service;

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

@Service("mbService")
public class marketBoardServiceImpl implements marketBoardService {

		@Autowired
		private CommbDAO bDAO;
		
		@Autowired
		private SqlSessionTemplate sqlSession;

		@Override
		public int getmarketBoardListCount() {
			return bDAO.getListCount(sqlSession);
		}
		@Override
		public ArrayList<CommBoard> marketBoardselectList(PageInfo pi) {
			return bDAO.selectNoticeList(sqlSession, pi);
		}
		@Override
		public int getMarketBoardListCount() {
			// TODO Auto-generated method stub
			return 0;
		}
		

		@Override
		public CommBoard selectMarketBoard(int bId) {

			int result = bDAO.addReadCount(sqlSession, bId);
			
			CommBoard b = null;
			if(result > 0) {
				b = bDAO.selectCommBoard(sqlSession, bId);
			}
			
			return b;
		}
		@Override
		public int marketInsertBoard(CommBoard b) {
			return bDAO.marketInsertBoard(sqlSession, b);
		}
		
	}
	
