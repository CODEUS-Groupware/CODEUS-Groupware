package com.codeusgroup.codeus.commBoard.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;
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
import com.codeusgroup.codeus.noticeBoard.model.service.NoticeBoardService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@SessionAttributes("loginUser")
@Controller
public class CommBoardController {
	
	@Autowired
	private NoticeBoardService nbService;
	
	@Autowired
	private CommBoardService bService;
	
	
	@Autowired
	private marketBoardService mbService;

	@RequestMapping("CommboardinsertView.bo")
	public String boardInsertView() {
		return "commBoardInsertForm";
	}
	
	
//------ ??????????????? 
	
	//??????????????? ????????? ??????  
	
	@RequestMapping("binsert.bo")
	public String boardInsert(@ModelAttribute CommBoard b, HttpServletRequest request) {
		
		
		int result = bService.commInsertBoard(b);
		
		if(result > 0) {
			return "redirect:Commblist.bo";
			
		} else {
			throw new BoardException("????????? ????????? ??????????????????.");
		}
	}

	
	//??????????????? summernote????????? ??????  - ?????? ????????????

    @PostMapping(value="uploadSummernoteImageFile.bo", produces = "application/json")
    @ResponseBody
    public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {

        JsonObject jsonObject = new JsonObject();

        String fileRoot = "C:\\summernote_image\\";	//????????? ?????? ?????? ??????
        String originalFileName = multipartFile.getOriginalFilename();	//???????????? ?????????
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//?????? ?????????

        String savedFileName = UUID.randomUUID() + extension;	//????????? ?????? ???

        File targetFile = new File(fileRoot + savedFileName);

        try {
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//?????? ??????
            jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
            jsonObject.addProperty("responseCode", "success");

        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);	//????????? ?????? ??????
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }

        return jsonObject;
    }

	
	//?????? ????????? ?????? ????????? 
    
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
			throw new BoardException("????????? ????????? ?????????????????????.");
		}
		
		return "commBoardList";
	}
	
	//??????????????? ?????? ?????????
	
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
			throw new BoardException("????????? ?????? ?????? ??????");
		}
		
		return mv;
	}
	

	//??????????????? ????????? ????????? ??????
	
	@RequestMapping("CommBoardDetail.bo")
	public String commonBoardDetail(@RequestParam("bId") int bId, @RequestParam(value="page", required=false) Integer page, 
									 Model model) {
		
		CommBoard b = bService.selectCommBoard(bId);
		
		if( b != null) {
			model.addAttribute("b", b);
			model.addAttribute("page", page);
		} else {
			throw new BoardException("????????? ?????? ????????? ?????????????????????.");
		}
		
		return "commBoardDetail";
	}
	
	//??????????????? ????????? ??????
	
	@RequestMapping("bupView.bo")
	public String boardUpdateView(@RequestParam("page") int page, @RequestParam("bId") int bId, Model model) {
		
		CommBoard b = bService.selectCommBoard(bId);
		
		System.out.println(b);
		model.addAttribute("b", b)
			.addAttribute("page", page); 
		return "commBoardUpdateForm";
	}
	
	//??????????????? ??????
	
	@RequestMapping("bupdate.bo")
	public String updateBoard(@ModelAttribute CommBoard b, @RequestParam("page") int page, 
							  HttpServletRequest request, Model model) {
		
		
		int result = bService.commUpdateBoard(b);

		if(result > 0) {
			model.addAttribute("page", page);
		} else {
			throw new BoardException("????????? ????????? ?????????????????????.");
		}
		
		return "redirect:CommBoardDetail.bo?bId=" + b.getbId();
	}
	
	

	//??????????????? ????????? ?????? 
	
	@RequestMapping("commbDelete.bo")
	public String deleteBoard(@RequestParam("bId") int bId) {
    	System.out.println(bId);
    	int result = bService.CommBoardDelete(bId);
    	System.out.println(result);
    	if(result > 0) {
    		
    		return "redirect:Commblist.bo";
    		
		} else {
			throw new BoardException("????????? ????????? ?????????????????????."); 
			
		}
	}
	
//------ ???????????? ??????  		
	
	//???????????? ?????? ??????
	
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
			throw new BoardException("?????? ????????? ?????????????????????."); 
		}
	}
	

	
	//???????????? ?????? ?????????
	
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
	

	
	
	//???????????? ?????? ??????
	
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
	
	//???????????? ?????? ??????
	
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

	//???????????? ?????? ??????(????????? ??????)
	
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
//------ ????????????
	
	//?????? ????????? ?????? 
	
	@ResponseBody
	@RequestMapping("reportCommPost.bo")
	public String reportPost(@RequestParam("bId")int bId,@RequestParam("preport") char preport,@ModelAttribute Report rep, HttpSession session) {
	System.out.println(bId);
	Report rp = bService.ckReportPost(bId);
	System.out.println(rp);
	
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
	
	// ??????????????? ?????? 

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

//------ ?????? ????????? 

	// ?????? ????????? ?????????(????????? ???????????? ?????? ???)
	
		@RequestMapping("marketblist.bo")
		public String marketBoardList(@RequestParam(value="page", required=false) Integer page, Model model) {
			
			int currentPage = 1;
			if(page != null) {
				currentPage = page;
			}
			
			int listCount = mbService.getmarketBoardListCount();
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			ArrayList<MarketBoard> list = (ArrayList<MarketBoard>) mbService.marketBoardselectList(pi);
			
			ArrayList<MarketAtt> attList = new ArrayList<MarketAtt>();
			
			for(MarketBoard b : list) {
				MarketAtt att = mbService.selectAttachmentList(b.getbId());
				attList.add(att);
			}
			
			
			if(list != null) {
				model.addAttribute("pi", pi);
				model.addAttribute("list", list);
				model.addAttribute("attList", attList);
			} else {
				throw new BoardException("????????? ????????? ?????????????????????.");
			}
			
			return "commMarketList";
		}
		
		

		// ?????? ????????? ????????? ????????? ?????? 
		
		@RequestMapping("marketDetail.bo")
		public String marketDetail(@RequestParam("bId") int bId, @RequestParam(value="page", required=false) Integer page, 
										 Model model, HttpSession session) {
		
			String mId = ((Member)session.getAttribute("loginUser")).getmId();
			
			MarketBoard mb = mbService.selectMarketOneBoard(bId);
			MarketAtt att = mbService.selectAttachmentList(bId);
			
			
//			String mId = ((Member)session.getAttribute("loginUser")).getmId();
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("bNum", String.valueOf(bId));
			map.put("mId", mId);
			System.out.println(map);
			int scrapStatus = nbService.getScrapStatus(map);
			
			System.out.println(scrapStatus);
			if( mb != null) {
				model.addAttribute("scrapStatus", scrapStatus);
				model.addAttribute("mb", mb);
				model.addAttribute("att", att);
				model.addAttribute("page", page);
			} else {
				throw new BoardException("????????? ?????? ????????? ?????????????????????.");
			}
			
			return "commMarketDetail";
		}
		
		
		// ?????? ????????? ???????????? ?????? ?????? 
		
		@RequestMapping("marketinsertView.bo")
		public String commMarketInsertView() {
			return "commMarketInsertForm";
			
		}
		
		//?????? ????????? summernote????????? ??????  - ?????? ????????????

	    @PostMapping(value="/uploadmaeketImageFile.", produces = "application/json")
	    @ResponseBody
	    public JsonObject uploadmaeketImageFile(@RequestParam("file") MultipartFile multipartFile) {

	    
	    	
	        JsonObject jsonObject = new JsonObject();

	        String fileRoot = "C:\\summernote_image\\";	//????????? ?????? ?????? ??????
	        String originalFileName = multipartFile.getOriginalFilename();	//???????????? ?????????
	        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//?????? ?????????

	        String savedFileName = UUID.randomUUID() + extension;	//????????? ?????? ???

	        File targetFile = new File(fileRoot + savedFileName);

	        try {
	            InputStream fileStream = multipartFile.getInputStream();
	            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//?????? ??????
	            jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
	            jsonObject.addProperty("responseCode", "success");

	        } catch (IOException e) {
	            FileUtils.deleteQuietly(targetFile);	//????????? ?????? ??????
	            jsonObject.addProperty("responseCode", "error");
	            e.printStackTrace();
	        }

	        return jsonObject;
	    }

		
		@RequestMapping("marketInsert.bo")
		public String boardInsert(@ModelAttribute MarketBoard mb, @RequestParam("uploadFile") 
									MultipartFile uploadFile, HttpServletRequest request) {
			
			MarketAtt at = new MarketAtt();
			
			ArrayList<MarketAtt> attList = new ArrayList<MarketAtt>();
			//?????? ???????????? 
			int result = mbService.insertMarketBoard(mb);
			
			if(result > 0) {
				if(uploadFile != null && !uploadFile.isEmpty()) { 
					String renameFileName = saveFile(uploadFile, request);
					
					if(renameFileName != null) {
						at.setReFileName(renameFileName);
						at.setOriFileName(uploadFile.getOriginalFilename());
						at.setPath("/resources/buploadFiles\\" + renameFileName);
						
						attList.add(at);
						
						result += mbService.saveimage(at);
						
						if(result >=2) {
							System.out.println(attList);
							return "redirect:marketblist.bo";
							
						}
						
					}
				}
			}
			return "redirect:marketblist.bo";
	}
		public String saveFile(MultipartFile file, HttpServletRequest request) {
			String root = request.getSession().getServletContext().getRealPath("resources");
			String savePath = root + "\\buploadFiles";
			System.out.println(savePath);
			File folder = new File(savePath);
			if(!folder.exists()) {
				folder.mkdirs();
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String originFileName = file.getOriginalFilename();
			String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + originFileName.substring(originFileName.lastIndexOf(".") + 1);
			
			String renamePath = folder + "\\" + renameFileName;
			
			
			System.out.println(renamePath);
			
			try {
				file.transferTo(new File(renamePath));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			return renameFileName;
		}
	


//???????????? ????????? ????????????

		
		@RequestMapping("mupView.bo")
		public String marketUpdateView(@RequestParam("page") int page,@RequestParam("bId") int bId, Model model) {
	
			MarketAtt att = mbService.selectAttachmentList(bId);
			MarketBoard mb = mbService.selectMarketOneBoard(bId);
			
			model.addAttribute("mb", mb);
			model.addAttribute("page", page); 
			model.addAttribute("att", att);
			
			return "commMarketUpdateForm";
			
			
		}		
		
		@RequestMapping("mupdate.bo")
		public String updateBoard(@ModelAttribute MarketAtt at, @RequestParam("reloadFile") MultipartFile reloadFile, @RequestParam("page") int page, 
				  HttpServletRequest request, Model model, MarketBoard mb ) {
			
			
			ArrayList<MarketAtt> attList = new ArrayList<MarketAtt>();

			
			int result = mbService.updateMarkBoard(mb);
			
			

			if(result > 0) {
						model.addAttribute("page", page);
				} else {
				
				throw new BoardException("????????? ????????? ?????????????????????.");
			}
			
			
			
			if(reloadFile != null && !reloadFile.isEmpty()) { 
				if(at.getReFileName() != null) { 
					deleteFile(at.getReFileName(), request);
				}
				
				String renameFileName = saveFile(reloadFile, request);
			
			
			if(renameFileName != null) {
				at.setReFileName(renameFileName);
				at.setOriFileName(reloadFile.getOriginalFilename());
				at.setPath("/resources/buploadFiles\\" + renameFileName);
				
				attList.add(at);
				
				result += mbService.updateimage(at);
				
				if(result < 2) {
					throw new BoardException("????????? ?????? ????????? ?????????????????????.");
				
					}
				
				}
			
			}
			
			return "redirect:marketDetail.bo?bId=" + mb.getbId();
		}

		
	private void deleteFile(String renameFileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = root + "\\buploadFiles";
		
		File f = new File(savePath + "\\" + renameFileName);
		if(f.exists()) {
			f.delete();
		}
	}


	@RequestMapping("marketDelete.bo")
	public String boardDelete(@RequestParam("bId") int bId) {
		
		int result = mbService.deleteBoard(bId);
		
		if(result > 0) {
			return "redirect:marketblist.bo";
		} else {
			throw new BoardException("????????? ????????? ??????????????????.");
			
		}
	
	}
//?????? ????????? ??????
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
	
	ArrayList<MarketAtt> attList = new ArrayList<MarketAtt>();
	
	for(MarketBoard b : SearchList) {
		MarketAtt att = mbService.selectAttachmentList(b.getbId());
		attList.add(att);
	}
	
	
	
	if(SearchList != null) {
		mv.addObject("list", SearchList);
		mv.addObject("search", search);
		mv.addObject("pi", pi);
		mv.addObject("attList", attList);
		
		mv.setViewName("commMarketList");			
	} else {
		throw new BoardException("????????? ?????? ?????? ??????");
	}
	
	return mv;
}



//????????? ?????????, ?????????, ???????????????, ?????? ????????? ?????? ??????
	@RequestMapping("poption.bo")
	public ModelAndView productOption(@RequestParam(value="page", required=false) Integer page,
									  @RequestParam("option") String option,
									  ModelAndView mv) {

		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = mbService.getListOptionCount(option);// ??? ????????? ???

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<MarketBoard> mlist = mbService.selectOptionPList(option, pi);
	

		if (mlist != null) {
			mv.addObject("mlist", mlist)
			   .addObject("pi", pi)
			   .setViewName("commMarketList");
			
		} else {
			throw new BoardException("?????? ????????? ?????????????????????.");
		}
		
		return mv;
	}
}





