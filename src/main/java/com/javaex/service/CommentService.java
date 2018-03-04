package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CommentDao;

@Service
public class CommentService {
	
	@Autowired
	CommentDao cDao;
	
	public List<HashMap<String,Object>> commentList(int postNo) {
		return cDao.commentList(postNo);
	}

	public Map<String, String> commentAdd(Map<String, String> map) {
		int result = cDao.commentInsert(map);
		if(result == 1) {
			return map;
		}else {
			return null;			
		}
	}

	public int commentDel(Map<String, String> map) {
		return cDao.commentDel(map);
	}

}
