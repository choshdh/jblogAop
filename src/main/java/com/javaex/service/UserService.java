package com.javaex.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.dao.BlogDao;
import com.javaex.dao.UserDao;
import com.javaex.vo.BlogVo;
import com.javaex.vo.UserVo;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	@Autowired
	BlogDao blogDao;
	
	@Transactional
	public int join(Map<String,String> map) {
		int userNo = userDao.userInsert(map);
		int result = blogDao.blogInsert(new BlogVo(userNo,"안녕하세요 " + map.get("userName") + "의 블로그에 오신것을 환영 합니다.","수지2.jpg"));
		return result;
	}
	
	public UserVo login(Map<String,String> map) {
		System.out.println("서비스 로그인 진입");
		return userDao.userSelect(map);
	}
	
	public boolean idCheck(String id) {
		boolean result;
		UserVo uvo = userDao.userIdCheck(id);
		if(uvo==null) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}
	
}
