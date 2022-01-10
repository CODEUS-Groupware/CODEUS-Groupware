package com.codeusgroup.codeus.document.controller;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.document.common.FileManager;
import com.codeusgroup.codeus.document.model.service.DocumentService;
import com.codeusgroup.codeus.document.model.vo.Document;
import com.codeusgroup.codeus.member.model.vo.Member;

@Controller
public class DocumentController {
	
	@Autowired
	private DocumentService dService;
	
	@Autowired
	private FileManager fileManager;
	
	// 전체 문서함 (전자결재)
	@RequestMapping("mydocView.dc")
	public String mydoc() {
		return "documentMain";
	}
	
	// 전체 문서함 조회 (전자결재)
	@RequestMapping(value = "mydoc.dc")
	public ModelAndView requiredLogin_elecApprovalMain(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {

		List<Document> elecapprvoWaitingList = null;
		List<Document> elecapprvoProcessingList = null;
		List<Document> elecapprvoFinishedList = null;
		
		Map<String,String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		int totalWaitingCount = 0;
		
		int startRno = 1;           // 시작 행번호 : 1
		int endRno = 5;             // 끝 행번호 : 5
		
		
		// 총 대기중 게시물 건수(totalWaitingCount)
		totalWaitingCount = dService.getTotalWaitingCount(paraMap);
					
		mv.addObject("totalWaitingCount", totalWaitingCount);
					
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		elecapprvoWaitingList = dService.waitingApprList(paraMap);
		elecapprvoProcessingList = dService.processingApprList(paraMap);
		elecapprvoFinishedList = dService.finishedApprList(paraMap);
		
		mv.setViewName("WEB-INF/views/document/documentMain");
		
		return mv;
	}
	
	// 부서문서함 뷰
	@RequestMapping("teamdocView.dc")
	public String teamdoc() {
		return "teamdocumentMain";
	}
	
	// 새결재진행 뷰
	@RequestMapping("newApprovalView.dc")
	public String newApprovalView() {
		return "newApprovalWrite";
	}
	
	// 새결재진행 기능
	@RequestMapping("newApproval.dc")
	public String insertNewApproval(@ModelAttribute Document d, @RequestParam("uploadFile") String uploadFile, 
									HttpServletRequest request, HttpServletResponse response) {
		System.out.println(d);
		System.out.println(uploadFile);
		
		int result = dService.insertNewApproval(d);
		
		if(result > 0) {
			return "documentMain";
		} else {
			return null;
		}
		
		
	}
	
	@RequestMapping("approvalDetail.dc")
	public String approvalDetail() {
		return "approvalDetail";
	}
}
