package com.codeusgroup.codeus.common;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	@RequestMapping(value="/common/error{error_code}.do")
	public ModelAndView error(HttpServletRequest request, @PathVariable String error_code, ModelAndView mv) {
		String msg = (String)request.getAttribute("javax.servlet.error.message");
		
		switch (error_code) {
        	case "Throwable" : case "Exception" : msg = "예외가 발생하였습니다."; break;
	        case "400": msg = "잘못된 요청입니다."; break;
	        case "403": msg = "접근이 금지되었습니다."; break;
	        case "404": msg = "페이지를 찾을 수 없습니다."; break;
	        case "405": msg = "요청된 메소드가 허용되지 않습니다."; break;
	        case "500": msg = "서버에 오류가 발생하였습니다."; break;
	        case "503": msg = "서비스를 사용할 수 없습니다."; break;
	        default: msg = "알 수 없는 오류가 발생하였습니다."; 
        }
        
        logger.info("SATUS_CODE : " + request.getAttribute("javax.servlet.error.status_code"));
        logger.info("REQUEST_URI : " + request.getAttribute("javax.servlet.error.request_uri"));
        logger.info("EXCEPTION_TYPE : " + request.getAttribute("javax.servlet.error.exception_type"));
        logger.info("EXCEPTION : " + request.getAttribute("javax.servlet.error.exception"));
        logger.info("SERVLET_NAME : " + request.getAttribute("javax.servlet.error.servlet_name"));
        
        mv.addObject("error_code", error_code);
        mv.addObject("msg", msg);
		mv.setViewName("common/errorPage");
		
		return mv;
	}
}
