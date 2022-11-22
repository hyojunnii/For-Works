package com.kh.forworks.member.vo;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVo {
	private String empNo;
	private String opLevel;
	private String empId;
	private String empPwd;
	private String empName;
	private String empRegno;
	private String empEmail;
	private String empPhone;
	private String empPcode;
	private String empAddr1;
	private String empAddr2;
	private String empAddr3;
	private String empExphone;
	private String empBank;
	private String empAccount;
	private String empMoney;
	private String empJdate;
	private String empRdate;
	private String empProfile;
	private String empStatus;
	private String statNo;
	private String posNo;
	private String deptNo;
	private String empEdate;
	private String color;
	
	private String posName;
	private String deptName;
	private String opName;

	//회원가입
	private String empRegno1;
	private String empRegno2;
	
	//비밀번호 재설정
	private String nowPwd;
	
	//프로필사진
	private MultipartFile profile;
	
	//주소록 중요
	private String bmEmpNo;
	
	public void encodePwd(PasswordEncoder pwdEnc) {
		this.empPwd = pwdEnc.encode(this.empPwd);
	}
}
