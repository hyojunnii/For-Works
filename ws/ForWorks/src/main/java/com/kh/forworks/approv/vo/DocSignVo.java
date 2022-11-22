package com.kh.forworks.approv.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DocSignVo {
	
	private String signNo;
	private String empNo;
	private MultipartFile signFile;
	private String signOrigin;
	private String signEdit;

}
