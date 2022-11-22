package com.kh.forworks.attendance.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.forworks.DateFunction;
import com.kh.forworks.attendance.service.AttendanceService;
import com.kh.forworks.attendance.vo.MonthWorkCntVo;
import com.kh.forworks.attendance.vo.TeamWorkVo;
import com.kh.forworks.attendance.vo.TodayWorkVo;
import com.kh.forworks.attendance.vo.WorkVo;
import com.kh.forworks.member.vo.MemberVo;

@Controller
@RequestMapping("att/")
public class AttendanceController {
	
	private final AttendanceService service;
	
	@Autowired
	public AttendanceController(AttendanceService service) {
		this.service = service;
	}

	@GetMapping("day")
	public String dayAtt(Model model, HttpSession session) {

		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		String day = DateFunction.getToday();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("day", day);
				
		TodayWorkVo workTime = service.getTodayWork(empNo);
		WorkVo work = service.getDayWorkInfo(map);
		TeamWorkVo team = service.getTeamTime(empNo);
		
		Map<String, Integer> proBar = new HashMap<String, Integer>();
		if(team.getDoDayTime() != 0) {
			proBar.put("monthBar", (int)(workTime.getMonthWork()/team.getDoMonthTime()*100));
			proBar.put("weekBar", (int)(workTime.getWeekWork()/team.getDoWeekTime()*100));
			proBar.put("dayBar", (int)(workTime.getDayWork()/team.getDoDayTime()*100));			
		}
		
		model.addAttribute("workTime", workTime);
		model.addAttribute("work", work);
		model.addAttribute("team", team);
		model.addAttribute("today", day);
		model.addAttribute("proBar", proBar);
		
		return "attendance/dayAttendance";
	}
	
	@GetMapping("month")
	public String monthAtt(Model model) {
		return "attendance/monthAttendance";
	}
	
	@PostMapping("month")
	@ResponseBody
	public List<WorkVo> MonthWork(String month, HttpSession session) {

		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		
		month = DateFunction.monthForm(month);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("month", month);
		
		List<WorkVo> workList = service.getWorkList(map);
		
		return workList;
	}
	
	@PostMapping("monthCnt")
	@ResponseBody
	public MonthWorkCntVo MonthCnt(String month, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		month = DateFunction.monthForm(month);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("month", month);
		
		MonthWorkCntVo monthCnt = service.getMonthWorkCount(map); 
		monthCnt.setMonth(month);
		
		return monthCnt;
	}
	
	@GetMapping("goWork/{no}")
	public String goWork(@PathVariable int no, HttpSession session) {
				        
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		
		int result;		
		if(no != 0) {
			//반차 일때
			map.put("no", no);
			result = service.updateInWork(map);
		} else {
			String day = DateFunction.getToday();
			map.put("day", day);
			result = service.insertInWork(map);
		}
		
		if(result == 1) {
			return "redirect:/att/day";			
		} else {
			return "error/errorPage";
		}
	}
	
	@GetMapping("outWork/{no}")
	public String outWork(@PathVariable int no, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("empNo", empNo);
		
		int result = service.outWork(map);
		
		if(result == 1) {
			return "redirect:/att/day";			
		} else {
			return "error/errorPage";
		}
	}
	
	@PostMapping("dayWorkInfo")
	@ResponseBody
	public WorkVo dayWorkInfo(String date, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("day", date);
		
		WorkVo work = service.getDayWorkInfo(map);
		
		return work;
	}
	
}
