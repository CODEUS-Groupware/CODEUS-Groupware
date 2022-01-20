package com.codeusgroup.codeus.document.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.codeusgroup.codeus.document.model.vo.Document;

@Repository("dDao")
public class DocumentDAO {
	
	public int getTotalWaitingCount(SqlSessionTemplate sqlSession, Map<String, String> paraMap) {
		return sqlSession.selectOne("documentMapper.getTotalWaitingCount", paraMap);
	}

	public List<Document> waitingApprList(SqlSessionTemplate sqlSession, Map<String, String> paraMap) {
		return sqlSession.selectList("documentMapper.waitingApprList", paraMap);
	}

	public List<Document> processingApprList(SqlSessionTemplate sqlSession, Map<String, String> paraMap) {
		return sqlSession.selectList("documentMapper.processingApprList", paraMap);
	}

	public List<Document> finishedApprList(SqlSessionTemplate sqlSession, Map<String, String> paraMap) {
		return sqlSession.selectList("documentMapper.finishedApprList", paraMap);
	}

	public int insertNewApproval(SqlSessionTemplate sqlSession, Document d) {
		System.out.println(d + "dao");
		System.out.println(sqlSession);
		
		return sqlSession.insert("documentMapper.insertNewApproval", d);
	}

}
