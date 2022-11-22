package com.kh.forworks.qa.vo;

import lombok.Data;

@Data
public class QAParticipationVo {
	
	private String qaptNo;
	private String empNo;
	private String qaNo;
	private String qacgNo;
	private String qaptDate;
	private String qaptEdit;
	private String qaptStatus;
	
	//사원이름
	private String empName;
	//부서명
	private String deptName;
}
