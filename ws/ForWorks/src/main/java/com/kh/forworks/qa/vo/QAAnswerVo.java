package com.kh.forworks.qa.vo;

import lombok.Data;

@Data
public class QAAnswerVo {
	
	private String qaawNo;			//답변번호
	private String qaNo;			//설문지 번호
	private String qacgNo;			//설문항목번호
	private String empNo;			//사원번호
	private String qaawContent;		//답변내용
	
	//사원이름
	private String empName;
	//부서명
	private String deptName;
}
