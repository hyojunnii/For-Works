package com.kh.forworks.docmanage.vo;

import lombok.Data;

@Data
public class DocControlVo {
	private String contNo;
	private String contEnrollDate;
	private String contEndDate;
	private String contStatus;
	private String adocNo;
	private String docNo;
	private String range;
	private String[] range_;
	
	private String adocName;
	private String adocContent;
	private String draftDate;
	private String noelecStatus;
	private String approveNo;
	private String approveStatus;
	private String approveDate;
	private String approveMember;
	private String empNo;
	private String empName;
	private String deptName;
	private String deptNo;
	
	private String fileName;
	private String changeFileName;
	
	private String signFile;
	
	
	private String noelecNo;
	private String noelecOriginName;
	private String noelecChangeName;
}
