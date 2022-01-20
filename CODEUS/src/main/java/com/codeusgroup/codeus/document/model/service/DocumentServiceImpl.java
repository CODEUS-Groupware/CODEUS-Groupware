package com.codeusgroup.codeus.document.model.service;

import java.util.*;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.document.model.dao.DocumentDAO;
import com.codeusgroup.codeus.document.model.vo.Document;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("dService")
public class DocumentServiceImpl implements DocumentService {
	
	@Autowired
	private DocumentDAO dDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getTotalWaitingCount(Map<String, String> paraMap) {
		return dDAO.getTotalWaitingCount(sqlSession, paraMap);
	}

	@Override
	public List<Document> waitingApprList(Map<String, String> paraMap) {
		return dDAO.waitingApprList(sqlSession, paraMap);
	}

	@Override
	public List<Document> processingApprList(Map<String, String> paraMap) {
		return dDAO.processingApprList(sqlSession, paraMap);
	}

	@Override
	public List<Document> finishedApprList(Map<String, String> paraMap) {
		return dDAO.finishedApprList(sqlSession, paraMap);
	}

	@Override
	public int insertNewApproval(Document d) {
		System.out.println(d);
		System.out.println("service");

		return dDAO.insertNewApproval(sqlSession, d);
	}


}
