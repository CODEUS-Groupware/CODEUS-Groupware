package com.codeusgroup.codeus.noticeBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoard;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoardFile;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoardReply;
import com.codeusgroup.codeus.noticeBoard.model.vo.PageInfo;

public interface NoticeBoardService {

	int getListCount();

	int insertNoticeBoard(NoticeBoard noticeBoard, ArrayList<NoticeBoardFile> fList);

	List<NoticeBoard> selectNoticeBoardList(PageInfo pi);

	int getSearchListCount(HashMap<String, String> map);

	List<NoticeBoard> selectSearchList(PageInfo pi, HashMap<String, String> map);

	NoticeBoard selectNoticeBoard(int bNum, String upd);

	List<NoticeBoardReply> selectReplyList(int bNum);

	List<NoticeBoardFile> selectFileList(int bNum);
	
	int getScrapStatus(HashMap<String, String> map);

	int insertScrap(HashMap<String, String> map);
	
	int deleteScrap(HashMap<String, String> map);

	int insertReply(NoticeBoardReply reply);

	int updateReply(NoticeBoardReply reply);

	int deleteReply(int replyNo);

	int deleteNoticeBoard(int bNum);

	int deleteFile(List<NoticeBoardFile> fileList);

	int updateNoticeBoard(NoticeBoard noticeBoard, ArrayList<NoticeBoardFile> fList);


}
