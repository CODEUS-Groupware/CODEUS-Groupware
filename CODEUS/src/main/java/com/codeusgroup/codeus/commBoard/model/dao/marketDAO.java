package com.codeusgroup.codeus.commBoard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.MarketAtt;
import com.codeusgroup.codeus.commBoard.model.vo.MarketBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;
import com.codeusgroup.codeus.commBoard.model.vo.Search;


@Repository("mbDAO")

public class marketDAO {


	public ArrayList<MarketBoard> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("marketMapper.marketBoardSelectList", null, rowBounds);
	}


	
	public int addReadViews(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("marketMapper.addReadViews", bId);
	}


	public int updateMarketBoard(SqlSessionTemplate sqlSession, MarketBoard mb) {
		return sqlSession.update("marketMapper.updateMarketBoard", mb);
	}


	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("marketMapper.getListCount");
	}


	public int insertMarketBoard(SqlSessionTemplate sqlSession,MarketBoard mb) {
		return sqlSession.insert("marketMapper.insertMarketBoard", mb);
	}


	public int insertAttachment(SqlSessionTemplate sqlSession,MarketAtt at) {
		return sqlSession.insert("marketMapper.insertAttachment", at);
	}


	public MarketBoard selectMarketOneBoard(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("marketMapper.selectMarketBoard", bId);
	
	}
	public MarketAtt selectAttachmentList(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("marketMapper.selectAttachmentList",bId);	
		
		}


	public int deleteBoard(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("marketMapper.deleteBoard", bId);
	}



	public int updateMarkBoard(SqlSessionTemplate sqlSession, MarketBoard mb) {
		return sqlSession.update("marketMapper.updateMarketBoard", mb);
	}



	public int marketSearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("marketMapper.marketSearchListCount", search);
	}



	public ArrayList<MarketBoard> MarketSearchListt(SqlSessionTemplate sqlSession, Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("marketMapper.marketSearchList", search, rowBounds);
	}



	public int saveimage(SqlSessionTemplate sqlSession, MarketAtt at) {
		return sqlSession.insert("marketMapper.saveimage", at);
	}



	public int deleteimage(SqlSessionTemplate sqlSession, MarketAtt at) {
		return sqlSession.delete("marketMapper.deleteimage", at);
	}



	public int getScrapStatus(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("marketMapper.getScrapStatus", map);
	}
	



	public int getListOptionCount(SqlSessionTemplate sqlSession, String option) {
		return sqlSession.selectOne("marketMapper.getListOptionCount", option);
	}



	public ArrayList<MarketBoard> selectOptionPList(SqlSessionTemplate sqlSession, String option, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("marketMapper.selectOptionPList", option, rowBounds);
	}



	public int updateimage(SqlSessionTemplate sqlSession, MarketAtt at) {
		return sqlSession.update("marketMapper.updateimage", at);
	}
}
