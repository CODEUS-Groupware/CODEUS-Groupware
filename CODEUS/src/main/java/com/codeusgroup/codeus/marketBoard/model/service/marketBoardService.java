package com.codeusgroup.codeus.marketBoard.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;

public interface marketBoardService {
	
	
	int getmarketBoardListCount();

	ArrayList<CommBoard> marketBoardselectList(PageInfo pi);

	int getMarketBoardListCount();

	CommBoard selectMarketBoard(int bId);

	int marketInsertBoard(CommBoard b);
	
	
}
