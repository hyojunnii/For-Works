package com.kh.forworks.attendance.service;

import java.util.List;
import java.util.Map;

import com.kh.forworks.attendance.vo.MonthWorkCntVo;
import com.kh.forworks.attendance.vo.TeamWorkVo;
import com.kh.forworks.attendance.vo.TodayWorkVo;
import com.kh.forworks.attendance.vo.WorkVo;

public interface AttendanceService {

	TodayWorkVo getTodayWork(String empNo);
	WorkVo getDayWorkInfo(Map<String, Object> map);

	int insertInWork(Map map);
	int updateInWork(Map map);
	int outWork(Map<String, Object> map);
	
	MonthWorkCntVo getMonthWorkCount(Map<String, Object> map);
	List<WorkVo> getWorkList(Map<String, Object> map);
	TeamWorkVo getTeamTime(String empNo);

}
