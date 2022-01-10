package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;


public interface CommBoardService {

	int getCommBoardListCount();

	ArrayList<CommBoard> CommBoardselectList(PageInfo pi);

	CommBoard selectCommBoard(int bId);
	
	int commInsertBoard(CommBoard b);	
	
	int commUpdateBoard(CommBoard b);
	
	int CommBoardDelete(int bId);
	
	int reportPost(Report rep);
	
	
	//댓글

	ArrayList<Reply> selectReplyList(int bId);

	int addCommReply(Reply r);

	int modifyReply(Reply r);

	int deleteReply(Reply r);

	Report ckReportReply(int rId);

	int reportReply(Report rep);

	Report ckReportPost(int bId);



	
	

	

	

	

	



	
	
}


