package com.kh.forworks.docmanage.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.forworks.PageVo;
import com.kh.forworks.Pagination;
import com.kh.forworks.docmanage.service.DocmanageService;
import com.kh.forworks.docmanage.vo.DfileVo;
import com.kh.forworks.docmanage.vo.DocControlVo;
import com.kh.forworks.docmanage.vo.DocVo;
import com.kh.forworks.member.vo.MemberVo;

@Controller
@RequestMapping("docmanage")
public class DocmanageController {
	
	private DocmanageService ds;
	
	@Autowired
	public DocmanageController(DocmanageService ds) {
		this.ds = ds;
	}
	//일반문서 리스트(화면)
	@GetMapping("list/{pno}")
	public String list(Model model, HttpSession session ,@PathVariable int pno ) {
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");
		String deptName = loginMember.getDeptName();
		String deptNo = loginMember.getDeptNo();
		String range = deptNo+deptName;
		
		//페이징처리
		int totalCount = ds.selectRangeTotalCnt(range);
		PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 10);
		
		HashMap map = new HashMap();
		map.put("range", range);
		map.put("pv", pv);
		
		List<DocVo> result = ds.selectRangeDoc(map);
		System.out.println("출" + result);
		System.out.println("잘되는 pv" + pv);
		model.addAttribute("result",result);
		model.addAttribute("pv",pv);
		return "docManage/doc_list";
	}
	//일반문서 작성(화면)
	@GetMapping("write")
	public String write(Model model) {
	//부서 받아오기
	List<MemberVo> dept = ds.selectDept();
	model.addAttribute("dept",dept);
	return "docManage/doc_write";
	}
		
	//일반문서 디테일(화면)
	@GetMapping("detail/{no}")
	public String detail(@PathVariable String no, Model model) {
		DocVo vo = ds.selectOneDoc(no);
		System.out.println("디테일조회 " + vo);
		if(vo.getFileNo() != null) {
			DfileVo fv = ds.selectFileDoc(no);
			fv.setExt(fv.getOriginName().substring(fv.getOriginName().lastIndexOf('.')));
			model.addAttribute("fv",fv);
			System.out.println("디테일조회fv " + fv);
		}
		//작성자 조회
		MemberVo mem = ds.selectMem(no);
		model.addAttribute("mem",mem);
		model.addAttribute("vo",vo);
		return "docManage/doc_detail";
	}
	
	//문서관리(화면)
	@GetMapping("manage/{pno}")
	public String manage(Model model , @PathVariable int pno , HttpSession session) {
		//로그인 데이터 가져오기
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		if(loginMember != null) {
			String empNo = loginMember.getEmpNo();
			System.out.println(empNo);
			
			//페이징처리
			int totalCount = ds.selectTotalCnt(empNo);
			PageVo pv = Pagination.getPageVo(totalCount, pno, 5, 10);
			
			//게시글 가져오기
			HashMap map = new HashMap();
			map.put("pv", pv);
			map.put("empNo", empNo);
			List<DocVo> voList = ds.selectDocByEmp(map);
			
			
			System.out.println("gk"+(int)Math.ceil((double)1 / 10));
			
			System.out.println("voList출력" + voList);
			System.out.println("pv출력" + pv);
			model.addAttribute("voList",voList);
			model.addAttribute("pv",pv);
			return "docManage/doc_manage";		
		}else {
			session.setAttribute("toastMsg", "로그인 정보가 필요합니다.");
			return "redirect:/login";
		}
		
	}
	//테스트
	/*
	 * @GetMapping("test") public String test() { return "docManage/file_test"; }
	 * 
	 * @PostMapping("test") public String test(DocVo vo , HttpServletRequest req) {
	 * 
	 * System.out.println("called...");//swy
	 * 
	 * MultipartFile[] fArr = vo.getFile();
	 * 
	 * System.out.println(fArr[0].isEmpty());//swy
	 * System.out.println(fArr.length);//swy
	 * 
	 * if(!fArr[0].isEmpty()) { for(int i = 0 ; i <fArr.length ; i++) {
	 * MultipartFile f = fArr[i];
	 * 
	 * //원본파일명 String originName = f.getOriginalFilename(); String ext =
	 * originName.substring(originName.lastIndexOf('.'));
	 * 
	 * long now = System.currentTimeMillis(); int randomNum = (int)(Math.random() *
	 * 90000 + 1000); String changeFileName = now + "_" + randomNum;
	 * 
	 * String rootpath =
	 * req.getServletContext().getRealPath("/resources/doc-file/"); File targetFile
	 * = new File(rootpath + changeFileName + ext);
	 * 
	 * System.out.println(rootpath); System.out.println(changeFileName);
	 * System.out.println(ext);
	 * 
	 * try { f.transferTo(targetFile); } catch (Exception e) { e.printStackTrace();
	 * }
	 * 
	 * } }
	 * 
	 * return "redirect:/"; }
	 */
	
	
	
	//일반문서 작성
	@PostMapping("write")
	public String write(DocVo dv, HttpSession session , HttpServletRequest req) {
		//로그인 정보 받아오기
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		dv.setEmpNo(empNo);
		//범위
		String range3="";
		String[] range2 = dv.getRange_();
		if(range2 != null) {
			for(int i = 0 ; i < range2.length;i++) {
				range3+=range2[i]+",";
				dv.setRange(range3);
			}
		}
		
		System.out.println("called...");//swy
		  
		  MultipartFile[] fArr = dv.getFile();
		  DfileVo df = new DfileVo();
		  
		  System.out.println(fArr[0].isEmpty());//swy
		  System.out.println(fArr.length);//swy
		  
		  if(!fArr[0].isEmpty()) { 
			  for(int i = 0 ; i <fArr.length ; i++) {
		  MultipartFile f = fArr[i];
		 
		  //원본파일명 
		  String originName = f.getOriginalFilename(); 
		  String ext = originName.substring(originName.lastIndexOf('.'));
		  
		  long now = System.currentTimeMillis(); 
		  int randomNum = (int)(Math.random() *  90000 + 1000); String changeFileName = now + "_" + randomNum;
		  
		  String rootpath = req.getServletContext().getRealPath("/resources/doc-file/upload/"); 
		  File targetFile= new File(rootpath + changeFileName + ext);
		  

		  try { 
			  f.transferTo(targetFile); 
			  df.setOriginName(originName);
			  df.setUploadName(changeFileName+ext);
			  df.setFilePath(rootpath);
			 } 
		  catch (Exception e) { e.printStackTrace();
		  }
		  
		  } 
		 }
		 
		int result = ds.write(dv,df);
		if(result == 1) {
			session.setAttribute("toastMsg", "문서 등록 완료");
			return "redirect:/docmanage/manage/1";
		}else {
			session.setAttribute("toastMsg", "다시 시도해주세요");
			return "docManage/doc_write";
		}

	}
	//문서관리디테일
	@GetMapping("manDetail/{no}")
	public String manDetail(@PathVariable String no , Model model) {
		DocVo vo = ds.selectOneDoc(no);
		System.out.println("문서관리디테일1" + vo);
		if(vo.getFileNo() != null) {
			DfileVo fv = ds.selectFileDoc(no);
			fv.setExt(fv.getOriginName().substring(fv.getOriginName().lastIndexOf('.')));
			model.addAttribute("fv",fv);
			System.out.println("디테일조회fv " + fv);
		}
		model.addAttribute("vo",vo);
		return "docManage/doc_man_detail";
	}
	//문서관리디테일-게시상태수정
	@PostMapping("manDetail/{no}")
	public String manDetail(@PathVariable String no, DocVo vo , HttpSession session) {

		System.out.println(vo.getContStatus());
		vo.setDocNo(no);
		int result = ds.updateStatus(vo);
		
		if(result == 1) {
			session.setAttribute("toastMsg", "게시상태 변경 완료!");
			return "redirect:/docmanage/manage/1";
		}else {
			session.setAttribute("toastMsg", "보존기간을 확인해주세요.");
			return "docManage/doc_man_detail";
		}
	}
	//검색
	@PostMapping(value="search",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String search(String sContent, HttpSession session,Model model) {
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");
		String deptName = loginMember.getDeptName();
		String deptNo = loginMember.getDeptNo();
		String range = deptNo+deptName;
		
		HashMap map = new HashMap();
		map.put("range", range);
		map.put("sContent", sContent);
		System.out.println("출력문" + range +sContent);
		
		List<DocVo> result = ds.selectSearch(map);
		System.out.println("출력문2" +result);
		Gson g = new Gson();
		return g.toJson(result);
	}
	
}














