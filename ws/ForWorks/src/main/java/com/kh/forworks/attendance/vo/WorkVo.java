package com.kh.forworks.attendance.vo;

import lombok.Data;

@Data
public class WorkVo {
	
	private int no;
	private String empName;
	private String inTime;
	private String outTime;
	private String statusName;

	private String workTime;
	private String lateTime;
	private String earlyoutTime;
	private String overTime;
	
	private String inDate;
	private String outDate;
	
	public void setWorkTime(int t) { this.workTime = changeFormat(t); }
	
	public void setLateTime(int t) { this.lateTime = changeFormat(t); }
	
	public void setEarlyoutTime(int t) { this.earlyoutTime = changeFormat(t); }
	
	public void setOverTime(int t) { this.overTime = changeFormat(t); }
	
	
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
