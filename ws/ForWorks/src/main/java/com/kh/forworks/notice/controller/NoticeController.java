package com.kh.forworks.notice.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.forworks.FileUploader;
import com.kh.forworks.PageVo;
import com.kh.forworks.Pagination;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.notice.service.NoticeService;
import com.kh.forworks.notice.vo.NoticeVo;
import com.kh.forworks.noticeattachments.vo.NoticeAttachmentsVo;

@Controller
@RequestMapping("notice")
public class NoticeController {
	
	private final NoticeService nts;
	
	@Autowired
	public NoticeController(NoticeService nts) {
		this.nts = nts;
	}

	//공지사항 (화면)
	@GetMapping("list/{pno}")
	public String list(Model model,@PathVariable int pno, String keyword, HttpSession session){
		
		//로그인 연결x -> 로그인페이지로
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		if (loginMember == null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}else{
		
		//공지사항 전체 갯수
		int totalCount = nts.selectTotalCount(keyword);
		
		//페이징 처리
		PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 10);
		
		//공지사항 리스트 가져오기
		List<NoticeVo> ntList = nts.selectList(pv , keyword);
		
		
		if (ntList != null) {
			model.addAttribute("ntList",ntList);
			model.addAttribute("pv", pv);
			model.addAttribute("keyword", keyword);
			return "notice/list";
		}else {
			return "error";
		}
		}
	}
	
	//공지사항 작성(화면)
	@GetMapping("write")
	public String write(Model model) {
		
		//부서목록 가져오기
		List<DepartmentVo> dpvo = nts.selectAlldp();
		//System.out.println(dpvo);
		
		model.addAttribute("dpvo", dpvo);
		return"notice/write";
	}
	
	//공지사항 작성
	@PostMapping("write")
	public String write(NoticeVo ntvo, NoticeAttachmentsVo ntatVo ,HttpServletRequest req,Model model ,HttpSession session) {
		//System.out.println("공지::"+ntvo);
		
		
        MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
        
        ntvo.setEmpNo(loginMember.getEmpNo());
		//파일 유무 확인
		if (ntvo.getNtFileName() != null && !ntvo.getNtFileName().isEmpty()) {
			//파일 있음
			//파일 업로드 후 저장된 파일명 얻기 
			String savePath = req.getServletContext().getRealPath("/resources/upload/notice/");
			String changeName = FileUploader.fileUpload(ntvo.getNtFileName(), savePath);
			String originName = ntvo.getNtFileName().getOriginalFilename();
			ntatVo.setNtatChange(changeName);
			ntatVo.setNtatOrigin(originName);
			ntatVo.setNtatPath(savePath);
			//System.out.println("공지파일::"+ntatVo);
		}else {ntatVo=null;}
		
		//db 공지사항 저장
		int result = nts.insertNotice(ntvo, ntatVo);
		
		
		if (result == 1 || result ==2) {
			// 1 :: 파일 없음  || 2 :: 파일있음
			session.setAttribute("toastMsg", "공지사항 작성 성공!");
			return "redirect:/notice/list/1";
		}else {
			model.addAttribute("errorMsg","공지사항 작성 실패..");
			return "redirect:/error";
			}
	}
	
	//공지사항 상세보기
	@GetMapping("detail/{no}")
	public String detail(@PathVariable String no, Model model, HttpSession session) {
		
		//로그인한 회원이 접근권한이 있는지 판단[작성자의 부서 비교 게시글의 접근권한]

		//db 공지사항 조회
		NoticeVo ntvo = nts.selectOne(no);
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		if ( !((ntvo.getNtAccess().equals("전체"))) && !(loginMember.getDeptName().equals(ntvo.getNtAccess())) ) {
			session.setAttribute("toastMsg", "열람 권한이 없습니다.");
			return"redirect:/notice/list/1";
		}
		
		//첨부파일 확인
		NoticeAttachmentsVo ntatVo = nts.checkFile(no);
		//System.out.println("파일 확인::"+ntatVo);
		
		if (ntatVo!=null) {
			String ext = ntatVo.getNtatChange().substring(ntatVo.getNtatChange().lastIndexOf("."));
			//System.out.println(ext);
			model.addAttribute("ext",ext);
		}
		
		model.addAttribute("ntvo", ntvo);
		model.addAttribute("ntatVo", ntatVo);
		//System.out.println(ntvo);
		
		return"notice/detail";
	}
	
	//공지사항 수정(화면)
	@GetMapping("update/{no}")
	public String update(@PathVariable String no, Model model) {
		
		//부서목록 가져오기
		List<DepartmentVo> dpvo = nts.selectAlldp();
		//System.out.println(dpvo);
		
		//db 공지사항 조회
		NoticeVo ntvo = nts.selectOne(no);
		
		//첨부파일 확인
		NoticeAttachmentsVo ntatVo = nts.checkFile(no);
		//System.out.println("파일 확인::"+ntatVo);
		//System.out.println(ntvo);
		//System.out.println(ntvo.deptNum);
		
		if (ntatVo!=null) {
			String ext = ntatVo.getNtatChange().substring(ntatVo.getNtatChange().lastIndexOf("."));
			//System.out.println(ext);
			model.addAttribute("ext",ext);
		}
		
		model.addAttribute("ntvo", ntvo);
		model.addAttribute("ntatVo", ntatVo);
		model.addAttribute("dpvo",dpvo);
		return"notice/update";
	}
	
	//공지사항 수정
	@PostMapping("update/{no}")
	public String update(@PathVariable String no, NoticeVo ntvo, NoticeAttachmentsVo ntatVo, HttpServletRequest req, Model model, HttpSession session) {
		ntvo.setNtno(no);
		ntatVo.setNtno(no);
		//System.out.println(ntvo);
		//System.out.println(ntatVo);
		
		//정보수정
		
		//기존 파일 삭제
		String savePath = req.getServletContext().getRealPath("/resources/upload/notice/");
		//MemberVo loginMember = (MemberVo)(session.getAttribute("loginMember"));
		
		//첨부파일 확인
		NoticeAttachmentsVo ntatVocheck = nts.checkFile(no);
		//System.out.println("파일 확인(정보수정post)::"+ntatVocheck);
		
		//해당 게시글의 첨부파일이있으면 삭제
		if (!(ntvo.getNtFileName().isEmpty())) {
			String fileName = ntatVo.getNtatOrigin();
			File f =  new File(savePath +  fileName);
			//System.out.println("f::" + f);
			if(f.exists()) { //파일 존재하는지 확인
				f.delete();
				//System.out.println("첨부파일(공지) 삭제완료");
			}
		}
		
		//파일 유무 확인
		if (ntvo.getNtFileName() != null && !ntvo.getNtFileName().isEmpty()) {
			//파일 있음
			//파일 업로드 후 저장된 파일명 얻기 
			String changeName = FileUploader.fileUpload(ntvo.getNtFileName(), savePath);
			//System.out.println(changeName);
			String originName = ntvo.getNtFileName().getOriginalFilename();
			//System.out.println(originName);
			ntatVo.setNtatChange(changeName);
			ntatVo.setNtatOrigin(originName);
			ntatVo.setNtatPath(savePath);
			//System.out.println("공지파일::"+ntatVo);
		}else {ntatVo=null;}
		
		//공지사항 정보수정
		//수정시 기존 파일이있으면 update, 없으면 insert 
		int result = nts.edit(ntvo, ntatVo,ntatVocheck, no);
		if (result ==1 || result ==2) {
			session.setAttribute("toastMsg", "공지사항 수정 성공!");
			return "redirect:/notice/detail/"+no;
			
		}else {return"redirect:/error";}
		
	}
	
	//공지사항 삭제
	@GetMapping("delete/{no}")
	public String delete(@PathVariable String no, Model model, HttpSession session) {
		
		int result = nts.delete(no);
		
		if (result ==1) {
			session.setAttribute("toastMsg", "공지사항 삭제 성공!");
			return "redirect:/notice/list/1";
		}else {return"redirect:/error";}
	}
}
