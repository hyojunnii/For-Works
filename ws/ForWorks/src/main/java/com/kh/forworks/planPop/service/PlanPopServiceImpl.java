package com.kh.forworks.planPop.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.planPop.dao.PlanPopDao;
import com.kh.forworks.planPop.vo.PlanPopVo;

@Service
public class PlanPopServiceImpl implements PlanPopService {
	
	
	private final SqlSessionTemplate sst;
	
	private final PlanPopDao dao;
	
	@Autowired
	public PlanPopServiceImpl(SqlSessionTemplate sst, PlanPopDao dao) {
		this.sst = sst;
		this.dao = dao;
	}

	@Override
	public int addPlan(PlanPopVo vo) {
		//커넥션 준비
		//SQL
		
		return dao.insertOne(sst, vo);
	}

}
