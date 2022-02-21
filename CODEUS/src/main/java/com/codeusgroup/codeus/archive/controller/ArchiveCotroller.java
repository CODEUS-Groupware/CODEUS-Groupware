package com.codeusgroup.codeus.archive.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.archive.model.exception.ArchiveException;
import com.codeusgroup.codeus.archive.model.service.ArchiveService;
import com.codeusgroup.codeus.archive.model.vo.ArchiveCapacity;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFile;
import com.codeusgroup.codeus.archive.model.vo.ArchiveFolder;
import com.codeusgroup.codeus.common.FileManager;

@Controller
public class ArchiveCotroller {
	
	@Autowired
	private ArchiveService archService;
	
	@Autowired
	private FileManager fileManager;
	
	/**
     * 자료실 조회
     */		
	@RequestMapping("archive.arch")
	public ModelAndView archive(@RequestParam(value="currentFolder", required=false) Integer currentFolder,
	        			  @RequestParam(value="message", required=false) String message, ModelAndView mv) {
		
		ArchiveCapacity capacity = archService.selectArchiveCapacity();
		
		Integer currentUpperFolder = null;
		if (capacity != null) {
			
			List<ArchiveFolder> folderList = archService.selectFolderList();
			List<ArchiveFolder> hierarchicalFolderList = archService.selectHierarchicalfolderList();
			
			if (folderList != null && folderList.size() > 0) {
				for (ArchiveFolder f : folderList) {
					if (f.getUpperFolderId() != null && f.getFolderId() == currentFolder) {
						currentUpperFolder = f.getUpperFolderId();
					}
				}
			}
			
			List<ArchiveFile> fileList = archService.selectFileList(currentFolder);
			
			if (folderList != null && hierarchicalFolderList != null && fileList != null) {
				mv.addObject("capacity", capacity);
				mv.addObject("folderList", folderList);
				mv.addObject("hierarchicalFolderList", hierarchicalFolderList);
				mv.addObject("fileList", fileList);
			} else {
				throw new ArchiveException("파일 조회에 실패하였습니다.");
			}
		} 
		
		mv.addObject("currentFolder", currentFolder);
		mv.addObject("currentUpperFolder", currentUpperFolder);
		mv.addObject("message", message);
		mv.setViewName("archive");
		
		return mv;
	}
	
	/**
     * 자료실 총 용량 설정
     */		
	@RequestMapping("capacityInsert.arch")
	public String insertTotalCapacity(@RequestParam("totalCapacity") long totalCapacity) {
		
		long capacity = totalCapacity * 1073741824;
		
		int result = archService.insertTotalCapacity(capacity);

		if (result <= 0) {
			throw new ArchiveException("총 용량 설정에 실패하였습니다.");
		}
		
		return "redirect:archive.arch?message=success";
		
	}
	
	/**
     * 자료실 총 용량 수정
     */		
	@RequestMapping("capacityUpdate.arch")
	public String updateTotalCapacity(@RequestParam("totalCapacity") long totalCapacity,
									 @RequestParam(value="currentFolder", required=false) Integer currentFolder, Model model) {
		
		long capacity = totalCapacity * 1073741824;
		
		int result = archService.updateTotalCapacity(capacity);
		
		if (result <= 0) {
			throw new ArchiveException("총 용량 수정에 실패하였습니다.");
		}
		
		model.addAttribute("currentFolder", currentFolder);
		return "redirect:archive.arch?message=success";
	}

	/**
     * 자료실 파일 업로드
     */	
	@RequestMapping("uploadFile.arch")
	public String uploadFile(@RequestParam("uploadFile") List<MultipartFile> uploadFileList, HttpServletRequest request, 
							@RequestParam(value="currentFolder", required=false) Integer currentFolder, 
							@RequestParam("mId") String mId, Model model) {

		if (uploadFileList != null && !uploadFileList.isEmpty()) {
			
			ArrayList<ArchiveFile> fList = new ArrayList<ArchiveFile>();
			for (MultipartFile f : uploadFileList) {
				String path = "/uploadFiles/archive";
				String root = request.getSession().getServletContext().getRealPath("resources");
				String savePath = root + path;
				
				String renameFileName = fileManager.saveFile(f, request, path);
				String extension = f.getOriginalFilename().substring(f.getOriginalFilename().indexOf(".") + 1);
				
				if (renameFileName != null) {
					ArchiveFile file = new ArchiveFile();
					file.setOriginName(f.getOriginalFilename());
					file.setChangeName(renameFileName);
					file.setPath(savePath);
					file.setSize(f.getSize());
					file.setExtension(extension);
					file.setmId(mId);
					if (currentFolder != null) {
						file.setFolderId(currentFolder);
					}
					
					fList.add(file);
				}
			}
			
			int result = archService.insertArchiveFile(fList);
			
			if (result < fList.size() + 1) {
				if (!fList.isEmpty()) {
					for (ArchiveFile f : fList) {
						fileManager.deleteFile(f.getChangeName(), request, "/uploadFiles/archive");
					}
				}
				
				throw new ArchiveException("파일 등록에 실패하였습니다.");
			}
		}
		
		model.addAttribute("currentFolder", currentFolder);
		return "redirect:archive.arch?message=success";
	}
	
	
	/**
     * 파일 및 폴더 삭제
     */		
	@RequestMapping("deleteFile.arch")
	public String deleteFile(@RequestParam(value="fileNo", required=false) String[] fileArr, 
							 @RequestParam(value="folderId", required=false) int[] folderIdArr, HttpServletRequest request,
							 @RequestParam(value="currentFolder", required=false) Integer currentFolder, Model model) {
		
		int result1 = 0;
		int fileLength = 0;
		if (fileArr != null && fileArr.length > 0) {
			
			// 드라이브에 저장된 파일 삭제
			for (String f : fileArr) {
				String changeName = f.split("/")[2];
				
				fileManager.deleteFile(changeName, request, "/uploadFiles/archive");
			}
			
			fileLength = fileArr.length + 1;
			result1 = archService.deleteFile(fileArr);
		} 
		
		// 폴더 삭제 및 내부 파일 삭제
		int result2 = 0;
		String[] subFileArr = null;
		int folderIdArrLength = 0;
		List<ArchiveFile> deleteFileList = null;
		if (folderIdArr != null && folderIdArr.length > 0) {
			
			// 폴더 내부에 있는 파일 목록 select
			deleteFileList = archService.selectDeleteFileList(folderIdArr);
				
			// 폴더 내부에 파일이 있으면 파일과 폴더 동시에 삭제
			if (!deleteFileList.isEmpty() && deleteFileList != null) {
				subFileArr = new String[deleteFileList.size()];
				int i = 0;
				for (ArchiveFile f : deleteFileList) {
					subFileArr[i] = f.getFileNo() + "/" + f.getSize();
					i++;
						
					fileManager.deleteFile(f.getChangeName(), request, "/uploadFiles/archive");
				}
					
				result2 = archService.deleteFolder(folderIdArr, subFileArr);
			} else {
				// 폴더 내부에 파일이 없으면 폴더만 삭제
				result2 = archService.deleteFolder(folderIdArr, null);
			}
			
			folderIdArrLength = folderIdArr.length;
		}
		
		if (result1 + result2 < fileLength + folderIdArrLength) {
			throw new ArchiveException("파일 또는 폴더 삭제에 실패하엿습니다.");	
		}
		
		model.addAttribute("currentFolder", currentFolder);
		return "redirect:archive.arch?message=delete";
		
	}	

	/**
     * 새 폴더 등록
     */	
	@RequestMapping("addFolder.arch")
	public String addFolder(@ModelAttribute ArchiveFolder folder, 
							@RequestParam(value="currentFolder", required=false) Integer currentFolder, Model model) {
		
		int result = archService.addFolder(folder);
		
		if (result > 0) {
			model.addAttribute("currentFolder", currentFolder);
			return "redirect:archive.arch?message=success";
		} else {
			throw new ArchiveException("새 폴더 등록에 실패하엿습니다.");	
		}
		
	}
	
	/**
     * 폴더 이름 수정
     */	
	@RequestMapping("renameFolder.arch")
	@ResponseBody
	public String addFolder(@ModelAttribute ArchiveFolder folder) {
		
		int result = archService.renameFolder(folder);
		
		if (result > 0) {
			return "success";
		} else {
			throw new ArchiveException("폴더 이름 수정에 실패하엿습니다.");	
		}
	}
	
	/**
     * 폴더 이동
     */	
	@RequestMapping("moveFolder.arch")
	public String moveFolder(@RequestParam(value="targetFolder", required=false) Integer targetFolder, 
							 @RequestParam(value="fileNo", required=false) String[] fileArr, 
							 @RequestParam(value="folderId", required=false) int[] folderIdArr, HttpServletRequest request,
							 @RequestParam(value="currentFolder", required=false) Integer currentFolder, Model model) {
		
		// 파일의 폴더 변경
		int result1 = 0;
		ArrayList<ArchiveFile> fileList = new ArrayList<ArchiveFile>();
		if (fileArr != null && fileArr.length > 0) {
					
			for (String f : fileArr) {
				ArchiveFile file = new ArchiveFile();
				int fileNo = Integer.parseInt(f.split("/")[0]);
				file.setFileNo(fileNo);
				file.setFolderId(targetFolder);
				
				fileList.add(file);
			}
			
			result1 = archService.moveFile(fileList);
		} 
		
		// 폴더의  상위폴더 변경
		int result2 = 0;
		ArrayList<ArchiveFolder> folderList = new ArrayList<ArchiveFolder>();
		if (folderIdArr != null && folderIdArr.length > 0) {
			
			for (int folderId : folderIdArr) {
				ArchiveFolder folder = new ArchiveFolder();
				folder.setFolderId(folderId);
				folder.setUpperFolderId(targetFolder);
				
				folderList.add(folder);
			}
			
			result2 = archService.moveFolder(folderList);
		}
		
		if (result1 + result2 < fileList.size() + folderList.size()) {
			throw new ArchiveException("파일 또는 폴더 이동에 실패하엿습니다.");	
		}
		
		model.addAttribute("currentFolder", currentFolder);
		return "redirect:archive.arch?message=success";
	}
	
	
}
