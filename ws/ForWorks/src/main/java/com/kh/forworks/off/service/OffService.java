package com.kh.forworks.off.service;

import java.util.List;
import java.util.Map;

import com.kh.forworks.off.vo.OffCntVo;
import com.kh.forworks.off.vo.OffTypeVo;
import com.kh.forworks.off.vo.OffVo;

public interface OffService {

	OffCntVo getOffCnt(String empNo);

	List<OffVo> getOffList(Map<String, Object> map);

	List<OffTypeVo> getOffTypeList();

	int submitOff(Map<String, Object> map);

	List<OffVo> getDeptOffList(Map<String, Object> map);

	int setOffAccept(String[] no);

	int setOffReject(String[] no);
}
