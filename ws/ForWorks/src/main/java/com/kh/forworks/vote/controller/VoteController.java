package com.kh.forworks.vote.controller;

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
import com.kh.forworks.community.vo.CommunityVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.noticeattachments.vo.NoticeAttachmentsVo;
import com.kh.forworks.vote.service.VoteService;
import com.kh.forworks.vote.vo.VoteAttachmentsVo;
import com.kh.forworks.vote.vo.VoteCategoryVo;
import com.kh.forworks.vote.vo.VoteParticipationVo;
import com.kh.forworks.vote.vo.VoteVo;

@Controller
@RequestMapping("vote")
public class VoteController {
	
	private final VoteService vtsv;
	
	@Autowired
	public VoteController(VoteService vtsv) {
		this.vtsv = vtsv;
	}

	// 투표 리스트
	@GetMapping("list/{pno}")
	public String vote(@PathVariable int pno ,HttpSession session, Model model) {
		
		//투표 리스트, 페이징,로그인여부
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		if (loginMember == null) {
			session.setAttribute("toastMsg", "로그인이 필요합니다.");
			return "redirect:/login";
		}else{
			String no =loginMember.getEmpNo();

			//전체
			// 전체 투표 갯수
			int totalCount = vtsv.selectTotalCount();
			//페이징 처리
			PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 10);
			//투표 리스트 가져오기
			List<VoteVo> vtList = vtsv.selectList(pv);
			
			//진행중 투표(로그인 회원이 대상자인것)
			int ingCnt = vtsv.selecting(no);
			PageVo pving = Pagination.getPageVo(ingCnt, pno, 5, 10);
			//리스트 vtList의 상태값이 i인것만
			List<VoteVo> vtingList = vtsv.selectListing(pving,no);
			
			//마감된 투표
			int endCnt = vtsv.selectEnd(no);
			PageVo pvend = Pagination.getPageVo(endCnt, pno, 5, 10);
			//리스트 vtList의 상태값이 e인것만
			List<VoteVo> vtEndList = vtsv.selectListEnd(pvend,no);

			
			if (vtList != null) {
				//all
				model.addAttribute("vtList",vtList);
				model.addAttribute("pv", pv);
				//ing
				model.addAttribute("vtingList", vtingList);
				model.addAttribute("pving", pving);
				
				//end
				model.addAttribute("vtEndList", vtEndList);
				model.addAttribute("pvend", pvend);
				
//				System.out.println(vtList);
//				System.out.println(pv);
//				System.out.println("--------------");
//				System.out.println(vtingList);
//				System.out.println(pving);
//				System.out.println("--------------");
//				System.out.println(vtEndList);
//				System.out.println(pvend);
				return "vote/list";
			}else {
				return "error";
			}
			
		}
	}
	
	//투표 생성(화면)
	@GetMapping("create")
	public String create(HttpSession session, Model model) {
		
		//로그인정보 :: 버튼이 생성자일때만 보이므로 가져오는것x

		//부서목록 가져오기
		List<DepartmentVo> dpvo = vtsv.selectAlldp();
		//System.out.println(dpvo);
		
		model.addAttribute("dpvo", dpvo);
		return "vote/create";
	}
	
	//투표 생성
	@PostMapping("create")
	public String create(VoteVo vtvo ,VoteCategoryVo vtcg, VoteParticipationVo vtpt, VoteAttachmentsVo vtatVo, HttpSession session, HttpServletRequest req) {
		
		vtvo.setVtCreate(vtvo.getVtCreate().replace('T', ' '));
		vtvo.setVtEnd(vtvo.getVtEnd().replace('T', ' '));
		
		
//		System.out.println(vtvo);
//		System.out.println(vtcg);
//		System.out.println(vtpt);
//		System.out.println(vtatVo);
		
//		System.out.println(vtcg.getVtcgName());
		//질문 항목 문자열 자르기및 배열에 담기		
		String[] vtcgArr =vtcg.getVtcgName().split(",");
//		System.out.println(vtcgArr.length);
		
		
		//회원정보 set
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		vtvo.setEmpNo(loginMember.getEmpNo()); //투표 vo에 로그인회원 번호 대입
		
		//파일 유무 확인
		//파일 유무 확인
		if (vtvo.getVtFile() != null && !vtvo.getVtFile().isEmpty()) {
			//파일 있음
			//파일 업로드 후 저장된 파일명 얻기 
			String savePath = req.getServletContext().getRealPath("/resources/upload/vote/");
			String changeName = FileUploader.fileUpload(vtvo.getVtFile(), savePath);
			String originName = vtvo.getVtFile().getOriginalFilename();
			vtatVo.setVtatChange(changeName);
			vtatVo.setVtatOrigin(originName);
			vtatVo.setVtatPath(savePath);
			
		}else {vtatVo=null;}
		
		//대상자가 전체 all 인가?  특정부서별 dp 인가 확인후 
		
		
		//투표, 투표항목, 투표대상자, 투표파일 insert
		int result = vtsv.insertVote(vtvo, vtcgArr, vtatVo);
		
		if (result == 1) {
			session.setAttribute("toastify", "투표 등록완료!");
			return "redirect:/vote/list/1";
		}else {return "error";}
	}
	
	//투표 상세보기(생성자)
	@GetMapping("detailCreator/{pno}")
	public String deatilCreator(@PathVariable String pno, Model model, HttpSession session) {

		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		
		//번호에 맞는 투표 정보 가져오기
		VoteVo vtvo = vtsv.selectOneVt(pno);
		
		//번호에 맞는 항목들 가져오기
		List<VoteCategoryVo> vtcgList = vtsv.selectVtcg(pno);
		
		//투표 대상자 가져오기(전체대상자:: 투표참여o, x)
		List<VoteParticipationVo> vtptList = vtsv.selectVtpt(pno);
		
		//첨부파일 가져오기
		VoteAttachmentsVo vtatList = vtsv.seleVtat(pno);
				
		
//		System.out.println(vtvo);
//		System.out.println(vtcgList);
//		System.out.println(vtptList);
		
		
		model.addAttribute("vtvo", vtvo);
		model.addAttribute("vtcgList", vtcgList);
		model.addAttribute("vtptList", vtptList);
		model.addAttribute("vtatList",vtatList);
		
		return "vote/detailCreator";
	}
	
	//투표 종료
	@GetMapping("end/{pno}")
	public String end(@PathVariable int pno, HttpSession session) {
		
		int result = vtsv.voteEnd(pno); 
		String toastify = "-"+pno+"번 투표 종료-";
		
		if (result == 1) {
			session.setAttribute("toastMsg", toastify);
			return"redirect:/vote/list/1";
		}else {return "error";}
	}
	//투표 수정
	@GetMapping("update/{pno}")
	public String update(@PathVariable String pno, Model model) {
		
		//번호에 맞는 투표 정보 가져오기
		VoteVo vtvo = vtsv.selectOneVt(pno);
		
		//번호에 맞는 항목들 가져오기
		List<VoteCategoryVo> vtcgList = vtsv.selectVtcg(pno);
		
		//첨부파일 가져오기
		VoteAttachmentsVo vtatList = vtsv.seleVtat(pno);
		
		//투표 대상자 가져오기(전체대상자:: 투표참여o, x)
		List<VoteParticipationVo> vtptList = vtsv.selectVtpt(pno);
		
//		System.out.println(vtvo);
//		System.out.println(vtcgList);
//		System.out.println(vtptList);
//		System.out.println(vtatList);
		
		model.addAttribute("vtvo", vtvo);
		model.addAttribute("vtcgList", vtcgList);
		model.addAttribute("vtptList", vtptList);	
		model.addAttribute("vtatList", vtatList);
		
		
		return"vote/update";
	}
	@PostMapping("update/{pno}")
	public String update(@PathVariable String pno, Model model,HttpSession session, VoteVo vtvo, VoteCategoryVo vtcg, VoteAttachmentsVo vtat, HttpServletRequest req) {
		
		vtvo.setVtCreate(vtvo.getVtCreate().replace('T', ' '));
		vtvo.setVtEnd(vtvo.getVtEnd().replace('T', ' '));
		vtvo.setVtNo(pno);
		vtcg.setVtNo(pno);
		
//		System.out.println("-------수정페이지 Post값 넘기기-------");
//		System.out.println(vtvo);
//		System.out.println(vtcg);
//		System.out.println(vtat);
//		System.out.println("///////////////////////////////////");
		
		
		//기존 파일 삭제
		String savePath = req.getServletContext().getRealPath("/resources/upload/vote/");
		//MemberVo loginMember = (MemberVo)(session.getAttribute("loginMember"));
		
		//첨부파일 확인 (투표첨부파일 테이블에 등록된 파일이 있으면 update, 등록된 파일이 없으면 insert)
		VoteAttachmentsVo vtatCheck = vtsv.checkFile(pno);
		//System.out.println("파일 확인(정보수정post)::"+vtatCheck);
		
		//해당 게시글의 첨부파일이있으면 삭제
		//System.out.println("파일공백여부::"+!(vtvo.getVtFile().isEmpty()));
		if (!(vtvo.getVtFile().isEmpty())) {
			String fileName = vtat.getVtatOrigin();
			File f =  new File(savePath +  fileName);
			//System.out.println(f);
			if(f.exists()) { //파일 존재하는지 확인
				f.delete();
				//System.out.println("첨부파일(공지) 삭제완료");
			}
		}
		
		//파일 유무 확인
		if (vtvo.getVtFile() != null && !vtvo.getVtFile().isEmpty()) {
			//파일 있음
			//파일 업로드 후 저장된 파일명 얻기 
			String changeName = FileUploader.fileUpload(vtvo.getVtFile(), savePath);
			//System.out.println(changeName);
			String originName = vtvo.getVtFile().getOriginalFilename();
			//System.out.println(originName);
			vtat.setVtatChange(changeName);
			vtat.setVtatOrigin(originName);
			vtat.setVtatPath(savePath);
			vtat.setVtNo(pno);
			//System.out.println("투표파일::"+vtat);
		}else {vtat=null;}
		
		String[] vtcgArr=null ;
		if (vtcg.getVtcgName() != null) {
			vtcgArr =vtcg.getVtcgName().split(",");
			
		}
		
		//update(투표, 첨부파일,) 및 항목 insert (새로추가된 항목, 추가된 첨부파일)
		int result = vtsv.edit(vtvo, vtcgArr, vtat, vtatCheck, pno);
		

		
		if (result==1) {
			session.setAttribute("toastMsg", "투표 내용 수정완료!");
			return"redirect:/vote/list/1";
		}else {return "error";}
	}
	//투표 삭제
	@GetMapping("delete/{pno}")
	public String delete(@PathVariable int pno, HttpSession session) {
		
		int result = vtsv.voteDelete(pno);
		
		String toastify = "-"+pno+"번 투표 삭제-";
		
		if(result == 1) {
			session.setAttribute("toastMsg", toastify);
			return"redirect:/vote/list/1";
		}else {return "error";}
	}
	//투표 생성자
	//--------------------------------------------------
	
	//투표 상세보기(사용자)
	@GetMapping("detailUser/{pno}")
	public String detaiUser(@PathVariable String pno, Model model, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		
		//번호에 맞는 투표 정보 가져오기
		VoteVo vtvo = vtsv.selectOneVt(pno);
		
		//번호에 맞는 항목들 가져오기
		List<VoteCategoryVo> vtcgList = vtsv.selectVtcg(pno);
		
		//투표 대상자 가져오기(전체대상자:: 투표참여o, x)
		List<VoteParticipationVo> vtptList = vtsv.selectVtpt(pno);
		
		//로그인 사원이 투표 참여 대상자인지 확인(참여x)
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pno", pno);
		map.put("no", loginMember.getEmpNo());
		int check = vtsv.check(map);
		
		//투표를 참여 했는지 확인
		//참여한 인원은 선택한 내용이 체크되어있고 재투표시 알람확인창 나오게하기
		VoteParticipationVo chvo = vtsv.checkDo(map);
		//System.out.println(chvo);
		
		//첨부파일 가져오기
		VoteAttachmentsVo vtatList = vtsv.seleVtat(pno);
		
//		System.out.println(vtvo);
//		System.out.println(vtcgList);
//		System.out.println(vtptList);
		
		model.addAttribute("vtvo", vtvo);
		model.addAttribute("vtcgList", vtcgList);
		model.addAttribute("vtptList", vtptList);
		model.addAttribute("vtatList", vtatList);
		model.addAttribute("check", check);
		model.addAttribute("chvo",chvo);
		
		return "vote/detailUser";
	}
	//사원이 투표를 하였을때
	//필요한값 :: 체트된 항목 번호, 회원번호, 투표 번호
	@PostMapping("detailUser/{pno}")
	public String detailUser(@PathVariable String pno, HttpSession session ,VoteParticipationVo vo, VoteCategoryVo vtcg){
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		//System.out.println(pno);
		//System.out.println(loginMember.getEmpNo());
		
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pno", pno);
		map.put("no",loginMember.getEmpNo());
		map.put("cgno", vtcg.getVtcgNo());
		//사원이 투표를 참여 했는지 확인(투표를 하였는데 다시 투표를 하면 이전투표의 득표수 -- , 현재 ++)
		VoteParticipationVo checkpt = vtsv.checkVote(map);
		
		
		//System.out.println(vo);
		//set 회원 번호, 게시글 번호, 
		vo.setVtNo(pno);
		vo.setEmpNo(loginMember.getEmpNo());
		
		vtcg.setVtNo(pno);
//		System.out.println("===========");
//		System.out.println(vo);
//		System.out.println(vtcg);
//		System.out.println(checkpt);
		//투표 입력내용 넣기
		int result = vtsv.insertUserVt(vo, vtcg, checkpt, map);
		
		if(result ==1) {
			session.setAttribute("toastMsg", "투표 완료!");
			return "redirect:/vote/list/1";
		}else {return"error";}
	}
	

}
