package com.kh.forworks.planPop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.forworks.planPop.service.PlanPopService;
import com.kh.forworks.planPop.vo.PlanPopVo;


@Controller

//일정 캘린더 화면 보여주기
@RequestMapping("plan")
public class PlanPopController {
	
	private final PlanPopService ps;
	
	@Autowired
	public PlanPopController(PlanPopService ps) {
		this.ps = ps;
	}
		
	@GetMapping("planPop")
	public String calendar() {
		return "plan/planPop";
	}
	
	@PostMapping("planPop")
	public String planPop(PlanPopVo vo) {
		
		int result = ps.addPlan(vo);
		
		if(result == 1) {
			return "redirect:/";
		} else {
			return "redirect/errorPage";
		}		
	}
}	