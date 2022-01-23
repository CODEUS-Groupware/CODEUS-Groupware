package com.codeusgroup.codeus.myPage.controller;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.codeusgroup.codeus.common.FileManager;
import com.codeusgroup.codeus.member.model.service.MemberService;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.codeusgroup.codeus.myPage.model.exception.MyPageException;
import com.codeusgroup.codeus.myPage.model.service.MyPageService;
import com.codeusgroup.codeus.myPage.model.vo.Scrap;

@SessionAttributes("loginUser") 
@Controller
public class MyPageController {
	
	@Autowired
	private MyPageService mpService;
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping("myInfo.mp")
	public String myInfoView(@RequestParam(value="message", required=false) String message, Model model) {
		
		model.addAttribute("message", message);
		
		return "myInfo";
	}
	
	@RequestMapping("mupdateView.mp")
	public String myInfoUpdateView() {
		return "myInfoUpdateForm";
	}
	
	@ResponseBody
	@RequestMapping("sendMail.mp")
	public String sendMail(@RequestParam("email") String email) {
		
		String title = "[CODEUS] 인증 코드 발송";
		String content =  "<div style='width: 500px;'><p style='font-size: xx-large; font-weight: bold; color: purple'>CODEUS</p><hr><br></div>"
						+ "<div align='center' style='font-size: large; width: 500px; border: 1px solid lightgray; color: black;'>"
						+ "<p style='font-size: x-large; font-weight: bold; color: black;'>[CODEUS] 인증 코드 발송</p><br>"
					    + "<p style='color: black;'>안녕하세요. 코드어스입니다.</p>"
					    + "<p style='color: black;'>유효 메일 확인을 위한 인증 코드입니다.</p>";
		
		String sender = "hobbyist1125@gmail.com";
		
        String[] str = {"#", "!", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
                "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
        String newCode = new String();

        for (int x = 0; x < 10; x++) {
            int random = (int) (Math.random() * str.length);
            newCode += str[random];
        }
        
        content += "<p style='color: black;'> 인증 코드 : " + newCode.trim() + "</p><br></div>";
		

		try {
			MimeMessage message = javaMailSender.createMimeMessage();
			System.out.println(javaMailSender);
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 제목
			messageHelper.setSubject(title);
			// 내용
			messageHelper.setText(content, true);
			// From
			messageHelper.setFrom(new InternetAddress(sender, "코드어스", "UTF-8"));
			// To
			messageHelper.setTo(new InternetAddress(email, "", "UTF-8"));
			
			// 메일 전송
			javaMailSender.send(message);
			
			return newCode;
			
		} catch (MessagingException e) {
			e.printStackTrace();
			return "fail";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "fail";
		}
		
	}
	
	@RequestMapping("memberUpdate.mp")
	public String updateMyInfo(@ModelAttribute Member member, 
								@RequestParam("inputBirthDate") String inputBirthDate,
								@RequestParam(value="post", required=false) String post,
								@RequestParam(value="address1", required=false) String address1, 
								@RequestParam(value="address2", required=false) String address2,
								@RequestParam("reloadImg") MultipartFile reloadImg, 
								HttpServletRequest request, Model model) {
		
		if(!inputBirthDate.equals("")) {
			String[] eSplit = inputBirthDate.split("-");
			int eYear = Integer.parseInt(eSplit[0]);
			int eMonth = Integer.parseInt(eSplit[1]) - 1;
			int eDate = Integer.parseInt(eSplit[2]);
			Date birthDate = new Date(new GregorianCalendar(eYear, eMonth, eDate).getTimeInMillis());	
			member.setBirthDate(birthDate);
		}
		
		member.setAddress(post + "/" + address1 + "/" + address2);
		System.out.println(member);
		
		if (reloadImg != null && !reloadImg.isEmpty()) { // 수정할 파일 존재
			
			// 수정할 파일 존재 + 기존 파일 존재 = 기존 파일 삭제
			if (member.getImgChangeName() != null) {
				 fileManager.deleteFile(member.getImgOriginName(), request, "/uploadFiles");
			}
			
			String renameFileName =  fileManager.saveFile(reloadImg, request, "/uploadFiles");
			
			if (renameFileName != null) {
				member.setImgOriginName(reloadImg.getOriginalFilename());
				member.setImgChangeName(renameFileName);
			}
		}
		
		int result = mpService.updateMember(member);
		
		if (result > 0) {
			Member loginMember = mService.memberLogin(member); 
			model.addAttribute("loginUser", loginMember);
			return "redirect:myInfo.mp?message=success";
		} else {
			throw new MyPageException("회원 정보 수정에 실패하였습니다.");
		}
		
	}
	
	@RequestMapping("pwdupdateView.mp")
	public String pwdUpdateView() {
		return "pwdUpdateForm";
	}
	
	@RequestMapping("pwdpdate.mp")
	public String updatePassword(@RequestParam("originPwd") String originPwd, 
								@RequestParam("mPwd") String mPwd, Model model) {
		
		Member m = (Member)model.getAttribute("loginUser");
		
		if (bcrypt.matches(originPwd, m.getmPwd())) {
			String encPwd = bcrypt.encode(mPwd);
			m.setmPwd(encPwd);
			
			int result = mpService.updatePwd(m);
			
			if (result > 0) {
				model.addAttribute("loginUser", m);
				return "redirect:myInfo.mp?message=success";
			} else {
				throw new MyPageException("비밀번호 정보 수정에 실패하였습니다.");
			}
			
		} else {
			model.addAttribute("message", "fail");
			return "pwdUpdateForm";
		}
		
	}
	
	@RequestMapping("scrapList.mp")
	public String selectScrapList(@RequestParam(value="message", required=false) String message, Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		String mId = loginUser.getmId();
		System.out.println(mId);
		
		List<Scrap> sList = mpService.selectScrapList(mId);
		
		if (sList != null) {
			
			model.addAttribute("sList", sList);
			model.addAttribute("message", message);
			
			return "scrapList";
			
		} else {
			throw new MyPageException("스크랩 글 목록 조회에 실패하였습니다.");
		}
		
		
	}	

	@RequestMapping("scrapDelete.mp")
	public String deleteScrap(@RequestParam("bNum") int[] bNumArr,  Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		String mId = loginUser.getmId();
		
		ArrayList<Scrap> deleteList = new ArrayList<Scrap>();
		
		for (int bNum : bNumArr) {
			Scrap s = new Scrap();
			s.setbNum(bNum);
			s.setmId(mId);
			
			deleteList.add(s);
		}
		
		int result = mpService.deleteScrap(deleteList);
		
		if (result >= deleteList.size()) {
			return "redirect:scrapList.mp?message=delete";
		} else {
			throw new MyPageException("스크랩 해제에 실패하였습니다.");
		}
		
	}	
	
	
}
