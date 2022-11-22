package com.kh.forworks.admin.vo;

import lombok.Data;

@Data
public class CorpInfoVo {
	
	//부서
	private String deptNo;
	private String deptName;
	
	//직급
	private String posNo;
	private String posName;
	
	//운영자
	private String opLevel;
	private String opName;
	
	//검색
	private String keyword;
	private String empNo;
	
}
