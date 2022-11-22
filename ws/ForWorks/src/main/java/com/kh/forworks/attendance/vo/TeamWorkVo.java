package com.kh.forworks.attendance.vo;

import lombok.Data;

@Data
public class TeamWorkVo {
	private String name;
	private String inTime;
	private String outTime;
	
	private double doDayTime;
	private double doWeekTime;
	private double doMonthTime;
	
	public void setDoDayTime(int t) {
		this.doDayTime = (double)t;
		this.doWeekTime = t*5.0;
		this.doMonthTime = t*20.0;
	}
}
