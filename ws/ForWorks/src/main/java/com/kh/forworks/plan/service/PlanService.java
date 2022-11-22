package com.kh.forworks.plan.service;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.kh.forworks.plan.dto.PlanDto;

public interface PlanService {
	
	public List<PlanDto> showSchedule() throws Exception;
	
	public int addSchedule(PlanDto dto) throws Exception;
	
	public int deleteSchedule(PlanDto dto) throws Exception;

}
