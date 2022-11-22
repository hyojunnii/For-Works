package com.kh.forworks.plan.dao;

import java.util.List;

import com.kh.forworks.plan.dto.PlanDto;

public interface PlanDao {
	
	
	public List<PlanDto> showSchedule() throws Exception;
	
	public int addSchedule(PlanDto dto) throws Exception;
	
	public int deleteSchedule(PlanDto dto)throws Exception;
}
