package com.kh.forworks.planPop.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.planPop.vo.PlanPopVo;

@Repository
public class PlanPopDaoImpl implements PlanPopDao {

	@Override
	public int insertOne(SqlSessionTemplate sst, PlanPopVo vo) {
		return sst.insert("planPop.addPlan", vo);
		}

	
}
