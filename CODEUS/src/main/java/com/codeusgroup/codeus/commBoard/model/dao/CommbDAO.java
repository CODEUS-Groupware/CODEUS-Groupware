package com.codeusgroup.codeus.commBoard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;

@Repository("bDAO")
public class CommbDAO {


	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.getListCount");
	}

	public ArrayList<CommBoard> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.CommBoardSelectList", null, rowBounds);
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("boardMapper.addReadCount", bId);
	}

	public CommBoard selectCommBoard(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("boardMapper.selectBoard", bId);
		
		}

	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int bId) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectReplyList", bId);
		}

	public int addReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("boardMapper.addReply", r);
	}

	public ArrayList<CommBoard> selectNoticeList(SqlSessionTemplate sqlSession, String search_option, String keyword,
			PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.serch",search_option,rowBounds);
	}
	}

