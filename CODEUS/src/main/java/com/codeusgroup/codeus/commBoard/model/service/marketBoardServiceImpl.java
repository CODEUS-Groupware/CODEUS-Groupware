package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeusgroup.codeus.commBoard.model.dao.marketDAO;
import com.codeusgroup.codeus.commBoard.model.exception.BoardException;
import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.MarketAtt;
import com.codeusgroup.codeus.commBoard.model.vo.MarketBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Search;

@Service("mbService")
public class marketBoardServiceImpl implements marketBoardService {

		@Autowired
		private marketDAO mbDAO;
		
		@Autowired
		private SqlSessionTemplate sqlSession;

		@Override
		public int getmarketBoardListCount() {
			return mbDAO.getListCount(sqlSession);
		}
		@Override
		public ArrayList<MarketBoard> marketBoardselectList(PageInfo pi) {
			return mbDAO.selectNoticeList(sqlSession, pi);
		}
		
		
		@Override
		public List<Map<String, String>> selectAttachmentList(int bId) {
			return mbDAO. selectAttachmentList(sqlSession, bId);
		}
		@Override
		@Transactional
		public MarketBoard selectMarketOneBoard(int bId) {
			
			int result = mbDAO.addReadViews(sqlSession, bId);
			
			MarketBoard mb = null;
			if(result > 0) {
				mb = mbDAO. selectMarketOneBoard(sqlSession, bId);
			}
			
			return mb;
		}
		@Override
		public int deleteBoard(int bId) {
			return mbDAO.deleteBoard(sqlSession, bId);
		}
		
		@Override
		public int updateMarkBoard(MarketBoard mb) {
			return mbDAO.updateMarkBoard(sqlSession, mb);
		}
		@Override
		public int insertMarketBoard(MarketBoard mb) {
			return mbDAO.insertMarketBoard(sqlSession, mb);
		}
		@Override
		public int marketSearchListCount(Search search) {
			return mbDAO.marketSearchListCount(sqlSession,search);
		}
		@Override
		public ArrayList<MarketBoard> MarketSearchList(Search search, PageInfo pi) {
			return mbDAO.MarketSearchListt(sqlSession,search, pi);
		}
		@Override
		public int saveimage(MarketAtt at) {
			return mbDAO.saveimage(sqlSession,at);
		}
		
}
