package com.kh.forworks.bonus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.forworks.bonus.service.BonusService;
import com.kh.forworks.bonus.vo.BenefitVo;
import com.kh.forworks.bonus.vo.BonusMemVo;
import com.kh.forworks.bonus.vo.BonusVo;
import com.kh.forworks.member.vo.MemberVo;

@Controller
@RequestMapping("bonus")
public class BonusController {
	
	private BonusService bs;
	
	@Autowired
	public BonusController(BonusService bs) {
		this.bs = bs;
	}
	
	//상여금파트
	
	//상여금목록조회(화면)
	@GetMapping("list")
	public String list(Model model) {
		List<BonusVo> voList = bs.bonusList();
		model.addAttribute("bonusList" , voList);
		return "bonus/bonus_list";
	}
	
	//상여금 해당 직원목록조회
	@GetMapping("memList/{no}")
	public String memlist(@PathVariable String no , Model model) {
		List departList = bs.selectDepartList();
		model.addAttribute("departList",departList);
		
		List<BonusMemVo> voList = bs.memList(no);
		model.addAttribute("memList", voList);
		model.addAttribute("infoNo",no);
		return "bonus/bonus_mem_list";
	}
	
	//년도별 상여금 조회
	@PostMapping(value="yearList" , produces = "application/json; charset=utf-8")
	@ResponseBody
	public String yearList(String year) {
		System.out.println(year);
		List<BonusVo> voList = bs.bonusYearList(year);
		Gson g = new Gson();
		return g.toJson(voList);
	}
	//상여금 등록ajax
	@PostMapping("add")
	@ResponseBody
	public String add(BonusVo bv) {
		System.out.println(bv);
		int result = bs.addBonus(bv);
		return ""+result;
	}
	//상여금 해당 사원 등록ajax
	@PostMapping("addEmp")
	@ResponseBody
	public String addEmp(BonusMemVo bmv) {
		System.out.println("처음 보낸 데이터 :" + bmv);
		if(bmv.getRate() != 0) {;
			int pay = bs.calc(bmv);
			bmv.setPayment(pay);
		}
		System.out.println("계산된 후 데이터 :" +bmv);
		int result = bs.addEmp(bmv);
		return ""+result;
	}
	
	
	///////////////////////////수당파트
	
	
	
	//수당관리 직원리스트 페이지
	@GetMapping("benefit")
	public String benefit(Model model) {
		List departList = bs.selectDepartList();
		
		model.addAttribute("departList",departList);
		return "bonus/benefit_list";
	}
	//수당추가
	@PostMapping("addBenefit")
	@ResponseBody
	public String addBenefit(String title) {
		System.out.println("ajax로 넘어온 title ::" + title);
		int result = bs.insertBenefit(title);
		return ""+result;
	}
	//부서별  직원조회
	@PostMapping(value="selectEmp",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String selectEmp(String depart, Model model) {
		List<MemberVo> result = bs.selectEmp(depart);
		System.out.println(result);
		Gson g = new Gson();
		return g.toJson(result);
		//1. GSON 라이브러리
		//2. g = new Gson() 객체 생성
		//3. g.toJson(데이터);
	}
	
	//직원별 수당정보조회
	@GetMapping("detail/{no}")
	public String detail(@PathVariable String no,Model model ) {
		//수당카테고리 조회
		List benefitList = bs.selectList();
		model.addAttribute("benefitList",benefitList);
		MemberVo mem = bs.selectMem(no);
		
		List<BenefitVo> bv = bs.selectOne(no);
		model.addAttribute("benefitVo",bv);
		model.addAttribute("empNo",no);
		model.addAttribute("mem",mem);
		System.out.println("출력"+bv);
		return "bonus/benefit_list_detail";
	}
	
	//직원별 수당정보수정
	@PostMapping("detail/edit")
	public String detail(Model model, BenefitVo vo) {
		System.out.println("수정된 정보 잘들어옴?" + vo);
		List<BenefitVo> updateBenefit = bs.edit(vo);
		model.addAttribute("BenefitVo", updateBenefit);
		return "redirect:/bonus/detail/" + vo.getEmpNo();
	}
	
	
}
