package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.MarketAtt;
import com.codeusgroup.codeus.commBoard.model.vo.MarketBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Search;


public interface marketBoardService {
	
	
	int getmarketBoardListCount();

	ArrayList<MarketBoard> marketBoardselectList(PageInfo pi);

	int insertMarketBoard(MarketBoard mb);
	
	MarketBoard selectMarketOneBoard(int bId);

	List<Map<String, String>> selectAttachmentList(int bId);

	int deleteBoard(int bId);

	int updateMarkBoard(MarketBoard mb);

	int marketSearchListCount(Search search);

	ArrayList<MarketBoard> MarketSearchList(Search search, PageInfo pi);

	int saveimage(MarketAtt at);



}
