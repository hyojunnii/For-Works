package com.kh.forworks.attendance.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.forworks.attendance.dao.AttendanceDao;
import com.kh.forworks.attendance.vo.MonthWorkCntVo;
import com.kh.forworks.attendance.vo.TeamWorkVo;
import com.kh.forworks.attendance.vo.TodayWorkVo;
import com.kh.forworks.attendance.vo.WorkVo;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	
	private final AttendanceDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public AttendanceServiceImpl(SqlSessionTemplate sst, AttendanceDao dao) {
		this.sst = sst;
		this.dao = dao;
	}

	@Override
	public TodayWorkVo getTodayWork(String empNo) {
		TodayWorkVo wvo = dao.selectInOutTime(sst, empNo);
		
		int day = dao.selectDayWork(sst, empNo);
		int week = dao.selectWeekWork(sst, empNo);
		int month = dao.selectMonthWork(sst, empNo);
		
		if(wvo.getInTime() != null && wvo.getOutTime().equals("미등록")) {
			week += day;
			month += day;
		}
		
		wvo.setDayWork(day);
		wvo.setWeekWork(week); 
		wvo.setMonthWork(month);

		return wvo;
	}

	@Override
	public WorkVo getDayWorkInfo(Map<String, Object> map) {		
		return dao.selectDayWorkInfo(sst, map);
	}
	
	@Override
	public int insertInWork(Map map) {
		return dao.insertInTime(sst, map);
	}
	
	@Override
	public int updateInWork(Map map) {
		return dao.updateInTime(sst, map);
	}

	@Override
	@Transactional
	public int outWork(Map<String, Object> map) {
		
		int result1, result2, result3;
		
		result1 = dao.updateOutTime(sst, map);
		result2 = dao.updateOverTime(sst, map);
		result3 = dao.updateStatus(sst, map);
		
		return result1 * result2 * result3;
	}

	@Override
	public MonthWorkCntVo getMonthWorkCount(Map<String, Object> map) {
		MonthWorkCntVo mw = new MonthWorkCntVo();
		
		mw.setWorkCount(dao.selectWorkCnt(sst, map));
		mw.setLateCount(dao.selectLateCount(sst, map));
		mw.setEarlyoutCount(dao.selectEarlyoutCount(sst, map));
		double halfOff = (double)dao.selectHalfOffCount(sst, map);
		if(halfOff != 0) {
			halfOff = halfOff/2;
		}
		mw.setOffCount(dao.selectOffCount(sst, map) + halfOff);
		
		return mw;
	}

	@Override
	public List<WorkVo> getWorkList(Map<String, Object> map) {
		return dao.selectWorkList(sst, map);
	}

	@Override
	public TeamWorkVo getTeamTime(String empNo) {
		return dao.selectTeamTime(sst, empNo);
	}

}
