package com.javaex.api.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.PostService;
import com.javaex.vo.PostVo;

@Controller
public class ApiPostController {
	
	@Autowired
	PostService pService;

	@ResponseBody
	@RequestMapping(value="/{id}/admin/postlist" ,method = RequestMethod.POST)
	public List<PostVo> postList(@PathVariable String id, HttpSession session){
		System.out.println("/{id}/admin/postlist 진입");
		List<PostVo> pList = pService.postList(id);
		return pList; 
	}
}
