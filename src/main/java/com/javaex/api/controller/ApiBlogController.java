package com.javaex.api.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.BlogService;
import com.javaex.vo.UserVo;

@Controller
public class ApiBlogController {

	@Autowired
	BlogService bService;
	
	@ResponseBody
	@RequestMapping("/{id}/admin/blogupdate")
	public int blogUpdate(@PathVariable String id, @RequestParam("blog-title") String blogTitle, HttpSession session, HttpServletRequest request) {
		System.out.println("/{id}/admin/blogupdate 진입");
		String checkResult = loginUserCheck(id, session, request);
		int result = 0;
		if(checkResult.equals("ok")) {
			UserVo loginUser = (UserVo) session.getAttribute("authUser");
			result = bService.blogUpdate(loginUser.getUserNo(),blogTitle);
		}

		return result;
	}
	
	//접근 유저 체크
	private String loginUserCheck(String id, HttpSession session, HttpServletRequest request) {
		System.out.println("블로그 관리 페이지 접근 유저 체크 시작");
		UserVo loginUser =(UserVo) session.getAttribute("authUser");
		if(loginUser == null) { //로그인 한 사용자가 아니라면
			return "no";
		}else if(!(loginUser.getId().equals(id))){ //로그인 사용자가 다른 사용자의 관리자 페이지에 접근시 강제 로그아웃 시키고 로그인 화면으로 이동
			ipcheck(request);
			session.invalidate();
			return "no";
		}else {
			return "ok";
		}
	}
	
	//접근 유저 아이피 확인
	private void ipcheck(HttpServletRequest request) {
		System.err.println("비정상적인 방법으로 타사용자 블로그 admin권한 진입발생");
		System.err.println("페이지를 요청한 ip 주소 (Host) : " + request.getRemoteHost());
		System.err.println("페이지를 요청한 ip 주소 (Addr) : " + request.getRemoteAddr());
		System.err.println("LocalPort : " + request.getLocalPort());
		System.err.println("LocalName : " + request.getLocalName());
		System.err.println("Protocol : " + request.getProtocol());
		System.err.println("Scheme : " + request.getScheme());
		System.err.println("ContextPath : " + request.getContextPath());
		System.err.println("URI : " + request.getRequestURI());
	}
}
