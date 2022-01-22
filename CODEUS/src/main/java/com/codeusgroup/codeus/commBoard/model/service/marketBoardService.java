package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;
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

	

	int deleteBoard(int bId);

	int updateMarkBoard(MarketBoard mb);

	int marketSearchListCount(Search search);

	ArrayList<MarketBoard> MarketSearchList(Search search, PageInfo pi);

	int saveimage(MarketAtt at);

	int deleteimage(MarketAtt at);


	int getScrapStatus(HashMap<String, String> map);


	int getListOptionCount(String option);

	ArrayList<MarketBoard> selectOptionPList(String option, PageInfo pi);


	
	MarketAtt selectAttachmentList(int bId);

	int updateimage(MarketAtt at);

	


	

	
	


}
