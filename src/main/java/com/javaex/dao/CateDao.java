package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.CateVo;

@Repository
public class CateDao {

	@Autowired
	SqlSession ss;
	
	public List<CateVo> cateList(String id) {
		return ss.selectList("cate.list",id);
	}

	public int cateAdd(CateVo cVo) {
		return ss.insert("cate.add",cVo);
	}

	public CateVo cateSelect(int cateNo) {
		return ss.selectOne("cate.select", cateNo);
	}

	public int cateDel(int cateNo) {
		return ss.delete("cate.del", cateNo);
	}
}
