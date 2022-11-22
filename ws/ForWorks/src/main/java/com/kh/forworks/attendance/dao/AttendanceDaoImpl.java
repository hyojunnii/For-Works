package com.kh.forworks.attendance.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.attendance.vo.TeamWorkVo;
import com.kh.forworks.attendance.vo.TodayWorkVo;
import com.kh.forworks.attendance.vo.WorkVo;

@Repository
public class AttendanceDaoImpl implements AttendanceDao {

	@Override
	public TodayWorkVo selectInOutTime(SqlSessionTemplate sst, String empNo) {
		if(sst.selectOne("attendanceMapper.selectInOutTime", empNo) == null) {
			TodayWorkVo vo = new TodayWorkVo();
			vo.setInTime("미등록");
			vo.setOutTime("미등록");
			return vo;
		} else {			
			return sst.selectOne("attendanceMapper.selectInOutTime", empNo);
		}
	}

	@Override
	public int selectDayWork(SqlSessionTemplate sst, String empNo) {	
		if(sst.selectOne("attendanceMapper.selectDayWork", empNo) == null) {
			return 0;
		} else {			
			return sst.selectOne("attendanceMapper.selectDayWork", empNo);			
		}
	}
	
	@Override
	public int selectWeekWork(SqlSessionTemplate sst, String empNo) {				
		if(sst.selectOne("attendanceMapper.selectWeekWork", empNo) == null) {
			return 0;
		} else {			
			return sst.selectOne("attendanceMapper.selectWeekWork", empNo);		
		}
	}
	
	@Override
	public int selectMonthWork(SqlSessionTemplate sst, String empNo) {	
		if(sst.selectOne("attendanceMapper.selectMonthWork", empNo) == null) {
			return 0;
		} else {			
			return sst.selectOne("attendanceMapper.selectMonthWork", empNo);		
		}
	}

	@Override
	public int insertInTime(SqlSessionTemplate sst, Map map) {
		return sst.insert("attendanceMapper.insertInTime", map);
	}
	
	@Override
	public int updateInTime(SqlSessionTemplate sst, Map map) {
		return sst.update("attendanceMapper.updateInTime", map);
	}

	@Override
	public WorkVo selectDayWorkInfo(SqlSessionTemplate sst, Map<String, Object> map) {
		if(sst.selectOne("attendanceMapper.selectDayWorkInfo", map) == null) {
			return new WorkVo();
		} else {			
			return sst.selectOne("attendanceMapper.selectDayWorkInfo", map);
		}
	}

	@Override
	public int updateOutTime(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.update("attendanceMapper.updateOutTime", map);
	}

	@Override
	public int updateOverTime(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.update("attendanceMapper.updateOverTime", map);
	}

	@Override
	public int updateStatus(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.update("attendanceMapper.updateStatus", map);
	}

	@Override
	public int selectWorkCnt(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectOne("attendanceMapper.selectWorkCount", map);
	}

	@Override
	public int selectOffCount(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectOne("attendanceMapper.selectOffCount", map);
	}

	@Override
	public int selectHalfOffCount(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectOne("attendanceMapper.selectHalfOffCount", map);
	}

	@Override
	public int selectEarlyoutCount(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectOne("attendanceMapper.selectEarlyoutCount", map);
	}

	@Override
	public int selectLateCount(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectOne("attendanceMapper.selectLateCount", map);
	}

	@Override
	public List<WorkVo> selectWorkList(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectList("attendanceMapper.selectWorkList", map);
	}

	@Override
	public TeamWorkVo selectTeamTime(SqlSessionTemplate sst, String empNo) {
		if(sst.selectOne("attendanceMapper.selectTeamTime", empNo) == null) {
			return new TeamWorkVo(); 
		} else {			
			return sst.selectOne("attendanceMapper.selectTeamTime", empNo);
		}
	}

}
