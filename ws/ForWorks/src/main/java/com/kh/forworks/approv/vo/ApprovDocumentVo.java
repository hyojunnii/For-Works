package com.kh.forworks.approv.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ApprovDocumentVo {
	
	private String adocNo;
	private String adocName;
	private String adocContent;
	private String empNo;
	private String empName;
	private String draftDate;
	private String noelecStatus;
	private String fileName;
	private String changeFileName;
	private MultipartFile docFile;
	private List<String> approvMember;
	private List<String> coopMember;
	private List<String> referMember;
	private String signFile;
	
	

}
