package com.kh.forworks.admin.vo;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.Data;

@Data
public class AdminVo {
	
	private String manId;
	private String manPwd;
	private String manMdate;
	
	public void encodePwd(PasswordEncoder pwdEnc) {
		this.manPwd = pwdEnc.encode(this.manPwd);
	}
	
}
