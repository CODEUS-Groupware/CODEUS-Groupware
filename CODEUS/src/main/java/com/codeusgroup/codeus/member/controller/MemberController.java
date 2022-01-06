package com.codeusgroup.codeus.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.codeusgroup.codeus.member.model.dao.MemberDAO;
import com.codeusgroup.codeus.member.model.exception.MemberException;
import com.codeusgroup.codeus.member.model.service.MemberService;
import com.codeusgroup.codeus.member.model.service.MemberServiceImpl;
import com.codeusgroup.codeus.member.model.vo.Member;

@SessionAttributes("loginUser")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	 
	
	@RequestMapping(value="login.me", method=RequestMethod.POST)
	public String login(Member m, Model model) {
		
		Member loginMember = mService.memberLogin(m); 
		
		String msg = null;
		if(loginMember != null && bcrypt.matches(m.getmPwd(), loginMember.getmPwd())) {
			if(loginMember.getStatus() == 0) {
				model.addAttribute("loginUser", loginMember);
	                return "redirect:home.do";
	            } else if (loginMember.getStatus() == 1){
	                msg = "1";
	            } else if (loginMember.getStatus() == 2) {
	                msg = "2";
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
	
	@RequestMapping("joinMemberView.me")
	public String joinMemberView() {
		return "joinMember";
	}
	
	@RequestMapping("insert.me")
	public String insertMember(@ModelAttribute Member m, HttpServletRequest request, HttpServletResponse response) {
		
		String encPwd = bcrypt.encode(m.getmPwd());
		m.setmPwd(encPwd);
		
		System.out.println(m);
		
		int result = mService.insertMember(m);
		
		if(result > 0) {
			return "redirect:/";
			
		} else {
			throw new MemberException("회원가입에 실패하였습니다");
		}
		
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
		Member searchMember = mService.idSearchMember(m);
		
		if(searchMember != null) {
			model.addAttribute("check", 0);
			model.addAttribute("id", searchMember.getmId());
		} else {
			model.addAttribute("check", 1);
		}
		
		System.out.println(searchMember);
		
		return "../../../index";
	}
	
	@RequestMapping("pwdSearch.me")
	public String pwdMailConfirm() {
		
		return "pwdMailConfirm";
	}
	 
	
}
	

