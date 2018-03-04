package com.javaex.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FileVo;

@Repository
public class LogoDao {

	@Autowired
	SqlSession ss;
	
	public String logoSelect(String id) {
		return ss.selectOne("logo.select", id);
	}

	public int logoFileInsert(FileVo fvo) {
		return ss.insert("logo.fileInsert", fvo);
	}
	
	public int logoChange(Map<String, Object> idAndFileSaveName) {
		return ss.update("logo.change", idAndFileSaveName);
	}

	
}
