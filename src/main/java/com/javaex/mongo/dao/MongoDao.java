package com.javaex.mongo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

import com.javaex.mongo.vo.MongoVo;

@Component
public class MongoDao {

	@Autowired
	private MongoTemplate mongoTemplate;

	public void savelog(MongoVo mVo) {
		mongoTemplate.save(mVo, "jblog");
	}
	
}
