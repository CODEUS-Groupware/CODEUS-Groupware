package com.codeusgroup.codeus.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

import com.codeusgroup.codeus.member.model.vo.Member;

public class AdminEnterInterceptor implements AsyncHandlerInterceptor {
	
	private Logger logger = LoggerFactory.getLogger(AdminEnterInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		if (loginUser == null || loginUser.getManagerYn().equals("N")) {
			logger.debug("no admin");
			
			// forbidden 에러 일으키기 또는 index로 가서 알럿창
//			request.setAttribute("msg", "로그인 후 이용하세요");
//			request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
//			return false;
		}		
		
		return AsyncHandlerInterceptor.super.preHandle(request, response, handler);
	}
}
