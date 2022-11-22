package com.kh.forworks.approv.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.forworks.FileUploader;
import com.kh.forworks.PageVo;
import com.kh.forworks.Pagination;
import com.kh.forworks.approv.service.ApprovService;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.approv.vo.DocApprovVo;
import com.kh.forworks.approv.vo.DocFileVo;
import com.kh.forworks.approv.vo.DocFormVo;
import com.kh.forworks.approv.vo.DocSignVo;
import com.kh.forworks.member.vo.MemberVo;

@Controller
@RequestMapping("approv")
public class ApprovController {
	
	private final ApprovService service;
	
	@Autowired
	public ApprovController(ApprovService service) {
		this.service = service;
	}

	@GetMapping("main")
	public String main(HttpSession session, HttpServletRequest req) {
		
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		
		DocSignVo signVo = service.selectSignOne(loginMember);
		
		if(signVo == null) {
			session.setAttribute("toastMsg", "저장된 서명이 없습니다.");
			return "redirect:/approv/sign/create";
		}
		
		List<ApprovDocumentVo> approvList = service.selectApprovList(empNo);
		List<ApprovDocumentVo> rejectApprovList = service.selectRejectApprovList(empNo);
		List<ApprovDocumentVo> coopList = service.selectCoopList(empNo);
		List<ApprovDocumentVo> referList = service.selectReferList(empNo);
		
		req.setAttribute("approvList", approvList);
		req.setAttribute("rejectApprovList", rejectApprovList);
		req.setAttribute("coopList", coopList);
		req.setAttribute("referList", referList);
		
		return "approv/approv-main";
	}
	
	@GetMapping("create")
	public String create(HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		List<DocFormVo> formList = service.selectFormListAll();
		List<MemberVo> approvMemberList = service.selectMemberList();
		req.setAttribute("formList", formList);
		req.setAttribute("MemberList", approvMemberList);
		
		return "approv/approv-create";
	}
	
	@PostMapping("create")
	public String create(ApprovDocumentVo vo, HttpSession session, HttpServletRequest req) {
		
		if(vo.getDocFile()!=null && !vo.getDocFile().isEmpty()) {
			String savePath = req.getServletContext().getRealPath("/resources/upload/doc/");
			vo.setFileName(vo.getDocFile().getOriginalFilename());
			
			String changeName = FileUploader.fileUpload(vo.getDocFile(), savePath); 
			
			vo.setChangeFileName(changeName);
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		vo.setEmpNo(memberVo.getEmpNo());
		
		int result = service.insertApprovDoc(vo);
		
		if(result==1) {
			
			return "redirect:/approv/main";
		}else {
			return "redirect:/";
		}
		
	}
	
	@GetMapping("create/noelec")
	public String createNoElec(HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		return "approv/no-elec-doc-create";
	}
	
	@PostMapping("create/noelec")
	public String createNoElec(ApprovDocumentVo vo, HttpSession session, HttpServletRequest req) {
	
		if(vo.getDocFile()!=null && !vo.getDocFile().isEmpty()) {
			String savePath = req.getServletContext().getRealPath("/resources/upload/noelecdoc/");
			vo.setFileName(vo.getDocFile().getOriginalFilename());
			
			String changeName = FileUploader.fileUpload(vo.getDocFile(), savePath); 
			
			vo.setChangeFileName(changeName);
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		vo.setEmpNo(memberVo.getEmpNo());
		
		int result = service.insertApprovNoElecDoc(vo);
		
		if(result==1) {
			return "redirect:/approv/main";
		}else {
			return "redirect:/";
		}
		
	}
	
	@GetMapping("detail/{dno}")
	public String detail(@PathVariable String dno, HttpSession session, HttpServletRequest req) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		ApprovDocumentVo vo = new ApprovDocumentVo();
		
		vo.setEmpNo(memberVo.getEmpNo());
		vo.setAdocNo(dno);
		
		
		int result = service.selectApprovDocEmpNo(vo);
		
		if(result == 0) {
			session.setAttribute("toastMsg", "접근 권한이 없습니다.");
			return "redirect:/approv/main";	
		}
		
		vo = service.selectApprovDocOneByNo(vo);
		List<ApprovDocumentVo> approvMemberList = service.selectApprovMemberList(dno);
		List<ApprovDocumentVo> coopMemberList = service.selectCoopMemberList(dno);
		List<ApprovDocumentVo> approvSignList= service.selectApprovSignList(dno);
		String adocNo = dno;
		DocFileVo fileVo = service.selectDocFile(adocNo);
		
		for (int i = approvSignList.size(); i < approvMemberList.size(); i++) {
			approvSignList.add(null);
		}
		
		req.setAttribute("approvDoc", vo);
		req.setAttribute("approvMemberList", approvMemberList);
		req.setAttribute("coopMemberList", coopMemberList);
		req.setAttribute("approvSignList", approvSignList);
		req.setAttribute("docfile", fileVo);
		
		
		return "approv/approv-detail";
	}
	
	@PostMapping("detail/{dno}")
	public String detail(@PathVariable String dno, DocApprovVo vo, HttpSession session, @RequestParam String approv ) {
		
		vo.setAdocNo(dno);
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		vo.setEmpNo(memberVo.getEmpNo());
		vo.setApproveStatus(approv);
		
		int result = service.updateApprov(vo);
		
		
		if(result==1) {
			return "redirect:/approv/main";
		}else {
			return "redirect:/";
		}
	}
	
	@GetMapping("reject/{dno}")
	public String reject(@PathVariable String dno, HttpSession session, HttpServletRequest req) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		ApprovDocumentVo vo = new ApprovDocumentVo();
		
		vo.setEmpNo(memberVo.getEmpNo());
		vo.setAdocNo(dno);
		
		
		int result = service.selectApprovDocEditEmpNo(vo);
		
		if(result == 0) {
			session.setAttribute("toastMsg", "접근 권한이 없습니다.");
			return "redirect:/approv/main";	
		}
		
		String adocNo = dno;
		DocFileVo fileVo = service.selectDocFile(adocNo);
		
		vo = service.selectApprovDocOneByNo(vo);
		List<ApprovDocumentVo> approvMemberList = service.selectApprovMemberList(dno);
		List<ApprovDocumentVo> coopMemberList = service.selectCoopMemberList(dno);
		List<ApprovDocumentVo> approvSignList= service.selectApprovSignList(dno);
		
		for (int i = approvSignList.size(); i < approvMemberList.size(); i++) {
			approvSignList.add(null);
		}
	
		
		req.setAttribute("approvDoc", vo);
		req.setAttribute("approvMemberList", approvMemberList);
		req.setAttribute("coopMemberList", coopMemberList);
		req.setAttribute("approvSignList", approvSignList);
		req.setAttribute("docfile", fileVo);
		return "approv/reject-detail";
	}
	//TODO sdf
	@GetMapping("edit/{dno}")
	public String edit(@PathVariable String dno, HttpSession session, HttpServletRequest req) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		List<DocFormVo> formList = service.selectFormListAll();
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		ApprovDocumentVo vo = new ApprovDocumentVo();
		
		vo.setEmpNo(memberVo.getEmpNo());
		vo.setAdocNo(dno);
		
		
		int result = service.selectApprovDocEditEmpNo(vo);
		
		if(result == 0) {
			session.setAttribute("toastMsg", "접근 권한이 없습니다.");
			return "redirect:/approv/main";	
		}
		
		vo = service.selectApprovDocOneByNo(vo);
		
		req.setAttribute("formList", formList);
		req.setAttribute("approvDoc", vo);
		
		return "approv/approv-edit";
	}
	
	@PostMapping("remove/{dno}")
	public String remove(@PathVariable String dno, DocApprovVo vo, HttpSession session) {
		
		vo.setAdocNo(dno);
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		vo.setEmpNo(memberVo.getEmpNo());
		
		int result = service.deleteApprovDoc(vo);
		
		
		if(result==1) {
			session.setAttribute("toastMsg", "삭제되었습니다");
			return "redirect:/approv/main";
		}else {
			return "redirect:/";
		}
	}
	
	@PostMapping("edit/{dno}")
	public String edit(@PathVariable String dno, ApprovDocumentVo vo, HttpSession session) {
		
		vo.setAdocNo(dno);
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		vo.setEmpNo(memberVo.getEmpNo());
		
		int result = service.updateApprovDoc(vo);
		
		
		if(result==1) {
			session.setAttribute("toastMsg", "수정되었습니다");
			return "redirect:/approv/main";
		}else {
			return "redirect:/";
		}
	}
	
	@GetMapping("coop/{dno}")
	public String coop(@PathVariable String dno, HttpSession session, HttpServletRequest req) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		ApprovDocumentVo vo = new ApprovDocumentVo();
		
		vo.setEmpNo(memberVo.getEmpNo());
		vo.setAdocNo(dno);
		
		
		int result = service.selectCoopDocEmpNo(vo);
		
		if(result == 0) {
			session.setAttribute("toastMsg", "접근 권한이 없습니다.");
			return "redirect:/approv/main";	
		}
		
		int result1 = service.updateDocCoopByEmpNo(vo);
		
		String adocNo = dno;
		DocFileVo fileVo = service.selectDocFile(adocNo);
		
		vo = service.selectApprovDocOneByNo(vo);
		List<ApprovDocumentVo> approvMemberList = service.selectApprovMemberList(dno);
		List<ApprovDocumentVo> coopMemberList = service.selectCoopMemberList(dno);
		List<ApprovDocumentVo> approvSignList= service.selectApprovSignList(dno);
		
		for (int i = approvSignList.size(); i < approvMemberList.size(); i++) {
			approvSignList.add(null);
		}
		
		req.setAttribute("approvDoc", vo);
		req.setAttribute("approvMemberList", approvMemberList);
		req.setAttribute("coopMemberList", coopMemberList);
		req.setAttribute("approvSignList", approvSignList);
		req.setAttribute("docfile", fileVo);
		
		return "approv/coop-detail";
	}
	
	@GetMapping("refer/{dno}")
	public String refer(@PathVariable String dno, HttpSession session, HttpServletRequest req) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		ApprovDocumentVo vo = new ApprovDocumentVo();
		
		vo.setEmpNo(memberVo.getEmpNo());
		vo.setAdocNo(dno);
		
		
		int result = service.selectReferDocEmpNo(vo);
		
		if(result == 0) {
			session.setAttribute("toastMsg", "접근 권한이 없습니다.");
			return "redirect:/approv/main";	
		}
		
		int result1 = service.updateDocReferByEmpNo(vo);
		
		String adocNo = dno;
		DocFileVo fileVo = service.selectDocFile(adocNo);
		
		
		vo = service.selectApprovDocOneByNo(vo);
		List<ApprovDocumentVo> approvMemberList = service.selectApprovMemberList(dno);
		List<ApprovDocumentVo> coopMemberList = service.selectCoopMemberList(dno);
		List<ApprovDocumentVo> approvSignList= service.selectApprovSignList(dno);
		
		for (int i = approvSignList.size(); i < approvMemberList.size(); i++) {
			approvSignList.add(null);
		}
		
		req.setAttribute("approvDoc", vo);
		req.setAttribute("approvMemberList", approvMemberList);
		req.setAttribute("coopMemberList", coopMemberList);
		req.setAttribute("approvSignList", approvSignList);
		req.setAttribute("docfile", fileVo);
		
		return "approv/refer-detail";
	}
	
	@GetMapping("form/create")
	public String createForm() {
		return "approv/form-create";
	}
	
	@PostMapping("form/create")
	public String createForm(DocFormVo vo, HttpSession session) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		int result = service.insertForm(vo);
		
		return "redirect:/approv/form/main/1";
	}
	
	@GetMapping("form/main/{pno}")
	public String mainForm(@PathVariable int pno, HttpServletRequest req) {
		int listCount = service.selectFormListCount();
		PageVo pv = Pagination.getPageVo(listCount, pno, 5, 10);
		List<DocFormVo> formList = service.selectFormList(pv);
		
		req.setAttribute("formList", formList);
		req.setAttribute("pageVo", pv);
		return "approv/form-main";
	}
	
	@GetMapping("form/detail/{fno}")
	public String detailForm(@PathVariable String fno, HttpServletRequest req, HttpSession session) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		DocFormVo vo = service.selectFormOne(fno);
		
		req.setAttribute("docForm", vo);
		
		return "approv/form-detail";
	}
	
	@GetMapping("form/edit/{fno}")
	public String editForm(@PathVariable String fno, HttpServletRequest req, HttpSession session) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		DocFormVo vo = service.selectFormOne(fno);
		req.setAttribute("docForm", vo);
		return "approv/form-edit";
	}
	
	@PostMapping("form/edit/{fno}")
	public String editForm(@PathVariable String fno, DocFormVo vo, HttpSession session) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		vo.setFormNo(fno);
		
		int result = service.updateFormOne(vo);
		session.setAttribute("toastMsg", "수정되었습니다.");
		return "redirect:/approv/form/main/1";
	}
	
	@PostMapping("form/delete/{fno}")
	public String deleteForm(@PathVariable String fno, DocFormVo vo, HttpSession session) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		vo.setFormNo(fno);
		
		int result = service.deleteFormOne(vo);
		session.setAttribute("toastMsg", "삭제되었습니다.");	
		return "redirect:/approv/form/main/1";
	}
	
	@GetMapping("sign/create")
	public String createSign(HttpSession session) {
		if(session.getAttribute("loginMember")==null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}
		
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");
		
		DocSignVo signVo = service.selectSignOne(loginMember);
		
		if(signVo != null) {
			session.setAttribute("toastMsg", "이미 서명이 있습니다.");
			return "redirect:/approv/main";
		}
		
		return "approv/sign-create";
	}
	
	@PostMapping("sign/create")
	public String createSign(DocSignVo vo, HttpServletRequest req, HttpSession session) {
		
		if(vo.getSignFile()!=null && !vo.getSignFile().isEmpty()) {
			
			String savePath = req.getServletContext().getRealPath("/resources/upload/sign/");
			vo.setSignOrigin(vo.getSignFile().getOriginalFilename());
			
			String changeName = FileUploader.fileUpload(vo.getSignFile(), savePath); 
			
			vo.setSignEdit(changeName);
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		vo.setEmpNo(memberVo.getEmpNo());
		
		int result = service.insertSignFile(vo);
		if(result==1) {
			session.setAttribute("toastMsg", "서명을 저장하였습니다.");
		}else {
			session.setAttribute("toastMsg", "서명 저장을 실패했습니다.");
		}
		
		return "redirect:/approv/main";
	}
	
	@GetMapping("sign/edit")
	public String editSign(HttpSession session, HttpServletRequest req) {
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");
		
		DocSignVo signVo = service.selectSignOne(loginMember);
		
		if(signVo == null) {
			session.setAttribute("toastMsg", "저장된 서명이 없습니다.");
			return "redirect:/approv/sign/create";
		}
		
		DocSignVo vo = service.selectSignOne(memberVo);
		req.setAttribute("docSignVo", vo);
		return "approv/sign-edit";
	}
	
	@PostMapping("sign/edit")
	public String editSign(DocSignVo vo, HttpServletRequest req, HttpSession session) {
		
		if(vo.getSignFile()!=null && !vo.getSignFile().isEmpty()) {
			
			String savePath = req.getServletContext().getRealPath("/resources/upload/sign/");
			vo.setSignOrigin(vo.getSignFile().getOriginalFilename());
			
			String changeName = FileUploader.fileUpload(vo.getSignFile(), savePath); 
			
			vo.setSignEdit(changeName);
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("loginMember");
		
		vo.setEmpNo(memberVo.getEmpNo());
		
		int result = service.updateSignFile(vo);
		if(result==1) {
			session.setAttribute("toastMsg", "서명을 저장하였습니다.");
		}else {
			session.setAttribute("toastMsg", "서명 저장을 실패했습니다.");
		}
		
		return "redirect:/approv/main";
	}
	
	//미리보기용 반환정보
	@GetMapping(value = "form/callContent" , produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String editForm(String formNo) {
		String result = service.selectFormContentOne(formNo); 
		return result;
	}
	
	
}
