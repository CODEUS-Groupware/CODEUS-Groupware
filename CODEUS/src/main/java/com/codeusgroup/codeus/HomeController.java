package com.codeusgroup.codeus;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codeusgroup.codeus.empStatus.model.service.EmpStatusService;
import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;
import com.codeusgroup.codeus.member.model.vo.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private EmpStatusService esService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, HttpSession session, HttpServletRequest request, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		EmpStatus empStatus1 = getEmpStatus(session, request, model);
		
		model.addAttribute("empStatus1", empStatus1);
		
		model.addAttribute("serverTime", formattedDate);
		
		return "home";
	}
	
	public EmpStatus getEmpStatus(HttpSession session, HttpServletRequest request, Model model) {
		
		session = request.getSession();
		
		Member member = (Member)session.getAttribute("loginUser");
		
		String id = member.getmId();
		
		EmpStatus empStatus = new EmpStatus(0, null, null, null, null, null, id, null, null);
		
		//EmpStatus empStatus1 = esService.selectComTime(id);
		
		EmpStatus empStatus1 = esService.selectOffTime(id);

		
		return empStatus1;	
	}
}
