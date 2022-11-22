package com.kh.forworks.attendance.vo;

import lombok.Data;

@Data
public class TodayWorkVo {
	private int no;
	private String empNo;
	
	private String inTime;
	private String outTime;
	
	private int monthWork;
	private int weekWork;
	private int dayWork;
	
	private String monthWorkStr;
	private String weekWorkStr;
	private String dayWorkStr;
	
	private int statusCode;
	
	public void setMonthWork(int t) {
		this.monthWork = t;
		this.monthWorkStr = changeFormat(t);
	}
	
	public void setWeekWork(int t) {
		this.weekWork = t;
		this.weekWorkStr = changeFormat(t);
	}
	
	public void setDayWork(int t) {
		this.dayWork = t;
		this.dayWorkStr = changeFormat(t);
	}
	
	public void setInTime(String t) {
		if(this.statusCode == 5 && this.inTime.equals("00:00")) {
			this.inTime = "미등록";
		}else {
			this.inTime = t;
		}
	}
	
	public void setOutTime(String t) {
		if(this.statusCode == 5 && this.outTime.equals("00:00")) {
			this.outTime = "미등록";
		}else {
			this.outTime = t;
		}
	}
	
	private String changeFormat(int t) {
		int hour = 0;
		int min = 0;
		
		if(t < 0) {
			
		} else {
			hour = t / 60;
			min = t % 60;
		}
		
		return String.format("%02d", hour) + ":" + String.format("%02d", min);
	}
}
