package com.kh.forworks.qa.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.forworks.FileUploader;
import com.kh.forworks.PageVo;
import com.kh.forworks.Pagination;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.qa.service.QAService;
import com.kh.forworks.qa.vo.QAAnswerVo;
import com.kh.forworks.qa.vo.QAAttachmentsVo;
import com.kh.forworks.qa.vo.QACategoryVo;
import com.kh.forworks.qa.vo.QAParticipationVo;
import com.kh.forworks.qa.vo.QAVo;



@Controller
@RequestMapping("QA")
public class QAController {
	private final QAService qasv;
	
	@Autowired
	public QAController(QAService qasv) {
		this.qasv = qasv;
	}
	
	// 설문 리스트
	@GetMapping("list/{pno}")
	public String qa(@PathVariable int pno ,HttpSession session, Model model) {
		
		//설문 리스트, 페이징,로그인여부
				MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
				if (loginMember == null) {
					session.setAttribute("toastMsg", "로그인이 필요합니다.");
					return "redirect:/login";
				}else{
					String no =loginMember.getEmpNo();

					//전체
					// 전체 설문 갯수
					int totalCount = qasv.selectTotalCount();
					//페이징 처리
					PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 10);
					//설문 리스트 가져오기
					List<QAVo> qaList = qasv.selectList(pv);
					
					//진행중 설문(로그인 회원이 대상자인것)
					int ingCnt = qasv.selecting(no);
					PageVo pving = Pagination.getPageVo(ingCnt, pno, 5, 10);
					//리스트 qaList의 상태값이 i인것만
					List<QAVo> qaingList = qasv.selectListing(pving,no);
					
					//마감된 설문
					int endCnt = qasv.selectEnd(no);
					PageVo pvend = Pagination.getPageVo(endCnt, pno, 5, 10);
					//리스트 qaList의 상태값이 e인것만
					List<QAVo> qaEndList = qasv.selectListEnd(pvend,no);

					
					if (qaList != null) {
						//all
						model.addAttribute("qaList",qaList);
						model.addAttribute("pv", pv);
						//ing
						model.addAttribute("qaingList", qaingList);
						model.addAttribute("pving", pving);
						
						//end
						model.addAttribute("qaEndList", qaEndList);
						model.addAttribute("pvend", pvend);
						
//						System.out.println(qaList);
//						System.out.println(pv);
//						System.out.println("--------------");
//						System.out.println(qaingList);
//						System.out.println(pving);
//						System.out.println("--------------");
//						System.out.println(qaEndList);
//						System.out.println(pvend);
						return "QA/list";
					}else {
						return "error";
					}
					
				}
		
	}
	
	//설문 생성(화면)
	@GetMapping("create")
	public String create(HttpSession session, Model model) {
		
		//로그인정보 :: 버튼이 생성자일때만 보이므로 가져오는것x

		//부서목록 가져오기
		List<DepartmentVo> dpvo = qasv.selectAlldp();
		//System.out.println(dpvo);
		
		model.addAttribute("dpvo", dpvo);
		
		return "QA/create";
	}
	
	//설문 생성
	@PostMapping("create")
	public String create(QAVo qavo ,QACategoryVo qacg, QAParticipationVo qapt, QAAttachmentsVo qaatVo, HttpSession session, HttpServletRequest req) {
		
		qavo.setQaSdate(qavo.getQaSdate().replace('T', ' '));
		qavo.setQaEdate(qavo.getQaEdate().replace('T', ' '));
		
		//회원정보 set
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		qavo.setEmpNo(loginMember.getEmpNo()); //설문 vo에 로그인회원 번호 대입
		
		//System.out.println(qavo);
		//System.out.println(qacg);
		//System.out.println(qapt);
		//System.out.println(qaatVo);
		
		//System.out.println(qacg.getQacgName());
		//질문 항목 문자열 자르기및 배열에 담기		
		String[] qacgArr =qacg.getQacgName().split(",");
		//System.out.println(qacgArr.length);
		
		
		
		//파일 유무 확인
		//파일 유무 확인
		//System.out.println((qavo.getQaFile()));
		
		if (qavo.getQaFile() != null ) {
			//파일 있음
			//System.out.println("QA파일존재");
			//파일 업로드 후 저장된 파일명 얻기
			String savePath = req.getServletContext().getRealPath("/resources/upload/QA/");
			String changeName = FileUploader.fileUpload(qavo.getQaFile(), savePath);
			String originName = qavo.getQaFile().getOriginalFilename();
			qaatVo.setQaatChange(changeName);
			qaatVo.setQaatOrigin(originName);
			qaatVo.setQaatPath(savePath);
			
		}else {qaatVo=null;}
		
		//대상자가 전체 all 인가?  특정부서별 dp 인가 확인후 
		//설문, 설문항목, 설문대상자, 설문파일 insert
		int result = qasv.insertQA(qavo, qacgArr, qaatVo);
		
		if (result == 1) {
			session.setAttribute("toastify", "설문 등록완료!");
			return "redirect:/QA/list/1";
		}else {return "error";}
	}
	
	//설문 상세보기(생성자)
	@GetMapping("detailCreator/{pno}")
	public String deatilCreator(@PathVariable String pno, Model model, HttpSession session) {

		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		
		//번호에 맞는 설문 정보 가져오기
		QAVo qavo = qasv.selectOneQa(pno);
		
		//번호에 맞는 항목들 가져오기
		List<QACategoryVo> qacgList = qasv.selectQacg(pno);
		
		//설문 대상자 가져오기(전체대상자:: 설문참여o, x)
		List<QAParticipationVo> qaptList = qasv.selectQapt(pno);
		
		//첨부파일 가져오기
		QAAttachmentsVo qaatList = qasv.seleQaat(pno);
		
		//참가자 답변내용 가져오기		
		List<QAAnswerVo> qaawList =qasv.selectQaaw(pno);
		
		//참여 인원수 가져오기
		int checkNum = qasv.selectNum(pno);
		
		//System.out.println(qavo);		//QAVo   :: 설문
		//System.out.println(qacgList);	//QACategoryVo :: 설문 항목
		//System.out.println(qaptList);	//QAParticipationVo :: 설문 참가자
		//System.out.println(qaatList);	//QAAT :: 설문 첨부파일
		//System.out.println(qaawList);	//QAAW :: 참가자 답변
		
		
		model.addAttribute("qavo", qavo);
		model.addAttribute("qacgList", qacgList);
		model.addAttribute("qaptList", qaptList);
		model.addAttribute("qaatList", qaatList);
		model.addAttribute("qaawList", qaawList);
		model.addAttribute("checkNum", checkNum);
		
		return "QA/detailCreator";
	}
	
	//설문 종료
	@GetMapping("end/{pno}")
	public String end(@PathVariable int pno, HttpSession session) {
		
		int result = qasv.QAEnd(pno); 
		String toastify = "-"+pno+"번 설문 종료-";
		
		if (result == 1) {
			session.setAttribute("toastMsg", toastify);
			return"redirect:/QA/list/1";
		}else {return "error";}
	}
	
	//설문 수정
	@GetMapping("update/{pno}")
	public String update(@PathVariable String pno, Model model) {
		
		//번호에 맞는 설문 정보 가져오기
		QAVo qavo = qasv.selectOneQa(pno);
		
		//번호에 맞는 항목들 가져오기
		List<QACategoryVo> qacgList = qasv.selectQacg(pno);
		
		//첨부파일 가져오기
		QAAttachmentsVo qaatList = qasv.seleQaat(pno);
		
		//설문 대상자 가져오기(전체대상자:: 설문참여o, x)
		List<QAParticipationVo> qaptList = qasv.selectQapt(pno);
		
		//참가인원수 가져오기
		
//		System.out.println(qavo);
//		System.out.println(qacgList);
//		System.out.println(qaptList);
//		System.out.println(qaatList);
		
		model.addAttribute("qavo", qavo);
		model.addAttribute("qacgList", qacgList);
		model.addAttribute("qaptList", qaptList);	
		model.addAttribute("qaatList", qaatList);
		
		
		return"QA/update";
	}
	
	@PostMapping("update/{pno}")
	public String update(@PathVariable String pno, Model model,HttpSession session, QAVo qavo, QACategoryVo qacg, QAAttachmentsVo qaat, HttpServletRequest req) {
		
		qavo.setQaSdate(qavo.getQaSdate().replace('T', ' '));
		qavo.setQaEdate(qavo.getQaEdate().replace('T', ' '));
		qavo.setQaNo(pno);
		qacg.setQaNo(pno);
		
//		System.out.println("-------수정페이지 Post값 넘기기-------");
//		System.out.println(qavo);
//		System.out.println(qacg);
//		System.out.println(qaat);
//		System.out.println("///////////////////////////////////");
		
		
		//기존 파일 삭제
		String savePath = req.getServletContext().getRealPath("/resources/upload/QA/");
		//MemberVo loginMember = (MemberVo)(session.getAttribute("loginMember"));
		
		//첨부파일 확인 (설문첨부파일 테이블에 등록된 파일이 있으면 update, 등록된 파일이 없으면 insert)
		QAAttachmentsVo qaatCheck = qasv.checkFile(pno);
		//System.out.println("파일 확인(정보수정post)::"+qaatCheck);
		
		//해당 게시글의 첨부파일이있으면 삭제
		//System.out.println("파일공백여부::"+!(qavo.getQaFile().isEmpty()));
		if (!(qavo.getQaFile().isEmpty())) {
			String fileName = qaat.getQaatOrigin();
			File f =  new File(savePath +  fileName);
			//System.out.println(f);
			if(f.exists()) { //파일 존재하는지 확인
				f.delete();
				//System.out.println("첨부파일(공지) 삭제완료");
			}
		}
		
		//파일 유무 확인
		if (qavo.getQaFile() != null && !qavo.getQaFile().isEmpty()) {
			//파일 있음
			//파일 업로드 후 저장된 파일명 얻기 
			String changeName = FileUploader.fileUpload(qavo.getQaFile(), savePath);
			//System.out.println(changeName);
			String originName = qavo.getQaFile().getOriginalFilename();
			//System.out.println(originName);
			qaat.setQaatChange(changeName);
			qaat.setQaatOrigin(originName);
			qaat.setQaatPath(savePath);
			qaat.setQaNo(pno);
			//System.out.println("설문파일::"+qaat);
		}else {qaat=null;}
		
		String[] qacgArr=null ;
		if (qacg.getQacgName() != null) {
			qacgArr =qacg.getQacgName().split(",");
			
		}
		
		//update(설문, 첨부파일,) 및 항목 insert (새로추가된 항목, 추가된 첨부파일)
		int result = qasv.edit(qavo, qacgArr, qaat, qaatCheck, pno);
		

		
		if (result==1) {
			session.setAttribute("toastMsg", "설문 내용 수정완료!");
			return"redirect:/QA/list/1";
		}else {return "error";}
	}
	//설문 삭제
	@GetMapping("delete/{pno}")
	public String delete(@PathVariable int pno, HttpSession session) {
		
		int result = qasv.qaDelete(pno);
		
		String toastify = "-"+pno+"번 설문 삭제-";
		
		if(result == 1) {
			session.setAttribute("toastMsg", toastify);
			return"redirect:/QA/list/1";
		}else {return "error";}
	}
	//설문 생성자 내용 끝
	//--------------------------------------------------
	
	//설문 상세보기(사용자)
	@GetMapping("detailUser/{pno}")
	public String detaiUser(@PathVariable String pno, Model model, HttpSession session) {
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		
		//번호에 맞는 설문 정보 가져오기
		QAVo qavo = qasv.selectOneQa(pno);
		
		//번호에 맞는 항목들 가져오기
		List<QACategoryVo> qacgList = qasv.selectQacg(pno);
		
		//설문 대상자 가져오기(전체대상자:: 설문참여o, x)
		List<QAParticipationVo> qaptList = qasv.selectQapt(pno);
		
		//로그인 사원이 설문 참여 대상자인지 확인(참여x)
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pno", pno);
		map.put("no", loginMember.getEmpNo());
		int check = qasv.check(map); //대상자 ::1 // 대상자x :: 0
		
		//설문지와 회원번호를 참고해서 해당 설문지에대한 사원의 답변 내용 가져오기
		//참여여부::'N' == Null
		List<QAAnswerVo> chaw = qasv.checkAnswer(map);
		//System.out.println(chaw);
		
		
		//첨부파일 가져오기
		QAAttachmentsVo qaatList = qasv.seleQaat(pno);
		
//		System.out.println(qavo);
//		System.out.println(qacgList);
//		System.out.println(qaptList);
//		System.out.println(qaatList);
		
		model.addAttribute("qavo", qavo);
		model.addAttribute("qacgList", qacgList);
		model.addAttribute("qaptList", qaptList);
		model.addAttribute("qaatList", qaatList);
		model.addAttribute("check", check);
		model.addAttribute("chaw",chaw);
		
		return "QA/detailUser";
	}
	
	//설문 답변 등록
	@PostMapping("insert/{pno}")
	@ResponseBody
	public String detailUser(@PathVariable String pno, HttpSession session ,QAParticipationVo vo, QAAnswerVo awvo){
		
		//답변 저장시 필요한것 :: 
		// 설문번호, 회원번호, 답변번호 ,답변 내용
		
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
//		System.out.println(pno);					//설문 번호
//		System.out.println(loginMember.getEmpNo());	//회원 번호
		
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pno", pno);
		map.put("no",loginMember.getEmpNo());
		

		QAParticipationVo checkpt = qasv.checkQA(map);
		
		
		//System.out.println(vo);
		//set 회원 번호, 게시글 번호, 
		vo.setQaNo(pno);
		vo.setEmpNo(loginMember.getEmpNo());
		
		
//		System.out.println("===========");
//		System.out.println(vo);
//		System.out.println(checkpt);
//		System.out.println(awvo);
		//설문 입력내용 넣기
		int result = qasv.insertUserQA(awvo, checkpt, map);
		
		if(result ==1) {
			session.setAttribute("toastMsg", "설문 작성 완료!");
			return "ok";
		}else {return"error";}
	}
	
	//답변 내용 수정
	@PostMapping("updateAw/{pno}")
	@ResponseBody
	public String updateAw(@PathVariable String pno,QAAnswerVo awvo, HttpSession session, Model model) {
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		awvo.setQaNo(pno);
//		System.out.println(pno);
//		System.out.println(awvo);
		
		int result = qasv.editAw(awvo, loginMember.getEmpNo());
		
		if (result == 1) {
			return "ok";
		}else {
			return "fail";			
		}
		
	}
	
	
}
