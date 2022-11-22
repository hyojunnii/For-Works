package com.kh.forworks.off.vo;

import lombok.Data;

@Data
public class OffVo {

	private String no;
	private String writeDate;
	private String startDay;
	private String endDay;
	private String status;
	private String empNo;
	private String empName;
	private String period;
	
	private String typeCode;
	private String typeName;
	private String pay;
	
	public void setStatus(String status) {
		if(status.equals("Y")) {
			this.status = "사용 허가";
		} else if(status.equals("W")) {
			this.status = "대기중";
		} else if(status.equals("N")) {
			this.status = "사용 거절";
		} else {
			this.status = "오류발생";
		}
	}
}
