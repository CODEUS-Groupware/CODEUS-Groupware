package com.codeusgroup.codeus.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

import com.codeusgroup.codeus.member.model.vo.Member;

public class MemberEnterInterceptor implements AsyncHandlerInterceptor {
	
	private Logger logger = LoggerFactory.getLogger(MemberEnterInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			logger.debug("no login");
			
			request.getSession().setAttribute("msg", "로그인 후 이용 가능합니다.");
			response.sendRedirect(request.getContextPath());
			return false;
		}		
		
		return AsyncHandlerInterceptor.super.preHandle(request, response, handler);
	}
}
