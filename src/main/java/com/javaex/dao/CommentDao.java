package com.javaex.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDao {

	@Autowired
	SqlSession ss;
	
	public List<HashMap<String,Object>> commentList(int postNo) {
		return ss.selectList(("comment.list"),postNo); //셀렉해오는 컬럼 중에 어떤것을 키값으로 사용할 것인지.
	}

	public int commentInsert (Map<String, String> map) {
		return ss.insert("comment.insert", map);
	}

	public int commentDel(Map<String, String> map) {
		return ss.delete("comment.delete", map);
	}

}
