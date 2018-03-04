package com.javaex.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	SqlSession sqlSession;
	
	public int userInsert(Map<String,String> map) {
			sqlSession.insert("user.insert",map);
			System.out.println(map.get("userNo"));
			int userNo = Integer.parseInt(map.get("userNo"));
		return userNo;
	}
	
	public UserVo userSelect(Map<String,String> map) {
		System.out.println("dao 로그인 진입");
		return sqlSession.selectOne("user.select", map);
	}
	
	public UserVo userIdCheck(String id) {
		return sqlSession.selectOne("user.idCheck", id);
	}
	
	
}
