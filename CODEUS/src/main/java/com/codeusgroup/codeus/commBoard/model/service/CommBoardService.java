package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;

public interface CommBoardService {

	int getCommBoardListCount();

	ArrayList<CommBoard> CommBoardselectList(PageInfo pi);

	CommBoard selectCommBoard(int bId);

	ArrayList<Reply> selectReplyList(int bId);

	int addReply(Reply r);

	int CommBoardDelete(int bId);

	int commInsertBoard(CommBoard b);
	
}


