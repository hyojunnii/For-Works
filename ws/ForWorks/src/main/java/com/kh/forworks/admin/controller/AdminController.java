package com.kh.forworks.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.forworks.PageVo;
import com.kh.forworks.Pagination;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.admin.service.AdminService;
import com.kh.forworks.admin.vo.AdminVo;
import com.kh.forworks.admin.vo.CorpInfoVo;
import com.kh.forworks.member.vo.MemberVo;

@Controller
@RequestMapping("foradmin")
public class AdminController {
	
	private final AdminService adminService;
	
	public AdminController(AdminService adminService) {
		this.adminService = adminService;
	}
	
	//관리자 로그인
	@GetMapping("")
	public String login(HttpSession session) {
		session.setAttribute("loginMember", null);
		session.setAttribute("chiefAdmin", null);
		
		return "admin/admin-login";
	}
	
	@PostMapping("login")
	public String login(AdminVo vo, HttpSession session) {
		AdminVo chiefAdmin = adminService.login(vo);
		
		if(chiefAdmin != null) {
			session.setAttribute("chiefAdmin", chiefAdmin);
			return "redirect:/foradmin/member/1";
		} else {
			session.setAttribute("toastMsg", "로그인 실패");
			return "redirect:/foradmin";
		}
	}
	
	//구성원 승인
	@GetMapping("approval")
	public String memberApply(Model model) {
		List<MemberVo> applyList = adminService.selectApplyList();
		
		for(int i = 0; i < applyList.size(); i++) {
			String regNo = applyList.get(i).getEmpRegno();
			String phone = applyList.get(i).getEmpPhone();
			
			String changeRegNo = regNo.substring(0,6) + "-" + regNo.substring(6);
			String changePhone = phone.substring(0,3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);
			
			applyList.get(i).setEmpRegno(changeRegNo);
			applyList.get(i).setEmpPhone(changePhone);
		}
		
		List<CorpInfoVo> posList = adminService.selectPosList();
		List<CorpInfoVo> deptList = adminService.selectDeptList();
		
		model.addAttribute("applyList", applyList);
		model.addAttribute("posList", posList);
		model.addAttribute("deptList", deptList);
		return "admin/admin-memberapprove";
	}
	
	@PostMapping("memberApprove")
	public String memberApprove(MemberVo vo, HttpSession session) {
		int result = adminService.memberApprove(vo);
		
		if(result == 1) {
			session.setAttribute("toastMsg", "구성원 등록 완료!");
		} else {
			session.setAttribute("toastMsg", "구성원 등록 실패.. 관리자에게 문의하세요");
		}
		return "redirect:/foradmin/approval";
	}
	
	@PostMapping("deleteApply")
	@ResponseBody
	public String deleteApply(String empNo) {
		int result = adminService.deleteApply(empNo);
		
		return "" + result;
	}
		
	//구성원 조회, 정렬, 검색
	@GetMapping("member/{pno}")
	public String memberList(Model model, @PathVariable int pno,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "sort", required = false) String sort,
			@RequestParam(value = "order", required = false) String order
			) {
		List<CorpInfoVo> posList = adminService.selectPosList();
		List<CorpInfoVo> deptList = adminService.selectDeptList();
		model.addAttribute("posList", posList);
		model.addAttribute("deptList", deptList);
		
		AddressVo addVo = new AddressVo();
		addVo.setSort(sort);
		addVo.setOrder(order);
		addVo.setKeyword(keyword);
		
		int totalCount = adminService.selectListCnt(addVo);
		PageVo pv = Pagination.getPageVo(totalCount, pno, 1, 10);
		
		List<MemberVo> memberList = adminService.memberList(pv, addVo);
		
		for(int i = 0; i < memberList.size(); i++) {
			String regNo = memberList.get(i).getEmpRegno();
			String changeRegNo = regNo.substring(0,2) + "." + regNo.substring(2,4) + "." + regNo.substring(4,6);
			memberList.get(i).setEmpRegno(changeRegNo);
		}
		
		model.addAttribute("pv", pv);
		model.addAttribute("addressParam", addVo);
		model.addAttribute("memberList", memberList);
		
		return "admin/admin-memberlist";
	}
	
	//구성원 수정
	@PostMapping("memberInfo")
	@ResponseBody
	public MemberVo memberInfo(String empNo) {
		MemberVo member = adminService.selectedMember(empNo);
		
		if(member.getEmpJdate() != null) {
			String exJdate = member.getEmpJdate();
			String jdate = exJdate.substring(0, 10);
			member.setEmpJdate(jdate);
		}
		return member;
	}
	
	@PostMapping("memberEdit")
	public String memberEdit(MemberVo vo, HttpSession session) {
		int result = adminService.updateMemberInfo(vo);
		
		if(result == 1) {
			session.setAttribute("toastMsg", "구성원을 수정하였습니다.");
		} else {
			session.setAttribute("toastMsg", "오류 발생!");
		}
		return "redirect:/foradmin/member/1";
	}
	
	//구성원 일시정지/탈퇴
	@PostMapping("memberStatus")
	@ResponseBody
	public String memberStatus(String empNo, String empStatus, String empRdate) {
		MemberVo vo = new MemberVo();
		vo.setEmpNo(empNo);
		vo.setEmpStatus(empStatus);
		vo.setEmpRdate(empRdate);
		
		int result = adminService.updateMemberStatus(vo);
		
		return "" + result;
	}
	
	//운영자 설정
	@GetMapping("oper/{oplevel}")
	public String oper(Model model, @PathVariable String oplevel) {
		if(Integer.parseInt(oplevel) < 2) {oplevel = "2";}
		
		//운영자 현황 조회
		List<CorpInfoVo> operList = adminService.selectOperList();
		model.addAttribute("operList", operList);
		
		String pageLevel = operList.get(Integer.parseInt(oplevel)-1).getOpLevel();
		String pageOpName = operList.get(Integer.parseInt(oplevel)-1).getOpName();
		model.addAttribute("pageLevel", pageLevel);
		model.addAttribute("opPage", pageOpName);
		
		List<CorpInfoVo> deptList = adminService.selectDeptList();
		List<CorpInfoVo> posList = adminService.selectPosList();
		model.addAttribute("deptList", deptList);
		model.addAttribute("posList", posList);
		
		//운영자 목록 조회
		List<MemberVo> opMemberList = adminService.selectOperMember(oplevel);
		model.addAttribute("opMemberList", opMemberList);
		
		return "admin/admin-operator";
	}
	
	//운영자 지정
	@PostMapping("opersearch")
	@ResponseBody
	public List<MemberVo> operSearch(Model model, String deptNo, String posNo, String keyword) {
		CorpInfoVo vo = new CorpInfoVo();
		vo.setDeptNo(deptNo);
		vo.setPosNo(posNo);
		vo.setKeyword(keyword);
		
		List<MemberVo> searchMember = adminService.selectSearchMember(vo);
		
		return searchMember;
	}
	
	@GetMapping("operappend/{opLevel}/{empNo}")
	public String operAppend(@PathVariable String opLevel, @PathVariable String empNo) {
		CorpInfoVo vo = new CorpInfoVo();
		vo.setOpLevel(opLevel);
		vo.setEmpNo(empNo);
		
		adminService.updateOperLevel(vo);
		
		return "redirect:/foradmin/oper/" + opLevel;
	}
	
	//운영자 삭제
	@GetMapping("operremove/{opLevel}/{empNo}")
	public String operRemove(@PathVariable String opLevel, @PathVariable String empNo) {
		adminService.resetOpLevel(empNo);
		
		return "redirect:/foradmin/oper/" + opLevel;
	}
}
