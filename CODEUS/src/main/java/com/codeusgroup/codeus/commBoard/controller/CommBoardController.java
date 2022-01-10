package com.codeusgroup.codeus.commBoard.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.commBoard.common.Pagination;
import com.codeusgroup.codeus.commBoard.model.exception.BoardException;
import com.codeusgroup.codeus.commBoard.model.service.CommBoardService;
import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@SessionAttributes("loginUser")
@Controller
public class CommBoardController {
	
	@Autowired
	private CommBoardService bService;
	

	@RequestMapping("CommboardinsertView.bo")
	public String boardInsertView() {
		return "commBoardInsertForm";
	}
	
	@RequestMapping("binsert.bo")
	public String boardInsert(@ModelAttribute CommBoard b, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
		
		//System.out.println(b);
		//System.out.println(uploadFile);
		// 첨부파일이 있고 없고는 MultipartFile의 객체가 null이냐 아니야로 따지는 게 아니라
		// MultipartFile 안에 있는 메소드 getOriginalFilename()으로 판별 가능
		// 첨부 파일이 있을 때 : 실제 파일 이름
		// 첨부 파일이 없을 때 : 
		
		if(uploadFile != null && !uploadFile.isEmpty()) { // 첨부파일이 있다면
			String renameFileName = saveFile(uploadFile, request);
			
			if(renameFileName != null) {
				b.setRenameFileName(renameFileName);
				b.setOriginalFileName(uploadFile.getOriginalFilename());
				
				System.out.println(renameFileName);
			}
		}
		
		int result = bService.commInsertBoard(b);
		
		if(result > 0) {
			return "redirect:Commblist.bo";
			
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
	
	@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
        /*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/fileupload/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/summernote/resources/fileupload/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
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
	public String boardUpdateView(@RequestParam("page") int page, @RequestParam("bId") int bId, Model model) {
		
		CommBoard b = bService.selectCommBoard(bId);
		
		System.out.println(b);
		model.addAttribute("b", b).addAttribute("page", page); 
		return "commBoardUpdateForm";
	}
	
	@RequestMapping("bupdate.bo")
	public String updateBoard(@ModelAttribute CommBoard b, @RequestParam("reloadFile") MultipartFile reloadFile, @RequestParam("page") int page, 
							  HttpServletRequest request, Model model) {
		
		if(reloadFile != null && !reloadFile.isEmpty()) { 
			if(b.getRenameFileName() != null) { 
				deleteFile(b.getRenameFileName(), request);
			}
			
			String renameFileName = saveFile(reloadFile, request);
			
			if(renameFileName != null) {
				b.setOriginalFileName(reloadFile.getOriginalFilename());
				b.setRenameFileName(renameFileName);
			}
		}
		
		int result = bService.commUpdateBoard(b);

		if(result > 0) {
			model.addAttribute("page", page);
		} else {
			throw new BoardException("게시글 등록을 실패하였습니다.");
		}
		
		return "redirect:CommBoardDetail.bo?bId=" + b.getbId();
	}
	
	@RequestMapping("commbDelete.bo")
	public String deleteBoard(@RequestParam("bId") int bId) {
    //public String boardDelete(@RequestParam(value="bNum",required=false) int bNum) {
    	
    	int result = bService.CommBoardDelete(bId);
    	
    	if(result > 0) {
			return "redirect:Commblist.bo";
		} else {
			throw new BoardException("게시글 삭제에 실패하였습니다."); 
		}
	}
	
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = root + "\\buploadFiles";
		
		File f = new File(savePath + "\\" + fileName);
		if(f.exists()) {
			f.delete();
		}
	}
	
	
	
	//************댓글
	
	@RequestMapping("addReply.bo")
	@ResponseBody
	public String addReply(/*@RequestParam("replyContent") String replyContent, @RequestParam("refBoardId") int refBoardId,*/@ModelAttribute Reply r, HttpSession session) {
		
		String replyWriter = ((Member)session.getAttribute("loginUser")).getmId();
		
//		Reply r = new Reply();
//		r.setReplyContent(replyContent);
//		r.setRefBoardId(refBoardId);
		r.setrWriter(replyWriter);
		
		int result = bService.addCommReply(r);
		
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
	
	@ResponseBody
	@RequestMapping(value="modifyReply.bo",method=RequestMethod.POST)
	public String modifyReply(@ModelAttribute Reply r) {
		int result = bService.modifyReply(r);
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="deleteReply.bo",method=RequestMethod.GET)
	public String deleteReply(@ModelAttribute Reply r) {
		int result = bService.deleteReply(r);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}

	
	@ResponseBody
	@RequestMapping(value="ReportReply.bo",method=RequestMethod.GET)
	public String reportReply(@RequestParam("bId")int bId,@RequestParam("rId")int rId,@ModelAttribute Report rep, HttpSession session) {
		
	Report rp = bService.ckReportReply(rId);
	
	
	if(rp == null) {
		String rWriter = ((Member)session.getAttribute("loginUser")).getmId();
		rep.setmId(rWriter);
		rep.setbId(bId);
		rep.setrId(rId);
	
		int result = bService.reportReply(rep);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}else {
		return "fail";
	}
	
}
	
	@ResponseBody
	@RequestMapping(value="reportCommPost.bo",method=RequestMethod.POST)
	public String reportPost(@RequestParam("bId")int bId,@ModelAttribute Report rep, HttpSession session,@RequestParam(value = "rId", required = false, defaultValue = "0") int rId) {
		
	Report rp = bService.ckReportPost(bId);
	
	
	if(rp == null) {
		String rWriter = ((Member)session.getAttribute("loginUser")).getmId();
		rep.setmId(rWriter);
		rep.setbId(bId);
		rep.setrId(rId);
	
		int result = bService.reportPost(rep);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}else {
		return "fail";
	}
}
	
}	
