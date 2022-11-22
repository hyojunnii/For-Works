package com.kh.forworks.plan.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;



import com.kh.forworks.plan.dao.PlanDao;
import com.kh.forworks.plan.dto.PlanDto;
  
@Service
public class PlanServiceimpl implements PlanService {
	
	@Inject
	private PlanDao dao;
	
	@Override
	public List<PlanDto> showSchedule() throws Exception {
		
		
		
		return dao.showSchedule();
	}
	
	@Override
	public int addSchedule(PlanDto dto) throws Exception{

		
		return dao.addSchedule(dto);
	}
	
	@Override
	public int deleteSchedule(PlanDto dto) throws Exception{
		
		return dao.deleteSchedule(dto);
	}
	
}





	

