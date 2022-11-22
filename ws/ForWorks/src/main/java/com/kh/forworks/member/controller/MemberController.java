package com.kh.forworks.member.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.forworks.FileUploader;
import com.kh.forworks.member.email.EmailSender;
import com.kh.forworks.member.service.MemberService;
import com.kh.forworks.member.vo.MemberVo;

@Controller
public class MemberController {
	
	private final MemberService memberService;
	private final EmailSender EmailSender;
	
	@Autowired
	public MemberController(MemberService memberService, EmailSender emailSender) {
		this.memberService = memberService;
		this.EmailSender = emailSender;
	}

	//회원가입
	@GetMapping("join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("join")
	public String join(MemberVo vo, HttpSession session) {
		String regno = vo.getEmpRegno1() + vo.getEmpRegno2();
		vo.setEmpRegno(regno);
		
		int result = memberService.memberJoin(vo);
		
		if(result == 1) {
			session.setAttribute("toastMsg", "가입신청 완료! 승인 대기중입니다.");
			return "redirect:/login";
		} else {
			session.setAttribute("toastMsg", "가입 실패.. 다시 시도해주세요");
			return "redirect:/join";
		}
	}
	
	//아이디 중복확인
	@PostMapping("idCheck")
	@ResponseBody
	public String idCheck(String empId) {
		int result = memberService.idCheck(empId);
		return "" + result;
	}
	
	//로그인
	@GetMapping("login")
	public String login(HttpSession session) {
		session.setAttribute("loginMember", null);
		session.setAttribute("cheifAdmin", null);
		return "member/login";
	}
	
	@PostMapping("login")
	public String login(MemberVo vo, String saveId, HttpServletResponse resp, HttpSession session) {
		if(saveId != null) {
			Cookie idCookie = new Cookie("mid", vo.getEmpId());
			resp.addCookie(idCookie);
		}
		
		MemberVo loginMember = memberService.memberLogin(vo);
		
		if(loginMember != null) {
			if("Y".equals(loginMember.getEmpStatus())) {
				//주민번호 처리
				String exRegNo = loginMember.getEmpRegno();
				String regNo = exRegNo.substring(0, 6) + "-*******";
				loginMember.setEmpRegno(regNo);
				
				//입사일 처리
				String exJdate = loginMember.getEmpJdate();
				String jdate = exJdate.substring(0, 10);
				loginMember.setEmpJdate(jdate);
				
				session.setAttribute("loginMember", loginMember);
				return "redirect:/att/day";
			} else {
				session.setAttribute("toastMsg", "이용할 수 없는 계정입니다.");
				return "redirect:/login";
			}
		} else {
			session.setAttribute("toastMsg", "아이디, 비밀번호를 확인해주세요");
			return "redirect:/login";
		}
	}
	
	//아이디 찾기
	@PostMapping("findId")
	@ResponseBody
	public String findId(String empName, String empEmail) {
		MemberVo vo = new MemberVo();
		vo.setEmpName(empName);
		vo.setEmpEmail(empEmail);
		
		String foundId = memberService.findMemberId(vo);
		return foundId;
	}
	
	//비밀번호 찾기 - 임시비밀번호(SMTP)
	@PostMapping("findPwd")
	@ResponseBody
	public String findMember(String empId, String empName, String empEmail) {
		MemberVo vo = new MemberVo();
		vo.setEmpId(empId);
		vo.setEmpName(empName);
		vo.setEmpEmail(empEmail);
		MemberVo checkMember = memberService.checkMember(vo);
		
		int result = -1;
		if(checkMember != null) {
			String tempPwd = EmailSender.SendEmail(empEmail, empName);
			if(tempPwd != null) {
				vo.setEmpNo(checkMember.getEmpNo());
				vo.setEmpPwd(tempPwd);
				result = memberService.updateTempPwd(vo);
			}
		}
		return "" + result;
	}
	
	//로그아웃
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	//마이페이지
	@GetMapping("mypage")
	public String mypage(HttpSession session, Model model) {
		//가입날짜계산
		String date = ((MemberVo)session.getAttribute("loginMember")).getEmpEdate();
		Date today = new Date();
		try {
			Date edate = new SimpleDateFormat("yy/MM/dd").parse(date);
			long myday = (edate.getTime() - today.getTime()) / 1000 / (24*60*60);
			session.setAttribute("fwDate", myday*-1);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "member/mypage-main";
	}
	
	@PostMapping("mypage")
	public String mypage(MemberVo vo, HttpSession session) {
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		vo.setEmpNo(loginMember.getEmpNo());
		
		int result = memberService.memberInfoEdit(vo);

		if(result == 1) {
			session.setAttribute("toastMsg", "정보를 변경하였습니다.");
			loginMember.setEmpEmail(vo.getEmpEmail());
			loginMember.setEmpPhone(vo.getEmpPhone());
			loginMember.setEmpAddr1(vo.getEmpAddr1());
			loginMember.setEmpAddr2(vo.getEmpAddr2());
			loginMember.setEmpAddr3(vo.getEmpAddr3());
		}
		return "redirect:/mypage";
	}
	
	//비밀번호 변경
	@PostMapping("changePwd")
	@ResponseBody
	public String changePwd(String nowPwd, String changePwd, HttpSession session) {
		String empId = ((MemberVo)session.getAttribute("loginMember")).getEmpId();
		MemberVo vo = new MemberVo();
		vo.setEmpId(empId);
		vo.setEmpPwd(changePwd);
		vo.setNowPwd(nowPwd);
		
		int result = memberService.changePwd(vo);
		return "" + result;
	}
	
	//프로필사진 변경
	@PostMapping("member/profileEdit")
	public String memberprofile(MemberVo vo, HttpServletRequest req, HttpSession session) {
		String savePath = req.getServletContext().getRealPath("/resources/upload/profile/");
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		//기존 파일 삭제
		String fileName = loginMember.getEmpProfile();
		File f = new File(savePath + fileName);
		if(f.exists()) {
			f.delete();
		}
		loginMember.setEmpProfile(null);
		
		//새 파일 등록
		if(vo.getProfile() != null && !vo.getProfile().isEmpty()) {
			String changeName = FileUploader.fileUpload(vo.getProfile(), savePath);
			vo.setEmpProfile(changeName);
			
			String empNo = loginMember.getEmpNo();
			vo.setEmpNo(empNo);
			
			int result = memberService.updateMemberProfile(vo);
			if(result == 1) {
				loginMember.setEmpProfile(changeName);
			}
		}
		return "redirect:/mypage";
	}
	
	@GetMapping("member/profileDelete")
	public String memberprofileDelete(HttpServletRequest req, HttpSession session) {
		String savePath = req.getServletContext().getRealPath("/resources/upload/profile/");
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		//기존 파일 삭제
		String fileName = loginMember.getEmpProfile();
		File f = new File(savePath + fileName);
		if(f.exists()) {
			f.delete();
		}
		
		memberService.updateProfileNull(loginMember);
		
		loginMember.setEmpProfile(null);
		session.setAttribute("loginMember", loginMember);
		return "redirect:/mypage";
	}
	
	//마이페이지 급여계좌설정
	@GetMapping("mypage/account")
	public String mypageAccount() {
		return "member/mypage-account";
	}
	
	@PostMapping("mypage/account")
	public String mypageAccount(MemberVo vo, HttpSession session) {
		if(vo.getEmpBank() == null) {
			return "redirect:/mypage/account";
		}
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		vo.setEmpNo(loginMember.getEmpNo());
		
		int result = memberService.memberAccountEdit(vo);
		
		if(result == 1) {
			session.setAttribute("toastMsg", "계좌를 변경하였습니다.");
			loginMember.setEmpBank(vo.getEmpBank());
			loginMember.setEmpAccount(vo.getEmpAccount());
		}
		return "redirect:/mypage/account";
	}
}
