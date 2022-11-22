package com.kh.forworks.vote.vo;

import lombok.Data;

@Data
public class VoteParticipationVo {
	
	private String vtptNo;
	private String empNo;
	private String vtNo;
	private String vtcgNo;
	private String vtptDate;
	private String vtptEdit;
	private String vtptStatus;
	
	//사원이름
	private String empName;
	//부서명
	private String deptName;
}
