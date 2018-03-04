package com.javaex.api.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.CommentService;
import com.javaex.vo.UserVo;

@Controller
public class ApiCommentController {

	@Autowired
	CommentService cService;
	
	@ResponseBody
	@RequestMapping("/{id}/commentlist")
	public List<HashMap<String,Object>> commentList(@RequestParam ("postNo") int postNo){
		System.out.println("/{id}/commentlist 진입");
		return cService.commentList(postNo);
	}
	
	@ResponseBody
	@RequestMapping("/{id}/commentadd")
	public Map<String,String> commentAdd(@RequestParam Map<String,String> map, HttpSession session){ //postNo,cmtComment
		System.out.println("/{id}/commentadd 진입");
		String userNo = String.valueOf(((UserVo) session.getAttribute("authUser")).getUserNo()) ;
		map.put("userNo", userNo); //추가
		System.out.println(map);
		return cService.commentAdd(map);
	}
	
	@ResponseBody
	@RequestMapping("/{id}/commentdel")
	public int commentDel(@RequestParam Map<String,String> map, HttpSession session){ //postNo,cmtNo
		String userNo = String.valueOf(((UserVo) session.getAttribute("authUser")).getUserNo()) ;
		map.put("userNo", userNo);
		return cService.commentDel(map);
	}
	
}
