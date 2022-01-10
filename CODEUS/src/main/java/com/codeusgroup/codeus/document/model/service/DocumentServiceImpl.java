package com.codeusgroup.codeus.document.model.service;

import java.util.*;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.document.model.dao.DocumentDAO;
import com.codeusgroup.codeus.document.model.vo.Document;

@Service("dDao")
public class DocumentServiceImpl implements DocumentService {
	
	@Autowired
	private DocumentDAO dDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getTotalWaitingCount(Map<String, String> paraMap) {
		return dDao.getTotalWaitingCount(sqlSession, paraMap);
	}

	@Override
	public List<Document> waitingApprList(Map<String, String> paraMap) {
		return dDao.waitingApprList(sqlSession, paraMap);
	}

	@Override
	public List<Document> processingApprList(Map<String, String> paraMap) {
		return dDao.processingApprList(sqlSession, paraMap);
	}

	@Override
	public List<Document> finishedApprList(Map<String, String> paraMap) {
		return dDao.finishedApprList(sqlSession, paraMap);
	}

	@Override
	public int insertNewApproval(Document d) {
		return dDao.insertNewApproval(sqlSession, d);
	}

}
