package com.codeusgroup.codeus.noticeBoard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoard;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoardFile;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoardReply;
import com.codeusgroup.codeus.noticeBoard.model.vo.PageInfo;

@Repository("nbDAO")
public class NoticeBoardDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeBoardMapper.getListCount");
	}
	
	public List<NoticeBoard> selectNoticeBoardList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset  = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("noticeBoardMapper.selectNoticeBoardList", null, rowBounds);
	}
	
	public int insertNoticeBoard(SqlSessionTemplate sqlSession, NoticeBoard noticeBoard) {
		return sqlSession.insert("noticeBoardMapper.insertNoticeBoard", noticeBoard);
	}
	
	public int insertBoardFile(SqlSessionTemplate sqlSession, ArrayList<NoticeBoardFile> fList) {
		int result = 0;
		for (NoticeBoardFile f : fList) {
			result += sqlSession.insert("noticeBoardMapper.insertBoardFile", f);
		}
		
		return result;
	}

	public int getSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("noticeBoardMapper.getSearchListCount", map);
	}

	public List<NoticeBoard> selectSearchList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int offset  = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("noticeBoardMapper.selectSearchList", map, rowBounds);
	}
	
	public int updateViews(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("noticeBoardMapper.updateViews", bNum);
	}

	public NoticeBoard selectNoticeBoard(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.selectOne("noticeBoardMapper.selectNoticeBoard", bNum);
	}

	public List<NoticeBoardReply> selectReplyList(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.selectList("noticeBoardMapper.selectReplyList", bNum);
	}

	public List<NoticeBoardFile> selectFileList(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.selectList("noticeBoardMapper.selectFileList", bNum);
	}

	public int getScrapStatus(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("noticeBoardMapper.getScrapStatus", map);
	}
	
	public int insertScrap(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.insert("noticeBoardMapper.insertScrap", map);
	}

	public int deleteScrap(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.delete("noticeBoardMapper.deleteScrap", map);
	}

	public int insertReply(SqlSessionTemplate sqlSession, NoticeBoardReply reply) {
		return sqlSession.insert("noticeBoardMapper.insertReply", reply);
	}

	public int updateReply(SqlSessionTemplate sqlSession, NoticeBoardReply reply) {
		return sqlSession.update("noticeBoardMapper.updateReply", reply);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("noticeBoardMapper.deleteReply", replyNo);
	}

	public int deleteNoticeBoard(SqlSessionTemplate sqlSession, int bNum) {
		return sqlSession.update("noticeBoardMapper.deleteNoticeBoard", bNum);
	}

	public int deleteFile(SqlSessionTemplate sqlSession, List<NoticeBoardFile> fileList) {
		int result = 0;
		
		for(NoticeBoardFile f : fileList) {
			result += sqlSession.update("noticeBoardMapper.deleteFile", f);
		}
		
		return result;
	}

	public int updateNoticeBoard(SqlSessionTemplate sqlSession, NoticeBoard noticeBoard) {
		return sqlSession.update("noticeBoardMapper.updateNoticeBoard", noticeBoard);
	}

	public List<NoticeBoard> selectNoticeBoardListMain(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("noticeBoardMapper.selectNoticeBoardListMain");
	}





}
