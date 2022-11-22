package com.kh.forworks.off.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.off.vo.OffTypeVo;
import com.kh.forworks.off.vo.OffVo;

@Repository
public class OffDaoImpl implements OffDao {

	@Override
	public int getTotalOff(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("offMapper.selectTotalOff", empNo);
	}

	@Override
	public int getUseOff(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("offMapper.selectUseOff", empNo);
	}

	@Override
	public int getUseHalfOff(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("offMapper.selectUseHalfOff", empNo);
	}

	@Override
	public List<OffVo> selectOffList(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectList("offMapper.selectOffList", map);
	}

	@Override
	public List<OffTypeVo> selectOffTypeList(SqlSessionTemplate sst) {
		return sst.selectList("offMapper.selectOffTypeList");
	}

	@Override
	public int insertOffForm(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.insert("offMapper.insertOffForm", map);
	}

	@Override
	public List<OffVo> selectDeptOffList(SqlSessionTemplate sst, Map<String, Object> map) {
		return sst.selectList("offMapper.selectDeptOffList", map);
	}

	@Override
	public int updateOffAccept(SqlSessionTemplate sst, String no) {
		return sst.update("offMapper.updateOffAccept", no);
	}
	
	@Override
	public int updateOffReject(SqlSessionTemplate sst, String no) {
		return sst.update("offMapper.updateOffReject", no);
	}

	@Override
	public int insertOffWork(SqlSessionTemplate sst, String no) {
		return sst.insert("attendanceMapper.insertOffWork", no);
	}

	@Override
	public String selectOffType(SqlSessionTemplate sst, String no) {
		return sst.selectOne("offMapper.selectOffType", no);
	}

	@Override
	public int insertHalfOffWork(SqlSessionTemplate sst, Map<String, String> map) {
		return sst.insert("attendanceMapper.insertHalfOffWork", map);
	}

}
