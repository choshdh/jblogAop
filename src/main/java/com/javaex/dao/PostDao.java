package com.javaex.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.PostVo;

@Repository
public class PostDao {

	@Autowired
	SqlSession ss;
	
	public int postAdd(Map<String,String> pVo) {
		return ss.insert("post.add", pVo);
	}

	public List<PostVo> postList(String id) {
		return ss.selectList("post.list", id);
	}
}
