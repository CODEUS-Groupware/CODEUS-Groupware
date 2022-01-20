package com.codeusgroup.codeus.noticeBoard.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.common.FileManager;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.codeusgroup.codeus.noticeBoard.common.Pagination;
import com.codeusgroup.codeus.noticeBoard.model.exception.NoticeBoardException;
import com.codeusgroup.codeus.noticeBoard.model.service.NoticeBoardService;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoard;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoardFile;
import com.codeusgroup.codeus.noticeBoard.model.vo.NoticeBoardReply;
import com.codeusgroup.codeus.noticeBoard.model.vo.PageInfo;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@Controller
public class NoticeBoardController {

	@Autowired
	private NoticeBoardService nbService;
	
	@Autowired
	private FileManager fileManager;
	
    /**
     * 공지사항 목록 조회
     */	
	@RequestMapping("noticeBoardList.nb")
	public ModelAndView noticeBoardList(@RequestParam(value="page", required=false) Integer page, 
								        @RequestParam(value="message", required=false) String message, ModelAndView mv) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = nbService.getListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<NoticeBoard> nbList = nbService.selectNoticeBoardList(pi);
		
		System.out.println(nbList);
		if (nbList != null) {
			mv.addObject("pi", pi);
			mv.addObject("nbList", nbList);
			mv.addObject("message", message);
			mv.setViewName("noticeBoardList");

			return mv;
			
		} else {
			throw new NoticeBoardException("게시글 리스트 조회에 실패하였습니다.");
		}
	}
	
    /**
     *  공지사항 검색
     */		
	@RequestMapping("searchNoticeBoard.nb")
	public ModelAndView selectSearchMemberList(@RequestParam(value="page", required=false) Integer page, 
										 @RequestParam("searchCondition") String searchCondition, @RequestParam("searchValue") String searchValue, 
										 @RequestParam(value="message", required=false) String message, ModelAndView mv) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchCondition", searchCondition);
		map.put("searchValue", searchValue.trim());

		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = nbService.getSearchListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		List<NoticeBoard> nbList = nbService.selectSearchList(pi, map);
		System.out.println(nbList);
		if(nbList != null) {
			mv.addObject("pi", pi);
			mv.addObject("nbList", nbList);
			mv.addObject("message", message);
			mv.addObject("searchCondition", searchCondition);
			mv.addObject("searchValue", searchValue);
			mv.setViewName("noticeBoardList");
			
			return mv;
			
		} else {
			throw new NoticeBoardException("게시글 검색 결과 조회에 실패하엿습니다.");
		}
	}
	
    /**
     *  게시글 작성 페이지로 이동
     */	
	@RequestMapping("nbinsertView.nb")
	public String noticeBoardInsertView() {
		
		return "noticeBoardInsertForm";
	}
	
	/**
     * summernote 이미지 업로드
     */	
	@RequestMapping(value="/uploadSummernoteImageFile.nb", produces = "application/json")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		System.out.println(multipartFile);
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = "C:\\summernote_image\\";	//저장될 외부 파일 경로
		// <Context path="/summernoteImage" reloadable="true" docBase="C:\\summernote_image\\"/>
      	// server.xml에서 톰캣의 컨텍스트 외부로 경로 매핑(외부에 업로드 폴더 설정)
		
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
	
	/**
     * summernote 이미지 삭제
     */	
	@RequestMapping("deleteSummernoteFile.nb")
	@ResponseBody
	public String deleteSummernoteFile(@RequestParam("src") String src, HttpServletRequest request) {
		
		String fileRoot = "C:\\summernote_image\\";	//저장될 외부 파일 경로

		String fileName = src.substring(src.lastIndexOf("summernoteImage/")).replace("summernoteImage/", "");
		
		File f = new File(fileRoot + fileName);
		
		if (f.exists()) {
			
			if(!f.delete()) {
				return "fail";
			}
		} 
		
		return "success";
	}	
	
	
	/**
     * 다중파일 업로드
     */	
	@RequestMapping(value="uploadFiles.nb", produces = "application/json")
	public void uploadFiles(@RequestParam("files") List<MultipartFile> uploadFileList, HttpServletRequest request, HttpServletResponse response) {
		// System.out.println(uploadFileList.get(0));
		// System.out.println(uploadFileList.size());
		
		if (uploadFileList != null && !uploadFileList.isEmpty()) {
			
			ArrayList<NoticeBoardFile> fList = new ArrayList<NoticeBoardFile>();
			
			for (MultipartFile f : uploadFileList) {
				
				String path = "/uploadFiles";
				String root = request.getSession().getServletContext().getRealPath("resources");
				String savePath = root + path;
				
				String renameFileName = fileManager.saveFile(f, request, path);
				
				if (renameFileName != null) {
					NoticeBoardFile file = new NoticeBoardFile();
					file.setFileOriginName(f.getOriginalFilename());
					file.setFileChangeName(renameFileName);
					file.setFilePath(savePath);
					file.setFileSize(f.getSize());
					
					fList.add(file);
				}
			}
			
			// file을 저장한 후 DB에 file에 대한 정보를 저장하기 위해 저장한 fileList를 뷰에 보냄
			if (!fList.isEmpty()) {
				Gson gson = new Gson();
				try {
					gson.toJson(fList, response.getWriter());
				} catch (JsonIOException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				throw new NoticeBoardException("파일 저장에 실패하였습니다.");
			}
		}
	}
	
	/**
     * 게시글 등록
     */	
	@RequestMapping("nbinsert.nb")
	public String insertNoticeBoard(@ModelAttribute NoticeBoard noticeBoard, 
									@RequestParam(value="fileOriginName", required=false) String[] fileOriginName, 
									@RequestParam(value="fileChangeName", required=false) String[] fileChangeName,
									@RequestParam(value="filePath", required=false) String[] filePath, 
									@RequestParam(value="fileSize", required=false) int[] fileSize, Model model, HttpServletRequest request) {

		if(noticeBoard.getPin() == null) {
			noticeBoard.setPin("N");
		}
		
		ArrayList<NoticeBoardFile> fList = new ArrayList<NoticeBoardFile>();
		if (fileOriginName != null) {
			
			for (int i = 0; i < fileOriginName.length; i++) {
				NoticeBoardFile file = new NoticeBoardFile();
				file.setFileOriginName(fileOriginName[i]);
				file.setFileChangeName(fileChangeName[i]);
				file.setFilePath(filePath[i]);
				file.setFileSize(fileSize[i]);
				
				fList.add(file);
			}
		}
		
		int result = nbService.insertNoticeBoard(noticeBoard, fList);
		
		if (result < fList.size() + 1) {
			// 게시글 등록 실패시 저장된 파일 삭제 
			if (!fList.isEmpty()) {
				for (NoticeBoardFile f : fList) {
					fileManager.deleteFile(f.getFileChangeName(), request, "/uploadFiles");
				}
			}
			
			throw new NoticeBoardException("게시글 등록에 실패하였습니다.");
		}
		
		return "redirect:noticeBoardList.nb?message=success";
	}
	
	/**
     * 게시글 상세 조회
     */		
	@RequestMapping("noticeBoardDetail.nb")
	public ModelAndView selectNoticeBoard(@RequestParam("bNum") int bNum, @RequestParam("page") int page, 
								    @RequestParam(value="searchCondition", required=false) String searchCondition, 
								    @RequestParam(value="searchValue", required=false) String searchValue, 
								    @RequestParam(value="message", required=false) String message, 
								    @RequestParam(value="upd", required=false) String upd, HttpSession session, ModelAndView mv) {
		
		NoticeBoard board = nbService.selectNoticeBoard(bNum, upd);
		
		List<NoticeBoardReply> replyList = nbService.selectReplyList(bNum);
		
		List<NoticeBoardFile> fileList = nbService.selectFileList(bNum); 
		
		String mId = ((Member)session.getAttribute("loginUser")).getmId();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bNum", String.valueOf(bNum));
		map.put("mId", mId);
		
		// 스크랩 상태 조회
		int scrapStatus = nbService.getScrapStatus(map);
		
		if (board != null && replyList != null && fileList != null) {
			mv.addObject("board", board);
			mv.addObject("replyList", replyList);
			mv.addObject("fileList", fileList);
			mv.addObject("scrapStatus", scrapStatus);
			mv.addObject("page", page);
			mv.addObject("message", message);
			mv.addObject("searchCondition", searchCondition);
			mv.addObject("searchValue", searchValue);
			
			mv.setViewName("noticeBoardDetail");
			
			return mv;
			
		} else {
			throw new NoticeBoardException("게시글 상세 조회에 실패하엿습니다.");
		}
		
	}
	
	
	/**
     * 글 스크랩 추가
     */		
	@RequestMapping("insertScrap.nb")
	@ResponseBody
	public String insertScrap(@RequestParam("bNum") String bNum, HttpSession session) {
		
		String mId = ((Member)session.getAttribute("loginUser")).getmId();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bNum", bNum);
		map.put("mId", mId);
		
		String result = nbService.insertScrap(map) >= 1 ? "success" : "fail";
		
		return result;

	}
	
	/**
     * 글 스크랩 해제
     */		
	@RequestMapping("deleteScrap.nb")
	@ResponseBody
	public String deleteScrap(@RequestParam("bNum") String bNum, HttpSession session) {
		
		String mId = ((Member)session.getAttribute("loginUser")).getmId();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("bNum", bNum);
		map.put("mId", mId);
		
		String result = nbService.deleteScrap(map) >= 1 ? "success" : "fail";
		
		return result;

	}	
	
	/**
     * 댓글 등록
     */		
	@RequestMapping("insertReply.nb")
	public void insertReply(@ModelAttribute NoticeBoardReply reply, HttpSession session, HttpServletResponse response) {
		
		String mId = ((Member)session.getAttribute("loginUser")).getmId();
		System.out.println(reply);
		reply.setReplyWriter(mId);
		
		int result = nbService.insertReply(reply);
		
		if (result > 0) {
			List<NoticeBoardReply> replyList = nbService.selectReplyList(reply.getRefBNum());
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			try {
				gson.toJson(replyList, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			throw new NoticeBoardException("댓글 등록에 실패하엿습니다.");	
		}
	}	
	
	
	/**
     * 댓글 수정
     */		
	@RequestMapping("updateReply.nb")
	public void updateReply(@ModelAttribute NoticeBoardReply reply, HttpSession session, HttpServletResponse response) {
		
		int result = nbService.updateReply(reply);
		
		if (result > 0) {
			List<NoticeBoardReply> replyList = nbService.selectReplyList(reply.getRefBNum());
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			try {
				gson.toJson(replyList, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			throw new NoticeBoardException("댓글 수정에 실패하엿습니다.");	
		}
	}	
	
	
	/**
     * 댓글 삭제
     */		
	@RequestMapping("deleteReply.nb")
	public void deleteReply(@ModelAttribute NoticeBoardReply reply, HttpSession session, HttpServletResponse response) {
		
		int result = nbService.deleteReply(reply.getReplyNo());
		
		if (result > 0) {
			List<NoticeBoardReply> replyList = nbService.selectReplyList(reply.getRefBNum());
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			try {
				gson.toJson(replyList, response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			throw new NoticeBoardException("댓글 삭제에 실패하엿습니다.");	
		}
	}	
	
	/**
     * 게시글 삭제
     */		
	@RequestMapping("nbDelete.nb")
	public String deleteNoticeBoard(@RequestParam("bNum") int bNum, HttpServletRequest request) {
		
		int result = nbService.deleteNoticeBoard(bNum);
		
		List<NoticeBoardFile> fileList = nbService.selectFileList(bNum); 
		
		// 게시글 삭제시 게시글에 등록되어 있던  file 저장소에서 삭제하고 DB의 file_status 삭제 상태로 바꿈
		if (result > 0) {
			if (!fileList.isEmpty()) {
				int result2 = nbService.deleteFile(fileList);
				System.out.println(result2);
				for (NoticeBoardFile f : fileList) {
					fileManager.deleteFile(f.getFileChangeName(), request, "/uploadFiles");
				}
				
				if (result2 < fileList.size()) {
					throw new NoticeBoardException("삭제 파일 상태 변경에 실패하엿습니다.");	
				}
			}
			
			return "redirect:noticeBoardList.nb?message=d";
			
		} else {
			throw new NoticeBoardException("게시글 삭제에 실패하엿습니다.");	
		}
		
	}
	
	/**
     * 게시글 수정 페이지로 이동
     */		
	@RequestMapping("nbUpdateView.nb")
	public ModelAndView noticeBoardUpdateView(@RequestParam("bNum") int bNum, @RequestParam("page") int page, 
								    @RequestParam(value="searchCondition", required=false) String searchCondition, 
								    @RequestParam(value="searchValue", required=false) String searchValue, ModelAndView mv) {
		
		String upd = "Y";
		NoticeBoard board = nbService.selectNoticeBoard(bNum, upd);
		
		List<NoticeBoardFile> fileList = nbService.selectFileList(bNum); 
		
		if (board != null && fileList != null) {
			mv.addObject("board", board);
			mv.addObject("fileList", fileList);
			mv.addObject("page", page);
			mv.addObject("searchCondition", searchCondition);
			mv.addObject("searchValue", searchValue);
			
			mv.setViewName("noticeBoardEditForm");
			
			return mv;
			
		} else {
			throw new NoticeBoardException("게시글 수정 페이지 이동에 실패하엿습니다.");
		}
		
	}	

	/**
     * 게시글 수정
     */		
	@RequestMapping("nbupdate.nb")
	public String updateNoticeBoard(@ModelAttribute NoticeBoard noticeBoard, 
										@RequestParam(value="fileOriginName", required=false) String[] fileOriginName, 
										@RequestParam(value="fileChangeName", required=false) String[] fileChangeName,
										@RequestParam(value="filePath", required=false) String[] filePath, 
										@RequestParam(value="fileSize", required=false) int[] fileSize,
										@RequestParam(value="fileNo", required=false) int[] fileNo,
										@RequestParam(value="deleteYn", required=false) String[] deleteYn,
										@RequestParam("page") int page,  @RequestParam(value="searchCondition", required=false) String searchCondition, 
										@RequestParam(value="searchValue", required=false) String searchValue,  Model model, HttpServletRequest request) {
		
		
		if(noticeBoard.getPin() == null) {
			noticeBoard.setPin("N");
		}
		
		ArrayList<NoticeBoardFile> fList = new ArrayList<NoticeBoardFile>(); // 새로 등록할 파일 리스트
		ArrayList<NoticeBoardFile>  deleteFList = new ArrayList<NoticeBoardFile>(); // 삭제한 기존 파일 리스트 
		if (fileOriginName != null && fileOriginName.length > 0) {
			
			for (int i = 0; i < fileOriginName.length; i++) {
				
				NoticeBoardFile file = new NoticeBoardFile();
				System.out.println(deleteYn[i]);
				if (deleteYn[i].equals("Y")) {
					file.setFileNo(fileNo[i]);
					
					deleteFList.add(file);
					
				} else if (deleteYn[i].equals("NEW")) {
					file.setFileOriginName(fileOriginName[i]);
					file.setFileChangeName(fileChangeName[i]);
					file.setFilePath(filePath[i]);
					file.setFileSize(fileSize[i]);
					file.setbNum(noticeBoard.getbNum());
					
					fList.add(file);
				}
				
				System.out.println(file);
			}
		}
		
		int result = nbService.updateNoticeBoard(noticeBoard, fList);
		
		if (result >= fList.size() + 1) {
			
			// 기존 파일 삭제했을 경우  해당 file 저장소에서 삭제하고 DB의 file_status 삭제 상태로 바꿈
			if (!deleteFList.isEmpty()) {
				
				for (NoticeBoardFile f : deleteFList) {
					fileManager.deleteFile(f.getFileChangeName(), request, "/uploadFiles");
				}

				int deleteResult = nbService.deleteFile(deleteFList);
				
				if (deleteResult < deleteFList.size()) {
					throw new NoticeBoardException("삭제 파일 상태 변경에 실패하엿습니다.");	
				}
			}
			
		} else {
			
			// 게시글 등록 실패시 저장된 파일 삭제 
			if (!fList.isEmpty()) {
				for (NoticeBoardFile f : fList) {
					fileManager.deleteFile(f.getFileChangeName(), request, "/uploadFiles");
				}
			}
			
			throw new NoticeBoardException("게시글 수정에 실패하였습니다.");
		}

		model.addAttribute("bNum", noticeBoard.getbNum()).addAttribute("upd", "Y");
		model.addAttribute("page", page).addAttribute("message", "success");
		model.addAttribute("searchCondition", searchCondition).addAttribute("searchValue", searchValue);
		
		return "redirect:noticeBoardDetail.nb";
	}		
	

}
