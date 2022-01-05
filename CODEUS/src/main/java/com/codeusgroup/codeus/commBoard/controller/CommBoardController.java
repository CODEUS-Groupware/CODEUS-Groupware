package com.codeusgroup.codeus.commBoard.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.commBoard.model.exception.BoardException;
import com.codeusgroup.codeus.commBoard.model.service.CommBoardService;
import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.common.Pagination;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@SessionAttributes("loginUser")
@Controller
public class CommBoardController {
	
	@Autowired
	private CommBoardService bService;
	

	@RequestMapping("CommboardinsertView.bo")
	public String boardInsertView() {
		return "commBoardInsertForm";
	}
	
	@RequestMapping("commInsert.bo")
	public String boardInsert(@ModelAttribute CommBoard b, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
		
//		System.out.println(b);
//		System.out.println(uploadFile);
		// 첨부파일이 있고 없고는 MultipartFile의 객체가 null이냐 아니야로 따지는 게 아니라
		// MultipartFile 안에 있는 메소드 getOriginalFilename()으로 판별 가능
		// 첨부 파일이 있을 때 : 실제 파일 이름
		// 첨부 파일이 없을 때 : 
		
		if(uploadFile != null && !uploadFile.isEmpty()) { // 첨부파일이 있다면
			String renameFileName = saveFile(uploadFile, request);
			
			if(renameFileName != null) {
				b.setRenameFileName(renameFileName);
				b.setOriginalFileName(uploadFile.getOriginalFilename());
			}
		}
		
		int result = bService.commInsertBoard(b);
		
		if(result > 0) {
			return "redirect:blist.bo";
		} else {
			throw new BoardException("게시글 등록에 실패했습니다.");
		}
	}

	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		// 웹 서버 contextPath를 불러와 폴더의 경로를 받아옴(webapp 하위의 resources 폴더)
		
		String savePath = root + "\\buploadFiles";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + originFileName.substring(originFileName.lastIndexOf(".") + 1);
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	
	
	
	@RequestMapping("Commblist.bo")
	public String commonBoardList(@RequestParam(value="page", required=false) Integer page, Model model) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = bService.getCommBoardListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<CommBoard> list = (ArrayList<CommBoard>) bService.CommBoardselectList(pi);
	
		
		if(list != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
		} else {
			throw new BoardException("게시판 조회에 실패하였습니다.");
		}
		
		return "commBoardList";
	}

	@RequestMapping("CommBoardDetail.bo")
	public String commonBoardDetail(@RequestParam("bId") int bId, @RequestParam(value="page", required=false) Integer page, 
									 Model model) {
		
		CommBoard b = bService.selectCommBoard(bId);
		
		if( b != null) {
			model.addAttribute("b", b);
			model.addAttribute("page", page);
		} else {
			throw new BoardException("게시글 상세 조회에 실패하였습니다.");
		}
		
		return "commBoardDetail";
	}
	
	
	@RequestMapping("bupView.bo")
	public String boardUpdateView(@RequestParam("page") int page, @RequestParam("bId") int bId, @RequestParam(value = "upd", required = false) String upd, Model model) {
		
		// 조회수가 올라가지 않게 설정해주어야 함
		CommBoard b = bService.selectCommBoard(bId);
		
		model.addAttribute("b", b).addAttribute("page", page); 
		
		return "commBoardUpdateForm";
	}
	
	
	
	@RequestMapping("commbdelete.bo")
	public String deleteBoard(@RequestParam("bId") int bId, HttpServletRequest request) {
		CommBoard b = bService.selectCommBoard(bId);
		
//		if(b.getOriginalFileName() != null) { // 첨부파일이 존재하면 첨부파일 삭제
//			deleteFile(b.getRenameFileName(), request);
//		}
		
		int result = bService.CommBoardDelete(bId);
		
		if(result > 0) {
			return "redirect:Commblist.bo";
		} else {
			throw new BoardException("게시글 삭제에 실패하였습니다."); 
		}
	}
	
	
	//댓글
	
	@RequestMapping("addReply.bo")
	@ResponseBody
	public String addReply(/*@RequestParam("replyContent") String replyContent, @RequestParam("refBoardId") int refBoardId,*/@ModelAttribute Reply r, HttpSession session) {
		
		String replyWriter = ((Member)session.getAttribute("loginUser")).getmId();
		
//		Reply r = new Reply();
//		r.setReplyContent(replyContent);
//		r.setRefBoardId(refBoardId);
		r.setrWriter(replyWriter);
		
		int result = bService.addReply(r);
		
		if(result > 0) {
			return "success";
		} else {
			throw new BoardException("댓글 등록에 실패하였습니다."); 
		}
	}
	
	@RequestMapping("rList.bo")
	@ResponseBody
	public void getReplyList(@RequestParam("bId") int bId, HttpServletResponse response) {
		ArrayList<Reply> rList = (ArrayList<Reply>) bService.selectReplyList(bId);
		
		response.setContentType("application/json; charset=UTF-8");
//		Gson gson = new Gson();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(rList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	

}




