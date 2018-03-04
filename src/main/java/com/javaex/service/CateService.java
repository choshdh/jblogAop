package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.dao.CateDao;
import com.javaex.vo.CateVo;

@Service
public class CateService {
	
	@Autowired
	CateDao cDao;
	
	public List<CateVo> cateList(String id) {
		return cDao.cateList(id);
	}

	@Transactional
	public CateVo cateAdd(CateVo cVo) {
		cDao.cateAdd(cVo);
		CateVo resultcVo = cDao.cateSelect(cVo.getCateNo());
		return resultcVo;
	}

	public int cateDel(int cateNo) {
		return cDao.cateDel(cateNo);
	}
}
