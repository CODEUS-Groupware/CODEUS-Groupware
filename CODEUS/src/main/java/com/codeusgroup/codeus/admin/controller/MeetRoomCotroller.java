package com.codeusgroup.codeus.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.codeusgroup.codeus.admin.model.exception.AdminException;
import com.codeusgroup.codeus.admin.model.service.MeetRoomService;
import com.codeusgroup.codeus.common.FileManager;
import com.codeusgroup.codeus.meetingResrv.model.vo.MeetingRoom;

@Controller
public class MeetRoomCotroller {
	
	@Autowired
	private MeetRoomService meetService;
	
	@Autowired
	private FileManager fileManager;
	
    /**
     * 회의실 목록 조회
     */
	@RequestMapping("admin/meetList.ad")
	public String meetRoomList(@RequestParam(value="message", required=false) String message, 
								Model model) {
		
		List<MeetingRoom> meetList = meetService.selectMeetRoomList();
		
		if (meetList != null) {
			model.addAttribute("meetList", meetList);
			model.addAttribute("message", message);
			return "meetRoomList";
		} else {
			throw new AdminException("회의실 등록에 실패하였습니다.");
		}
	}
	
    /**
     * 회의실 등록
     */
	@RequestMapping("admin/meetinsert.ad")
	public String insertMeetRoom(@ModelAttribute MeetingRoom meetRoom, 
								 @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
		
		String renameFileName = null;
		if (uploadFile != null && !uploadFile.isEmpty()) { // 업로드할 파일 존재
			
			renameFileName = fileManager.saveFile(uploadFile, request, "/uploadFiles");
			
			if (renameFileName != null) {
				meetRoom.setImg_origin_name(uploadFile.getOriginalFilename());
				meetRoom.setImg_change_name(renameFileName);
			}
		}
		
		int result = meetService.insertMeetRoom(meetRoom);
		
		if (result <= 0) {
			if (renameFileName != null) { // 등록 실패시 저장된 파일도 삭제
				 fileManager.deleteFile(renameFileName, request, "/uploadFiles");
			}
			throw new AdminException("회의실 등록에 실패하였습니다.");
		}
		
		return "redirect:meetList.ad?message=success";
	}

	
	
    /**
     * 회의실 상세
     */
	@RequestMapping("admin/meetdetail.ad")
	public String meetRoomDetail(@RequestParam("meet_no") int meet_no, 
			                    @RequestParam(value="message", required=false) String message, Model model) {
		
		MeetingRoom meetRoom = meetService.selectMeetRoom(meet_no);
		
		if (meetRoom != null) {
			model.addAttribute("meetRoom", meetRoom);
			model.addAttribute("message", message);
			return "meetRoomDetail";
		} else {
			throw new AdminException("회의실 상세 보기에 실패하였습니다.");
		}
	}
	
    /**
     * 회의실 수정
     */
	@RequestMapping("admin/meetupdate.ad")
	public String updateMeetRoom(@ModelAttribute MeetingRoom meetRoom, @RequestParam("reloadFile") MultipartFile reloadFile, 
								HttpServletRequest request) {
		
		if (reloadFile != null && !reloadFile.isEmpty()) { // 수정할 파일 존재
			
			// 수정할 파일 존재 + 기존 파일 존재 = 기존 파일 삭제
			if (meetRoom.getImg_change_name() != null) {
				 fileManager.deleteFile(meetRoom.getImg_origin_name(), request, "/uploadFiles");
			}
			
			String renameFileName =  fileManager.saveFile(reloadFile, request, "/uploadFiles");
			
			if (renameFileName != null) {
				meetRoom.setImg_origin_name(reloadFile.getOriginalFilename());
				meetRoom.setImg_change_name(renameFileName);
			}
		}
		
		int result = meetService.updateMeetRoom(meetRoom);
		
		if (result <= 0) {
			throw new AdminException("회의실 수정에 실패하였습니다.");
		}
		
		return "redirect:meetdetail.ad?meet_no=" + meetRoom.getMeet_no() + "&message=success";
	}
	
    /**
     * 회의실 삭제
     */
	@RequestMapping("admin/meetdelete.ad")
	public String deleteMeetRoom(@RequestParam("meet_no") int meet_no, 
								 @RequestParam("img_change_name") String img_change_name, 
								 Model model, HttpServletRequest request) {
		
		int result = meetService.deleteMeetRoom(meet_no);
		
		if (result > 0) {
			// 회의실 삭제시 등록된 파일도 삭제
			if (!img_change_name.equals("")) {
				fileManager.deleteFile(img_change_name, request, "/uploadFiles");
			}
						
			return "redirect:meetList.ad?message=d";
			
		} else {
			throw new AdminException("회의실 삭제에 실패하였습니다.");
		}
		
	}

}
