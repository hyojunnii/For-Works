package com.kh.forworks.planPop.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.planPop.vo.PlanPopVo;

public interface PlanPopDao {
	
	//insertOne 일정추가
	int insertOne(SqlSessionTemplate sst, PlanPopVo vo);
	
	
	//update
	
	//delete

}
