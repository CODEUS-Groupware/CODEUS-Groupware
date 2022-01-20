package com.codeusgroup.codeus.commBoard.model.service;

import java.util.ArrayList;
import java.util.List;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;
import com.codeusgroup.codeus.commBoard.model.vo.Search;


public interface CommBoardService {

	int getCommBoardListCount();

	ArrayList<CommBoard> CommBoardselectList(PageInfo pi);
	
	int commsearchListCount(Search search);

	ArrayList<CommBoard> commSearchList(Search search, PageInfo pi);
	
	
	
	CommBoard selectCommBoard(int bId);
	
	int commInsertBoard(CommBoard b);	
	
	int commUpdateBoard(CommBoard b);
	
	int CommBoardDelete(int bId);
	
	//신고
	
	int reportPost(Report rep);
	
	Report ckReportPost(int bId);
	
	//댓글

	ArrayList<Reply> selectReplyList(int bId);

	int addCommReply(Reply r);

	int modifyReply(Reply r);

	int deleteReply(Reply r);

	Report ckReportReply(int rId);

	int reportReply(Report rep);


//	List<Reply> readReply(int getbId);
//
//	Object read(int getbId);
//
//	void ReplyviewCount(int bId);
//
//	void updateReplyCount(int bId);

	

	



	
	

	

	

	

	



	
	
}


