package com.javaex.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BlogService;
import com.javaex.service.CateService;
import com.javaex.service.PostService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.UserVo;

@Controller
public class BlogController {
	
	@Autowired
	BlogService bService;
	
	@Autowired
	CateService cService;
	
	@Autowired
	PostService pService;

	//로그인 전
	//블로그 메인화면보기
	@RequestMapping("/{id}")
	public String myblog(@PathVariable String id, Model model) {
		System.out.println("블로그 메인 진입");
		System.out.println("요청 블로그 id : " + id);
		BlogVo bVo = bService.myblog(id);
		if(bVo==null) {
			return "blog/notExistBlog";
		}else {
			model.addAttribute("bVo", bVo);
			return "blog/blog-main";
		}
	}
	
	//팝업창 사용을 위해서 만들었는데 자꾸 팝업차단 걸려서 주석 처리
	/*@RequestMapping("/{id}/pop")
	public String pop() {
		return "blog/pop";
	}*/
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//로그인 후
	//블로그 관리 - 기본설정
	@RequestMapping("/{id}/admin/basic")
	public String adminbasic(@PathVariable String id, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("id/admin/basic 진입");
		return "blog/admin/blog-admin-basic";
	}
	
	//블로그 관리 - 카테고리
	@RequestMapping("/{id}/admin/category")
	public String admincategory(@PathVariable String id, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("id/admin/category 진입");
		return "blog/admin/blog-admin-cate";
	}
	
	//블로그 관리 - 포스트 쓰기
	@RequestMapping("/{id}/admin/write")
	public String adminwrite(@PathVariable String id, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("id/admin/write 진입");
		return "blog/admin/blog-admin-write";
	}
	
	//블로그 관리 - 포스트 등록
	@RequestMapping("/{id}/admin/postadd")
	public String postadd(@RequestParam Map<String,String> pVo, @PathVariable String id, HttpSession session, HttpServletRequest request, Model model) { //cateNo,postTitle,postContent
		System.out.println("id/admin/postadd 진입");
		
		int result = pService.postAdd(pVo);
		System.out.println("post 등록 처리 결과 : " + result);
		return "redirect:/{id}/admin/write";

	}
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//접근 유저 체크
	private String loginUserCheck(String id, HttpSession session, HttpServletRequest request, String page, Model model) {
		System.out.println("블로그 관리 페이지 접근 유저 체크 시작");
		UserVo loginUser =(UserVo) session.getAttribute("authUser");
		if(loginUser == null) { //로그인 한 사용자가 아니라면
			return "redirect:/user/loginform";
		}else if(!(loginUser.getId().equals(id))){ //로그인 사용자가 다른 사용자의 관리자 페이지에 접근시 강제 로그아웃 시키고 로그인 화면으로 이동
			ipcheck(request);
			session.invalidate();
			return "redirect:/user/loginform";
		}else {
			BlogVo bVo = bService.myblog(id);
			model.addAttribute("bVo", bVo);
			return "blog/admin/blog-admin-"+page;
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
