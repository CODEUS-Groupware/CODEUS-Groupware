package com.codeusgroup.codeus.member.controller;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.GregorianCalendar;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.codeusgroup.codeus.member.model.exception.MemberException;
import com.codeusgroup.codeus.member.model.service.MemberService;
import com.codeusgroup.codeus.member.model.vo.Member;
import com.codeusgroup.codeus.myPage.model.service.MyPageService;

@SessionAttributes("loginUser")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private MyPageService mpService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	
	@RequestMapping(value="login.me", method=RequestMethod.POST)
	public String login(Member m, Model model) {
		
		Member loginMember = mService.memberLogin(m); 
		System.out.println(bcrypt.encode(m.getmPwd()));
		String msg = null;
		if(loginMember != null && bcrypt.matches(m.getmPwd(), loginMember.getmPwd())) {
			if(loginMember.getStatus() == 0) {
				model.addAttribute("loginUser", loginMember);
	            return "redirect:home.do";
	        } else if (loginMember.getStatus() == 1){
	        	msg = "1";
	        } else if (loginMember.getStatus() == 2) {
	        	msg = "2";
	        } else if (loginMember.getStatus() == 3) {
	        	msg = "3";
	        }
	     } else {
	    	 msg = "fail";
	     }
		
		model.addAttribute("msg", msg);
		System.out.println(loginMember);
			
		return "../../../index";
	}
	
	@RequestMapping("logout.me")
	public String logout(SessionStatus session) {
		session.setComplete();
		return "redirect:/";
	}
	
	@RequestMapping("myinfo.me")
	public String myInfo() {
		return "myInfo";
	}
	
	@RequestMapping("idSearchView.me")
	public String idSearchView() {
		return "idSearch";
	}
	
	@RequestMapping("idSearch.me")
	public String idSearchMember(Member m, Model model) {
		System.out.println(m);
		Member searchMember = mService.searchMember(m);
		
		if(searchMember != null) {
			model.addAttribute("check", 0);
			model.addAttribute("id", searchMember.getmId());
		} else {
			model.addAttribute("check", 1);
		}
		
		System.out.println(searchMember);
		
		return "../../../index";
	}
	
	@RequestMapping("pwdSearchView.me")
	public String pwdSearchView() {
		
		return "pwdSearchForm";
	}
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@ResponseBody
	@RequestMapping("sendMail.me")
	public String sendMail(@ModelAttribute Member m) {
		
		Member searchMember = mService.searchMember(m);
		
		if (searchMember != null) {
			String title = "[CODEUS] 인증 코드 발송";
			String content =  "<div style='width: 500px;'><p style='font-size: xx-large; font-weight: bold; color: purple'>CODEUS</p><hr><br></div>"
							+ "<div align='center' style='font-size: large; width: 500px; border: 1px solid lightgray; color: black;'>"
							+ "<p style='font-size: x-large; font-weight: bold; color: black;'>[CODEUS] 인증 코드 발송</p><br>"
						    + "<p style='color: black;'>" + m.getmName() + "님 안녕하세요.</p>"
						    + "<p style='color: black;'>비밀번호 찾기를 위한 인증 코드입니다.</p><p style='color: black;'>올바른 인증 코드 입력시 비밀번호 변경이 가능합니다.</p>";
			
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
				messageHelper.setTo(new InternetAddress(m.getEmail(), m.getmName(), "UTF-8"));
				
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
		} else {
			return "notfound";
		}
		
	}
	
	@RequestMapping("pwdUpdate.me")
	public String updatePwd(@ModelAttribute Member m, Model model) {

		String encPwd = bcrypt.encode(m.getmPwd());
		m.setmPwd(encPwd);
		
		int result = mpService.updatePwd(m);
		
		if (result > 0) {
			model.addAttribute("msg", "success");
			return "../../../index";
		} else {
			throw new MemberException("비밀번호 수정에 실패하였습니다.");
		}
	}
	
	
	@RequestMapping("joinForm.me")
	public String joinForm() {
		return "joinForm";
	}
	
	@RequestMapping("join.me")
	public String join(@ModelAttribute Member m, @RequestParam("inputBirthDate") String inputBirthDate, 
					   @RequestParam(value="post", required=false) String post,
					   @RequestParam(value="address1", required=false) String address1, 
					   @RequestParam(value="address2", required=false) String address2, Model model) {
		
		if (post == "" && address1 == "" && address2 == "") {
			m.setAddress(null);
		} else {
			m.setAddress(post + "/" + address1 + "/" + address2);
		}
		
		if(!inputBirthDate.equals("")) {
			String[] eSplit = inputBirthDate.split("-");
			int eYear = Integer.parseInt(eSplit[0]);
			int eMonth = Integer.parseInt(eSplit[1]) - 1;
			int eDate = Integer.parseInt(eSplit[2]);
			Date birthDate = new Date(new GregorianCalendar(eYear, eMonth, eDate).getTimeInMillis());	
			m.setBirthDate(birthDate);
		}
		
		String encPwd = bcrypt.encode(m.getmPwd());
		m.setmPwd(encPwd);
		
		int result = mService.joinMember(m);
		
		if(result > 0) {
			model.addAttribute("msg", "joinSuccess");
			return "../../../index";
		} else {
			throw new MemberException("회원가입에 실패하였습니다");
		}
	}
	
	@RequestMapping("dupId.me")
	@ResponseBody
	public String duplicateId(@RequestParam("inputId") String inputId) {
		
		String result = mService.duplicateId(inputId) == 0 ? "noUsedId" : "usedId";
		
		return result;
	}
	
	// 회원가입시 이메일 인증
	@ResponseBody
	@RequestMapping("sendJoinMail.me")
	public String sendJoinMail(@RequestParam("email") String email) {
		
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
	
}
	

