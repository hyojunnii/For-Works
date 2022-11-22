package com.kh.forworks.docmanage.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DocVo {
	private String docNo;
	private String title;
	private String content;
	private String empNo;
	private String enrollDate;
	private String status;
	private String fileName;
	private String changeFileName;
	private MultipartFile[] file;
	private String[] range_;
	
	private String contNo;
	private String contEnrollDate;
	private String contEndDate;
	private String contStatus;
	private String adocNo;
	private String range;
	
	private String fileNo;
	
}
