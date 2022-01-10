package com.codeusgroup.codeus.marketBoard.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.codeusgroup.codeus.commBoard.common.Pagination;
import com.codeusgroup.codeus.commBoard.model.exception.BoardException;
import com.codeusgroup.codeus.commBoard.model.service.CommBoardService;
import com.codeusgroup.codeus.commBoard.model.vo.CommBoard;
import com.codeusgroup.codeus.commBoard.model.vo.PageInfo;
import com.codeusgroup.codeus.marketBoard.model.service.marketBoardService;

@SessionAttributes("loginUser")
@Controller
public class marketBoardController {

		@Autowired
		private marketBoardService mbService;
		
		
		@RequestMapping("marketboardinsertView.bo")
		public String commMarketInsertView() {
			return "commMarketInsertForm";
		}
		
		
		@RequestMapping("marketblist.bo")
		public String marketBoardList(@RequestParam(value="page", required=false) Integer page, Model model) {
			int currentPage = 1;
			if(page != null) {
				currentPage = page;
			}
			
			int listCount = mbService.getmarketBoardListCount();
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			ArrayList<CommBoard> list = (ArrayList<CommBoard>) mbService.marketBoardselectList(pi);
		
			
			if(list != null) {
				model.addAttribute("pi", pi);
				model.addAttribute("list", list);
			} else {
				throw new BoardException("게시판 조회에 실패하였습니다.");
			}
			
			return "commMarketList";
		}
		
		


		@RequestMapping("marketDetail.bo")
		public String marketDetail(@RequestParam("bId") int bId, @RequestParam(value="page", required=false) Integer page, 
										 Model model) {
			
			CommBoard b = mbService.selectMarketBoard(bId);
			
			if( b != null) {
				model.addAttribute("b", b);
				model.addAttribute("page", page);
			} else {
				throw new BoardException("게시글 상세 조회에 실패하였습니다.");
			}
			
			return "commMarketDetail";
		}
		
		@RequestMapping("mboardinsert.bo")
		public String boardInsert(@ModelAttribute CommBoard b, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
		
			
			if(uploadFile != null && !uploadFile.isEmpty()) { // 첨부파일이 있다면
				String renameFileName = saveFile(uploadFile, request);
				
				if(renameFileName != null) {
					b.setRenameFileName(renameFileName);
					b.setOriginalFileName(uploadFile.getOriginalFilename());
					
					System.out.println(renameFileName);
				}
			}
			
			int result = mbService.marketInsertBoard(b);
			
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
		}

