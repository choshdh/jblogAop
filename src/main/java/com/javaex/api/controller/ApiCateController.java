package com.javaex.api.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.CateService;
import com.javaex.vo.CateVo;
import com.javaex.vo.UserVo;

@Controller
public class ApiCateController {

	@Autowired
	CateService cService;
	
	//카테고리 추가
	@ResponseBody
	@RequestMapping(value="/{id}/admin/cateadd" ,method = RequestMethod.POST)
	public CateVo cateAdd(@RequestBody CateVo cVo, @PathVariable String id, HttpSession session, HttpServletRequest request) {
		System.out.println("/{id}/admin/cateadd 진입");
		String checkResult = loginUserCheck(id, session, request);
		if(checkResult.equals("no")) {
			return null;
		}else {
			System.out.println(cVo);
			System.out.println(cVo.getClass());
			CateVo resultcVo = cService.cateAdd(cVo);
			return resultcVo;
		}
	}
	
	//카테고리 삭제
	@ResponseBody
	@RequestMapping(value="/{id}/admin/catedel" ,method = RequestMethod.POST)
	public int cateDel(@RequestBody int cateNo, @PathVariable String id, HttpSession session, HttpServletRequest request) {
		System.out.println("/{id}/admin/catedel 진입");
		String checkResult = loginUserCheck(id, session, request);
		if(checkResult.equals("no")) {
			return 0;
		}else {
			int result = cService.cateDel(cateNo);
			return result;
		}
	}
	
	//카테고리 리스트
	@ResponseBody
	@RequestMapping(value="/{id}/admin/catelist" ,method = RequestMethod.POST)
	public List<CateVo> cateList(@PathVariable String id){
		System.out.println("/{id}/admin/catelist 진입");
		List<CateVo> cList = cService.cateList(id);
		return cList; 
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
