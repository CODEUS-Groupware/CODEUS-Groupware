package com.codeusgroup.codeus.document.model.service;

import java.util.List;
import java.util.Map;

import com.codeusgroup.codeus.document.model.vo.Document;

public interface DocumentService {

	int getTotalWaitingCount(Map<String, String> paraMap);

	List<Document> waitingApprList(Map<String, String> paraMap);

	List<Document> processingApprList(Map<String, String> paraMap);

	List<Document> finishedApprList(Map<String, String> paraMap);

	int insertNewApproval(Document d);

}
