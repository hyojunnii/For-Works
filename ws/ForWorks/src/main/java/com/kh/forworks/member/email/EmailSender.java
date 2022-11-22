package com.kh.forworks.member.email;

import java.security.SecureRandom;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class EmailSender {
	
	@Autowired
	private JavaMailSender mailSender;
	
	public String makeRandomPwd() {
		char[] charSet = new char[] {
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		};
		StringBuffer sb = new StringBuffer();
		SecureRandom sr = new SecureRandom();
		sr.setSeed(new Date().getTime());
		
		int index = 0;
		int len = charSet.length;
		for(int i = 0; i < 6; i++) {
			index = sr.nextInt(len);
			sb.append(charSet[index]);
		}
		return sb.toString();
	}
	
	public String SendEmail(String empEmail, String empName) {
		String pwd = makeRandomPwd();
		String setFrom = "forworks1114@gmail.com";
		String toMail = empEmail;
		String title = "[FOR-WORKS] 임시비밀번호 발급 메일입니다.";
		String content = 
				empName + "님," + "<br>" + 
				"임시 비밀번호는 " + pwd + " 입니다." + "<br><br>" +
				"임시 비밀번호로 로그인 후 비밀번호를 변경해주시기 바랍니다.";
		mailSend(setFrom, toMail, title, content);
		return pwd;
	}
	
	public void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage msg = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(msg);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	
}
