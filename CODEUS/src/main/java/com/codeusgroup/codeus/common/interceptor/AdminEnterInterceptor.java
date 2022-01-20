package com.codeusgroup.codeus.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

import com.codeusgroup.codeus.common.ForbiddenException;
import com.codeusgroup.codeus.member.model.vo.Member;

public class AdminEnterInterceptor implements AsyncHandlerInterceptor {
	
	private Logger logger = LoggerFactory.getLogger(AdminEnterInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		if (loginUser != null && loginUser.getManagerYn().equals("N")) {
			logger.debug("no admin");
			
			throw new ForbiddenException("관리자 외에는 접근이 불가능합니다.");
		}		
		
		return AsyncHandlerInterceptor.super.preHandle(request, response, handler);
	}
}
