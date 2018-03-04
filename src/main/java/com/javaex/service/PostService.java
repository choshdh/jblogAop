package com.javaex.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.PostDao;
import com.javaex.vo.PostVo;

@Service
public class PostService {

	@Autowired
	PostDao pDao;
	
	public int postAdd(Map<String,String> pVo) {
		return pDao.postAdd(pVo);
	}
	
	public List<PostVo> postList(String id){
		return pDao.postList(id);
	}
}
