package com.kh.forworks.community.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.kh.forworks.comments.service.CommentsService;
import com.kh.forworks.comments.vo.CommentsVo;
import com.kh.forworks.community.service.CommunityService;
import com.kh.forworks.community.vo.CommunityVo;
import com.kh.forworks.communityattachments.vo.CommunityAttachmentsVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;

@Controller
@RequestMapping("community")
public class CommunityController {
	
	private final CommunityService cmusv;
	private final CommentsService cmsv;
	
	@Autowired
	public CommunityController(CommunityService cmusv, CommentsService cmsv) {
		this.cmusv = cmusv;
		this.cmsv = cmsv;
	}

		//커뮤니티 (화면)
		@GetMapping("list/{pno}")
		public String list(Model model, @PathVariable int pno, String condition, String keyword, HttpSession session){
			
			//로그인 연결x -> 로그인페이지로
			MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
			if (loginMember == null) {
				session.setAttribute("toastMsg", "로그인이 필요합니다.");
				return "redirect:/login";
			}else{
				//System.out.println("condition/key :: "+condition+"/" +keyword);
				//데이터 뭉치기
				
				Map<String, String> map =  new HashMap<String, String>();
				map.put("keyword", keyword);
				map.put("condition", condition);
				map.put("cmuRead", loginMember.getDeptNo());
				
				//전체
				//커뮤니티 전체 갯수
				int totalCount = cmusv.selectTotalCount(map);
				//페이징 처리
				PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 10);
				//System.out.println(pv);
				
				//커뮤니티 리스트 가져오기
				List<CommunityVo> cmuList = cmusv.selectList(pv, map);
				//System.out.println(cmuList);
				
				//로그인한 사원의 부서에 대해서만
				//커뮤니티 개수(해당부서)
				int ttCntDp = cmusv.selectDp(map);
				//System.out.println("부서커뮤글갯수"+ttCntDp); ok
				PageVo pvdp = Pagination.getPageVo(ttCntDp, pno, 5, 10);
				//System.out.println("dp"+pvdp);
				List<CommunityVo> cmudpList = cmusv.selectListdp(pvdp,map);
				//System.out.println(cmudpList); 
				
				if (cmuList != null && cmudpList != null) {
					model.addAttribute("cmuList",cmuList);
					model.addAttribute("pv", pv);
					
					model.addAttribute("cmudpList",cmudpList);
					model.addAttribute("pvdp",pvdp);
					
					return "community/list";
				}else {
					return "error";
				}
			}
			
			
		}
		
		@GetMapping("write")
		public String write(HttpSession session, Model model) {
			MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
			
			//로그인한 유저의 부서정보 가져오기
			DepartmentVo dpvo = cmusv.logDp(loginMember.getDeptNo());
			
			model.addAttribute("dpvo", dpvo);
			
			return"community/write";
		}
		
		
		//커뮤니티 게시글 작성
		@PostMapping("write")
		public String write(CommunityVo cmuvo, CommunityAttachmentsVo cmatVo ,HttpServletRequest req,Model model ,HttpSession session) {
			//System.out.println("커뮤::"+cmuvo);
	        MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
	        
			cmuvo.setEmpNo(loginMember.getEmpNo());
			cmuvo.setCmuRead(loginMember.getDeptNo());
			
			//파일 유무 확인
			if (cmuvo.getCmuFileName() != null && !cmuvo.getCmuFileName().isEmpty()) {
				//파일 있음
				//파일 업로드 후 저장된 파일명 얻기 
				String savePath = req.getServletContext().getRealPath("/resources/upload/commu/");
				String changeName = FileUploader.fileUpload(cmuvo.getCmuFileName(), savePath);
				String originName = cmuvo.getCmuFileName().getOriginalFilename();
				cmatVo.setCmatChange(changeName);
				cmatVo.setCmatOrigin(originName);
				cmatVo.setCmatPath(savePath);
				//System.out.println("공지파일::"+cmatVo);
			}else {cmatVo=null;}
			
			//db 공지사항 저장
			int result = cmusv.insertCommu(cmuvo, cmatVo);
			
			
			if (result == 1 || result ==2) {
				// 1 :: 파일 없음  || 2 :: 파일있음
				session.setAttribute("alertMsg", "커뮤니티 작성 성공!");
				return "redirect:/community/list/1";
			}else {
				model.addAttribute("errorMsg","커뮤니티 작성 실패..");
				return "redirect:/error";
				}
		}
		
		//커뮤니티 게시글 상세보기
		@GetMapping("detail/{no}")
		public String detail(@PathVariable String no, Model model, HttpSession session){
			
			//db 공지사항 조회
			CommunityVo cmuvo  = cmusv.selectOne(no);
			
			MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
			
			if (!(loginMember.getDeptName().equals(cmuvo.getCmuRead()) || cmuvo.getCmuRead().equals("전체"))) {
				session.setAttribute("alertMsg", "열람 권한이 없습니다.");
				return"redirect:/community/list/1";
			}
			

			//System.out.println("커뮤 확인::"+cmuvo);
//			if (loginMember.getEmpNo() != cmuvo.getEmpNo()) {
//				model.addAttribute("AlertMsg","접근권한이 없습니다");
//				return "redirect:/community/list/1";
//			}
			
			//첨부파일 확인
			CommunityAttachmentsVo cmatVo = cmusv.checkFile(no);
			//System.out.println("파일 확인::"+cmatVo);
			
			//댓글정보가져오기
			//System.out.println("댓글시작");
			List<CommentsVo> cmtList = cmsv.selectList(no);
			//System.out.println(cmtList);
			
			if (cmatVo!=null) {
				String ext = cmatVo.getCmatChange().substring(cmatVo.getCmatChange().lastIndexOf("."));
				//System.out.println(ext);
				model.addAttribute("ext",ext);
			}
			
			model.addAttribute("cmuvo", cmuvo);
			model.addAttribute("cmatVo", cmatVo);
			model.addAttribute("cmtList", cmtList);
			//System.out.println(ntvo);
			return"community/detail";
		}
		
		//커뮤니티 게시글 수정(화면)
		@GetMapping("update/{no}")
		public String update(@PathVariable String no, Model model) {
			//db 공지사항 조회
			CommunityVo cmuvo  = cmusv.selectOne(no);
			//System.out.println(cmusv);
			
			//첨부파일 확인
			CommunityAttachmentsVo cmatVo = cmusv.checkFile(no);
			//System.out.println("파일 확인::"+cmatVo);
			
			if (cmatVo!=null) {
				String ext = cmatVo.getCmatChange().substring(cmatVo.getCmatChange().lastIndexOf("."));
				//System.out.println(ext);
				model.addAttribute("ext",ext);
			}
			
			model.addAttribute("cmuvo", cmuvo);
			model.addAttribute("cmatVo", cmatVo);
			return"community/update";
		}
		
		//게시글 수정
		@PostMapping("update/{no}")
		public String update(@PathVariable String no, CommunityVo cmuvo, CommunityAttachmentsVo cmatVo, HttpServletRequest req, Model model, HttpSession session) {
			cmuvo.setCmuNo(no);
			cmatVo.setCmuNo(no);
			//System.out.println(ntvo);
			//System.out.println(ntatVo);
			
			//정보수정
			
			//기존 파일 삭제
			String savePath = req.getServletContext().getRealPath("/resources/upload/commu/");
			//MemberVo loginMember = (MemberVo)(session.getAttribute("loginMember"));
			
			//첨부파일 확인
			CommunityAttachmentsVo cmatVoCheck = cmusv.checkFile(no);
			//System.out.println("파일 확인(정보수정post)::"+ntatVo);
			
			if (!(cmuvo.getCmuFileName().isEmpty())) {
				String fileName = cmatVo.getCmatOrigin();
				File f =  new File(savePath +  fileName);
				if(f.exists()) { //파일 존재하는지 확인
					f.delete();
				}
			}
			
			//파일 유무 확인
			if (cmuvo.getCmuFileName() != null && !cmuvo.getCmuFileName().isEmpty()) {
				//파일 있음
				//파일 업로드 후 저장된 파일명 얻기 
				String changeName = FileUploader.fileUpload(cmuvo.getCmuFileName(), savePath);
				String originName = cmuvo.getCmuFileName().getOriginalFilename();
				cmatVo.setCmatChange(changeName);
				cmatVo.setCmatOrigin(originName);
				cmatVo.setCmatPath(savePath);
				//System.out.println("공지파일::"+ntatVo);
			}else {cmatVo=null;}
			
			int result = cmusv.edit(cmuvo, cmatVo,cmatVoCheck, no);
			if (result==1 || result ==2) {
				session.setAttribute("toastMsg", "커뮤니티글 수정 성공!");
				return "redirect:/community/detail/"+no;
				
			}else {return"redirect:/error";}
		}
		
		@GetMapping("delete/{no}")
		public String delete(@PathVariable String no, Model model, HttpSession session) {
			
			int result = cmusv.delete(no);
			
			if (result ==1) {
				session.setAttribute("alertMsg", "커뮤니티글 삭제 성공!");
				return "redirect:/community/list/1";
			}else {return"redirect:/error";}
		}
}
