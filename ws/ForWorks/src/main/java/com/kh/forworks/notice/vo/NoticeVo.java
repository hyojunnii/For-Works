package com.kh.forworks.notice.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVo {
	
	private String rownum;
	private String ntno;
	private String empNo;
	private String ntTitle;
	private String ntContent;
	private String ntEnrollDate;
	private String ntModifiyDate;
	private String ntCnt;
	private String ntAccess;
	private MultipartFile ntFileName;
	private String ntStatus;
	public String num;
	public String deptNum;
}
