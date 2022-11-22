package com.kh.forworks.off.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.forworks.off.dao.OffDao;
import com.kh.forworks.off.vo.OffCntVo;
import com.kh.forworks.off.vo.OffTypeVo;
import com.kh.forworks.off.vo.OffVo;

@Service
public class OffServiceImpl implements OffService {

	private final OffDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public OffServiceImpl(SqlSessionTemplate sst, OffDao dao) {
		this.sst = sst;
		this.dao = dao;
	}

	@Override
	public OffCntVo getOffCnt(String empNo) {
		
		OffCntVo vo = new OffCntVo();
		vo.setTotalOff(dao.getTotalOff(sst, empNo));
		vo.setUseOff(dao.getUseOff(sst, empNo));
		vo.addHalfOff(dao.getUseHalfOff(sst, empNo));
		vo.setLeftOff();
		
		return vo;
	}

	@Override
	public List<OffVo> getOffList(Map<String, Object> map) {
		return dao.selectOffList(sst, map);
	}

	@Override
	public List<OffTypeVo> getOffTypeList() {
		return dao.selectOffTypeList(sst);
	}

	@Override
	public int submitOff(Map<String, Object> map) {
		return dao.insertOffForm(sst, map);
	}

	@Override
	public List<OffVo> getDeptOffList(Map<String, Object> map) {
		return dao.selectDeptOffList(sst, map);
	}

	@Override
	@Transactional
	public int setOffAccept(String[] no) {
		int result = 1;
		for(int i=0; i<no.length; i++) {
			result *= dao.updateOffAccept(sst, no[i]);
			String type = dao.selectOffType(sst, no[i]);
			if(type == null) {
				System.out.println("error 발생");
				return -1;
			} else if(type.equals("2") || type.equals("3")) {	//반차일때
				Map<String, String> map = new HashMap<String, String>();
				map.put("no", no[i]);
				result *= dao.insertHalfOffWork(sst, map);
			} else {	//그 외일때
				result *= dao.insertOffWork(sst, no[i]);				
			}
		}
		return result;
	}
	
	@Override
	@Transactional
	public int setOffReject(String[] no) {
		int result = 1;
		for(int i=0; i<no.length; i++) {
			result *= dao.updateOffReject(sst, no[i]);
		}
		return result;
	}
	
	
}
