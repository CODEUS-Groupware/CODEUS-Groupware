package com.codeusgroup.codeus.commBoard.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.UUID;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.codeusgroup.codeus.commBoard.model.service.marketBoardService;
import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.MarketAtt;
import com.codeusgroup.codeus.commBoard.model.vo.MarketBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.commBoard.model.vo.Reply;
import com.codeusgroup.codeus.commBoard.model.vo.Report;
import com.codeusgroup.codeus.commBoard.model.vo.Search;
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
	
	@Autowired
	private marketBoardService mbService;

	@RequestMapping("CommboardinsertView.bo")
	public String boardInsertView() {
		return "commBoardInsertForm";
	}
	
	
//------ 자유게시판 
	
	//자유게시판 게시물 등록  
	
	@RequestMapping("binsert.bo")
	public String boardInsert(@ModelAttribute CommBoard b, HttpServletRequest request) {
		
		
		int result = bService.commInsertBoard(b);
		
		if(result > 0) {
			return "redirect:Commblist.bo";
			
		} else {
			throw new BoardException("게시글 등록에 실패했습니다.");
		}
	}

	
	//자유게시판 summernote게시물 등록  - 파일 컨드롤러

    @PostMapping(value="/uploadSummernoteImageFile.", produces = "application/json")
    @ResponseBody
    public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {

        JsonObject jsonObject = new JsonObject();

        String fileRoot = "C:\\summernote_image\\";	//저장될 외부 파일 경로
        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자

        String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명

        File targetFile = new File(fileRoot + savedFileName);

        try {
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
            jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
            jsonObject.addProperty("responseCode", "success");

        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }

        return jsonObject;
    }

	
	//자유 게시판 일반 리스트 
    
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
	
	//자유게시판 검색 리스트
	
	@RequestMapping("commBoardSearch.bo")
	public ModelAndView commBoardSearch( ModelAndView mv, Search search,
			@RequestParam(value="page", required=false) Integer page) {

		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}

		int listCount = bService.commsearchListCount(search);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<CommBoard> SearchList = bService.commSearchList(search, pi);
		
		if(SearchList != null) {
			mv.addObject("list", SearchList);
			mv.addObject("search", search);
			mv.addObject("pi", pi);
			mv.setViewName("commBoardList");			
		} else {
			throw new BoardException("게시글 목록 검색 실패");
		}
		
		return mv;
	}
	

	//자유게시판 게시글 자세히 보기
	
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
	
	//자유게시판 수정뷰 가기
	
	@RequestMapping("bupView.bo")
	public String boardUpdateView(@RequestParam("page") int page, @RequestParam("bId") int bId, Model model) {
		
		CommBoard b = bService.selectCommBoard(bId);
		
		System.out.println(b);
		model.addAttribute("b", b).addAttribute("page", page); 
		return "commBoardUpdateForm";
	}
	
	//자유게시판 수정
	
	@RequestMapping("bupdate.bo")
	public String updateBoard(@ModelAttribute CommBoard b, @RequestParam("page") int page, 
							  HttpServletRequest request, Model model) {
		
		
		int result = bService.commUpdateBoard(b);

		if(result > 0) {
			model.addAttribute("page", page);
		} else {
			throw new BoardException("게시글 수정에 실패하였습니다.");
		}
		
		return "redirect:CommBoardDetail.bo?bId=" + b.getbId();
	}
	
	

	//지유게시판 게시글 삭제 - 오류 고쳐야 함 
	
	@RequestMapping("commbDelete.bo")
	public String deleteBoard(@RequestParam("bId") int bId) {
    	
    	int result = bService.CommBoardDelete(bId);
    	
    	if(result > 0) {
			return "redirect:commBoardList";
		} else {
			throw new BoardException("게시글 삭제에 실패하였습니다."); 
		}
	}
	
//------ 커뮤니티 댓글  		
	
	//커뮤니티 댓글 등록
	
	@RequestMapping("addReply.bo")
	@ResponseBody
	public String addReply(@ModelAttribute Reply r, HttpSession session) {
		
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
	

	
	//커뮤니티 댓글 리스트
	
	@RequestMapping("rList.bo")
	@ResponseBody
	public void getReplyList(@RequestParam(value="bId", required=false)int bId, HttpServletResponse response) {
		ArrayList<Reply> rList = (ArrayList<Reply>) bService.selectReplyList(bId);
		
		response.setContentType("application/json; charset=UTF-8");

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(rList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	//커뮤니티 댓글 표시 하기 
	
//	@RequestMapping(value = "/readView", method = RequestMethod.GET)
//	public String readReply(CommBoard b, @RequestParam("bId") Integer bId, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
//		logger.info("read");
//			
//		service.viewCount(board_number);
//	    
//		service.updateReplyCount(board_number);   // 게시물에 들어가면 댓글 수 업데이트
//	    
//		model.addAttribute("BoardVO", service.read(board.getBoard_number()));
//		model.addAttribute("cri", cri);
//			
//		List<ReplyVO> replyList = replyService.readReply(board.getBoard_number());
//		model.addAttribute("replyList", replyList);
//			
//		return "board/readView";
//	}
	
	
	
	//커뮤니티 댓글 수정
	
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
	
	//커뮤니티 댓글 삭제
	
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

	//커뮤니티 댓글 신고(간단한 버전)
	
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
//------ 신고하기
	
	//자유 게시글 신고 - 모달 오류 고쳐야함 
	
	@ResponseBody
	@RequestMapping(value="reportCommPost.bo",method=RequestMethod.POST)
	public String reportPost(@RequestParam("bId")int bId,@RequestParam("preport") char preport,@ModelAttribute Report rep, HttpSession session) {
		
	Report rp = bService.ckReportPost(bId);
	
	
	if(rp == null) {
		String rWriter = ((Member)session.getAttribute("loginUser")).getmId();
		rep.setmId(rWriter);
		rep.setbId(bId);
		rep.setReportType(preport);
		
		int result = bService.reportPost(rep);
	
		System.out.println(result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}else {
		return "fail";
	}
	}
	
	// 마켓게시글 신고 - 모달 오류 고쳐야함 

	@ResponseBody
	@RequestMapping(value="reportMarketPost.bo",method=RequestMethod.POST)
	public String reportMarket(@RequestParam("bId")int bId,@RequestParam("preport") char preport,@ModelAttribute Report rep, HttpSession session) {
		
	Report rp = bService.ckReportPost(bId);
	
	
	if(rp == null) {
		String rWriter = ((Member)session.getAttribute("loginUser")).getmId();
		rep.setmId(rWriter);
		rep.setbId(bId);
		rep.setReportType(preport);
		
		int result = bService.reportPost(rep);
	
		System.out.println(result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}else {
		return "fail";
	}
}

//------ 마켓 게시판 

	// 마켓 게시판 리스트(이미지 사진으로 변경 예)
	
		@RequestMapping("marketblist.bo")
		public String marketBoardList(@RequestParam(value="page", required=false) Integer page, Model model) {
			int currentPage = 1;
			if(page != null) {
				currentPage = page;
			}
			
			int listCount = mbService.getmarketBoardListCount();
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			ArrayList<MarketBoard> list = (ArrayList<MarketBoard>) mbService.marketBoardselectList(pi);
		
			
			if(list != null) {
				model.addAttribute("pi", pi);
				model.addAttribute("list", list);
			} else {
				throw new BoardException("게시판 조회에 실패하였습니다.");
			}
			
			return "commMarketList";
		}
		
		

		// 마켓 게시판 리스트 자세히 보기 
		
		@RequestMapping("marketDetail.bo")
		public String marketDetail(@RequestParam("bId") int bId, @RequestParam(value="page", required=false) Integer page, 
										 Model model) {
		
			MarketBoard mb = mbService.selectMarketOneBoard(bId);
			List<Map<String, String>> atttList = mbService.selectAttachmentList(bId);
			
			if( mb != null) {
				model.addAttribute("mb", mb);
				model.addAttribute("attachmentList", atttList);
				model.addAttribute("page", page);
			} else {
				throw new BoardException("게시글 상세 조회에 실패하였습니다.");
			}
			
			return "commMarketDetail";
		}
		
		
		// 마켓 게시글 등록하기 뷰로 가기 
		
		@RequestMapping("marketinsertView.bo")
		public String commMarketInsertView() {
			return "commMarketInsertForm";
			
		}
		
		//마켓 게시판 summernote게시물 등록  - 파일 컨드롤러

	    @PostMapping(value="/uploadmaeketImageFile.", produces = "application/json")
	    @ResponseBody
	    public JsonObject uploadmaeketImageFile(@RequestParam("file") MultipartFile multipartFile) {

	        JsonObject jsonObject = new JsonObject();

	        String fileRoot = "C:\\summernote_image\\";	//저장될 외부 파일 경로
	        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
	        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자

	        String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명

	        File targetFile = new File(fileRoot + savedFileName);

	        try {
	            InputStream fileStream = multipartFile.getInputStream();
	            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
	            jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
	            jsonObject.addProperty("responseCode", "success");

	        } catch (IOException e) {
	            FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
	            jsonObject.addProperty("responseCode", "error");
	            e.printStackTrace();
	        }

	        return jsonObject;
	    }

		
//		// 마켓 게시글 등록하기 
//		
//		@RequestMapping("marketInsert.bo")
//		public String MamketInsert( Model model, HttpServletRequest request,
//		@RequestParam(value="uploadFile", required=false) MultipartFile[] imageFiles,MarketBoard mb) {
//			
//			String filePath = "resources/images/maketUploadFiles";
//			String saveDirectory = request.getSession().getServletContext().getRealPath(filePath);
//			List<MarketAtt> attachList = new ArrayList<>();
//			
//
//			if(imageFiles != null) {
//				for(MultipartFile f : imageFiles) {
//					if( f.isEmpty() == false ) {
//					
//						String originName = f.getOriginalFilename();
//						String changeName = fileNameChanger(originName);
//						try {
//							f.transferTo(new File(saveDirectory + "/" + changeName));
//						} catch (IllegalStateException | IOException e) {
//							e.printStackTrace();
//						}
//						MarketAtt at = new MarketAtt();
//						at.setOriFileName(originName);
//						at.setReFileName(changeName);
//						at.setPath(filePath + "/");
//						
//						attachList.add(at);
//					}
//				}
//			}
//		}	
		@RequestMapping("marketInsert.bo")
		public String boardInsert(@ModelAttribute MarketBoard mb, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
			
			MarketAtt at = new MarketAtt();
			
			System.out.println(uploadFile);
			
			//글을 등록하기 
			int result = mbService.insertMarketBoard(mb);
			
			if(result > 0) {
				
			
				if(uploadFile != null && !uploadFile.isEmpty()) { 
					String renameFileName = saveFile(uploadFile, request);
					
					if(renameFileName != null) {
						at.setReFileName(renameFileName);
						at.setOriFileName(uploadFile.getOriginalFilename());
						at.setPath("resources/images/maketUploadFiles\\" + renameFileName);
						
						result += mbService.saveimage(at);
						
						if(result >=2) {
							return "redirect:marketblist.bo";
						}
						
					}
				}
			}
			return "redirect:marketblist.bo";
	}
			public String saveFile(MultipartFile file, HttpServletRequest request) {
				String root = request.getSession().getServletContext().getRealPath("resources");
				// 웹 서버 contextPath를 불러와 폴더의 경로를 받아옴(webapp 하위의 resources 폴더)
				
				String filePath = "resources/images/maketUploadFiles";
				String saveDirectory = request.getSession().getServletContext().getRealPath(filePath);
				
				File folder = new File(filePath);
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
	


//자유게시판 게시글 수정하기


@RequestMapping("mupView.bo")
public ModelAndView boardUpdateView(@RequestParam("bId") int bId,@RequestParam("reloadFile") MultipartFile reloadFile,
		@RequestParam("page") int page, HttpServletRequest request, ModelAndView mv, MarketBoard mb, MarketAtt at) {
	
	
	if(reloadFile != null && !reloadFile.isEmpty()) { // 새로 변경할 파일이 있다면
	if(at.getOriFileName() != null) { // 기존에 넣었던 파일이 있다면
		deleteFile(at.getReFileName(), request);
	}
	
	String renameFileName = saveFile(reloadFile, request);
	
	if(renameFileName != null) {
		
		at.setReFileName(renameFileName);
		at.setOriFileName(reloadFile.getOriginalFilename());
	}
}

int result = mbService.updateMarkBoard(mb);

if(result > 0) {
	mv.addObject("page", page)
	  .addObject("bId", mb.getbId())
	  .setViewName("redirect:marketDetail.bo");
} else {
	throw new BoardException("게시글 수정에 실패했습니다.");
}

return mv;
}

private void deleteFile(String renameFileName, HttpServletRequest request) {
	String root = request.getSession().getServletContext().getRealPath("resources");
	
	String savePath = root + "\\buploadFiles";
	
	File f = new File(savePath + "\\" + renameFileName);
	if(f.exists()) {
		f.delete();
	}
}

@RequestMapping("mbdelete.bo")
public String boardDelete(@RequestParam("bId") int bId) {
	
	int result = mbService.deleteBoard(bId);
	
	if(result > 0) {
		return "redirect:marketblist.bo";
	} else {
		throw new BoardException("게시글 삭제에 실패했습니다.");
		}
	}


//마켓 게시판 검색
@RequestMapping("marketSearch.bo")
public ModelAndView marketSearch( ModelAndView mv, Search search,
		@RequestParam(value="page", required=false) Integer page) {

	int currentPage = 1;
	if(page != null) {
		currentPage = page;
	}

	int listCount = mbService.marketSearchListCount(search);

	PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
	
	ArrayList<MarketBoard> SearchList = mbService.MarketSearchList(search, pi);
	
	if(SearchList != null) {
		mv.addObject("list", SearchList);
		mv.addObject("search", search);
		mv.addObject("pi", pi);
		mv.setViewName("marketblist");			
	} else {
		throw new BoardException("게시글 목록 검색 실패");
	}
	
	return mv;
}



}




