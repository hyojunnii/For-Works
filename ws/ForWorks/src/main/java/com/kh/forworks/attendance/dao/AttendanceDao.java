package com.kh.forworks.attendance.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.attendance.vo.TeamWorkVo;
import com.kh.forworks.attendance.vo.TodayWorkVo;
import com.kh.forworks.attendance.vo.WorkVo;

public interface AttendanceDao {

	TodayWorkVo selectInOutTime(SqlSessionTemplate sst, String empNo);
	int selectDayWork(SqlSessionTemplate sst, String empNo);
	int selectWeekWork(SqlSessionTemplate sst, String empNo);
	int selectMonthWork(SqlSessionTemplate sst, String empNo);
	
	int insertInTime(SqlSessionTemplate sst, Map map);
	int updateInTime(SqlSessionTemplate sst, Map map);
	int updateOutTime(SqlSessionTemplate sst, Map<String, Object> map);
	int updateOverTime(SqlSessionTemplate sst, Map<String, Object> map);
	int updateStatus(SqlSessionTemplate sst, Map<String, Object> map);
	
	WorkVo selectDayWorkInfo(SqlSessionTemplate sst, Map<String, Object> map);
	int selectWorkCnt(SqlSessionTemplate sst, Map<String, Object> map);
	int selectOffCount(SqlSessionTemplate sst, Map<String, Object> map);
	int selectHalfOffCount(SqlSessionTemplate sst, Map<String, Object> map);
	int selectEarlyoutCount(SqlSessionTemplate sst, Map<String, Object> map);
	int selectLateCount(SqlSessionTemplate sst, Map<String, Object> map);
	List<WorkVo> selectWorkList(SqlSessionTemplate sst, Map<String, Object> map);
	TeamWorkVo selectTeamTime(SqlSessionTemplate sst, String empNo);
	

}
