package com.codeusgroup.codeus.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component // 프레임워크가 객체 생성할 수 있도록 어노테이션(Service, Controller, Repository 성질을 가지지 않음)
@Aspect
public class LoggerAspect {
	
	private Logger logger = LoggerFactory.getLogger(LoggerAspect.class);
	
	@Around("execution(* com.codeusgroup.codeus..*(..))") 
	public Object loggerAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		Signature signature = joinPoint.getSignature();
		logger.debug("signature : " + signature); // 실행하고 있는 메소드 정보가 출력됨
		
		String type = signature.getDeclaringTypeName(); // 메소드가 속해있는 클래스의 이름
		String methodName = signature.getName(); // 메소드 이름
		logger.debug("type : " + type);
		logger.debug("methodName : " + methodName);
		
		String componentName = null;
		if(type.indexOf("Controller") > -1) { // "Controller"를 포함하지 않으면 -1을 반환
			componentName = "Controller  \t:  ";
		} else if(type.indexOf("Service") > - 1) {
			componentName = "ServiceImpl  \t:  ";
		} else if(type.indexOf("DAO") > -1) {
			componentName = "DAO  \t\t:  ";
		}
		
		logger.debug("[Before] " + componentName + type + "." + methodName + "()");
		
		Object obj = joinPoint.proceed(); // try-catch 대신 throws로
		
		logger.debug("[After] " + componentName + type + "." + methodName + "()");
		
		return obj;
	}
}
