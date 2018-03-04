package com.javaex.service;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BlogDao;
import com.javaex.vo.BlogVo;

@Service
public class BlogService {

	@Autowired
	BlogDao bDao;
	
	public int blogInsert(BlogVo bvo) {
		return bDao.blogInsert(bvo);
	}

	public BlogVo myblog(String id) {
		return bDao.blogSelect(id);
		
	}

	public int blogUpdate(int userNo, String blogTitle) {
		Map<String,Object> userNoAndBlogTitle = new HashMap<String, Object>();
		userNoAndBlogTitle.put("userNo", userNo);
		userNoAndBlogTitle.put("blogTitle", blogTitle);
		return bDao.blogUpdate(userNoAndBlogTitle);
	}

}
