package com.javaex.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.javaex.mongo.dao.MongoDao;
import com.javaex.mongo.vo.MongoVo;

@Component
@Aspect
public class AopJblog {
	
	@Autowired
	MongoDao mDao;

	@Around("within(com.javaex.service..*)")
	Object log(ProceedingJoinPoint joinPoint) throws Throwable { //맘대로 매개변수를 사용하면 Pointcut is malformed 라고 에러가 뜬다 존재하지 않는 기형 매개변수 방식이라는 뜻이다.
		System.out.println("Advice 함수  실행됨. joinPoint 실행 전");
		System.out.println("서비스 요청자 정보 로그 저장");
		
		//aop 사용시 request 가져오는법
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		String hostIp = request.getRemoteHost();
		String addrIP = request.getRemoteAddr();
		String localPort = String.valueOf(request.getLocalPort());
		String localName = request.getLocalName();
		String protocol = request.getProtocol();
		String scheme = request.getScheme();
		String contextPath = request.getContextPath();
		String uri = request.getRequestURI();
		
		MongoVo mVo = new MongoVo(hostIp, addrIP, localPort, localName, protocol, scheme, contextPath, uri);
		mDao.savelog(mVo);
		Object obj = null;
		try {
			obj = joinPoint.proceed();
		}finally {
			System.out.println("joinPoint 실행 후. Advice 종료됨.");
		}
		return obj;
	}
	
}
