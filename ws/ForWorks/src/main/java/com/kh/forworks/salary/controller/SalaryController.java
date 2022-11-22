package com.kh.forworks.salary.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.salary.service.SalaryService;
import com.kh.forworks.salary.vo.AddBenefitVo;
import com.kh.forworks.salary.vo.SalBonusVo;
import com.kh.forworks.salary.vo.SalaryVo;

@Controller
@RequestMapping("salary")
public class SalaryController {
	
	private SalaryService ss;
	
	
	@Autowired
	public SalaryController(SalaryService ss) {
		this.ss = ss;
	}
	
	@GetMapping("main")
	public String main(HttpSession session) {
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String dept = loginMember.getDeptNo();
		if(dept.equals("2")) {
			session.setAttribute("toastMsg", "접근가능");
			return "salary/sal_main";
		}
		session.setAttribute("toastMsg", "접근권한이 없습니다.");
		return "salary/payslip";
		
	}
	//급여대장목록 (화면)
	@GetMapping("list")
	public String list(Model model) {
		List departList = ss.selectDepartList();
		model.addAttribute("departList",departList);
		return "salary/sal_list";
	}
	//급여명세서(화면)
	@GetMapping("payslip")
	public String payslip(HttpSession session) {
		//회원정보 가져오기
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		if(loginMember == null) {
			System.out.println("로그인정보없음");
			return "redirect:/login";
		}else {
			return "salary/payslip";			
		}
	}
	//급여명세서디테일(화면)
	@GetMapping("payslipDetail/{no}")
	public String payslipDetail(HttpSession session , @PathVariable String no , Model model) {
		
		SalaryVo result = ss.selectDetail(no);
		System.out.println("result출력" + result);
		
		result.setStartMonth(result.getStartMonth().substring(0,10));
		result.setEndMonth(result.getEndMonth().substring(0,10));
		
		System.out.println(result.getEndMonth());
		
		List<SalaryVo> result1 = null;
		List<SalBonusVo> result2 = null;
		if(result.getSalCate().equals("1")) {
			System.out.println("result1실행");
			result1 = ss.selectEmpSal(result);
			int a = 0;
			int sum = Integer.parseInt(result1.get(0).getEmpMoney());
			for(int i = 0 ; i < result1.size();i++) {
				a += Integer.parseInt(result1.get(i).getAmount());
				sum +=Integer.parseInt(result1.get(i).getAmount());
			}
			
			//추가수당조회
			List<AddBenefitVo> add= ss.selectAddBenefit(result);
			int ot = 0;
			int calc = 0;
			if(add != null) {
				for(int i = 0 ; i < add.size();i++) {
					ot += Integer.parseInt(add.get(i).getOverTime());
					calc += Integer.parseInt(add.get(i).getCalcAmount());
				}
				System.out.println("총 추가시간" + ot + "총 금액" + calc);
			}
			sum += calc;
			a += calc;
			result1.get(0).setAddOverTime(Integer.toString(ot));
			result1.get(0).setAddCalc(Integer.toString(calc));
			result.setAmount(Integer.toString(a));
			result.setSum(Integer.toString(sum));
			System.out.println("총"+sum+"총수당"+a );
			System.out.println(result1);
			
			result.setTax1(Integer.toString((int)(sum*0.06)));
			result.setTax2(Integer.toString((int)(sum*0.05)));
			result.setTax3(Integer.toString((int)(sum*0.04)));
			result.setTax4(Integer.toString((int)(sum*0.01)));
			
			result.setSumxtax(Integer.toString((int)(sum*0.06)+(int)(sum*0.05)+(int)(sum*0.04)+(int)(sum*0.01)));
			
			model.addAttribute("result1",result1);
		}else if(result.getSalCate().equals("2")) {
			System.out.println("result2실행");
			result2 = ss.selectBonus(result);
			int a = 0;
			for(int i = 0 ; i < result2.size();i++) {
				a += Integer.parseInt(result2.get(i).getPayment());
			}
			result.setBonusSum(Integer.toString(a));
			result.setSum(Integer.toString(a));
			
			result.setTax1(Integer.toString((int)(a*0.06)));
			result.setTax2(Integer.toString((int)(a*0.05)));
			result.setTax3(Integer.toString((int)(a*0.04)));
			result.setTax4(Integer.toString((int)(a*0.01)));
			
			result.setSumxtax(Integer.toString((int)(a*0.06)+(int)(a*0.05)+(int)(a*0.04)+(int)(a*0.01)));
			
			model.addAttribute("result2",result2);
		}else if(result.getSalCate().equals("3")) {
			System.out.println("result1실행");
			result1 = ss.selectEmpSal(result);
			int a = 0;
			int sum = Integer.parseInt(result1.get(0).getEmpMoney());
			for(int i = 0 ; i < result1.size();i++) {
				a += Integer.parseInt(result1.get(i).getAmount());
				sum +=Integer.parseInt(result1.get(i).getAmount());
			}
			result.setAmount(Integer.toString(a));
			
			System.out.println(result1);
			
			model.addAttribute("result1",result1);
			
			System.out.println("result2실행");
			result2 = ss.selectBonus(result);
			int x = 0;
			for(int i = 0 ; i < result2.size();i++) {
				x += Integer.parseInt(result2.get(i).getPayment());
				sum +=Integer.parseInt(result2.get(i).getPayment());
			}
			result.setBonusSum(Integer.toString(x));
			result.setSum(Integer.toString(sum));
			
			result.setTax1(Integer.toString((int)(sum*0.06)));
			result.setTax2(Integer.toString((int)(sum*0.05)));
			result.setTax3(Integer.toString((int)(sum*0.04)));
			result.setTax4(Integer.toString((int)(sum*0.01)));
			
			result.setSumxtax(Integer.toString((int)(sum*0.06)+(int)(sum*0.05)+(int)(sum*0.04)+(int)(sum*0.01)));
			
			model.addAttribute("result2",result2);
		}
		
		System.out.println("detail : " +result);
		
		model.addAttribute("result" , result);
		return "salary/payslipDetail";
	}
	//급여대장작성(화면)
	@GetMapping("write")
	public String write(Model model) {
		List departList = ss.selectDepartList();
		model.addAttribute("departList",departList);
		System.out.println(departList);
		return "salary/sal_write";
	}
	
	//부서별 직원조회
	@PostMapping(value="selectEmp",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String selectEmp(String depart, Model model) {
		List<MemberVo> result = ss.selectEmp(depart);
		Gson g = new Gson();
		return g.toJson(result);
	}
	
	//급여대장작성 - 상여금 불러오기
	@PostMapping(value="empBonus",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String empBonus(SalaryVo sv) {
		//해당직원 날짜 사이 상여금 조회
		List<SalBonusVo> result = ss.selectBonus(sv);
		System.out.println(result);
		Gson g = new Gson();
		return g.toJson(result);
	}
	
	//급여대장작성 - 기본급+수당
	@PostMapping(value="empSal",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String empSal(SalaryVo sv) {
		//기본급 + 각종 수당 조회
		List<SalaryVo> sal = ss.selectEmpSal(sv);
			
		//추가수당
		List<AddBenefitVo> add= ss.selectAddBenefit(sv);
		System.out.println("추가"+add);
		
		int ot = 0;
		int calc = 0;
		if(add != null) {
			for(int i = 0 ; i < add.size();i++) {
				ot += Integer.parseInt(add.get(i).getOverTime());
				calc += Integer.parseInt(add.get(i).getCalcAmount());
			}
			System.out.println("총 추가시간" + ot + "총 금액" + calc);
		}
		sal.get(0).setAddOverTime(Integer.toString(ot));
		sal.get(0).setAddCalc(Integer.toString(calc));
		
		System.out.println("기본급 : " + sal);
		Gson g = new Gson();
		return g.toJson(sal);
	}
	

	//급여대장작성
	@PostMapping("write")
	public String insertSal(SalaryVo sv, HttpSession session) {
		int result = ss.insertSal(sv);
		if(result == 1) {
			return "redirect:/salary/list";			
		}else {
			return "salary/sal_write";
		}
	}
	
	//급여대장리스트ajax
	@PostMapping(value="list" , produces = "application/json; charset=utf-8")
	@ResponseBody
	public String list(SalaryVo sv) {
		List<SalaryVo> list = ss.list(sv);
		System.out.println(list);
		Gson g = new Gson();
		return g.toJson(list);
	}
	
	//공개여부 바꾸기
	@PostMapping("status")
	@ResponseBody
	public String status(@RequestParam(value="status[]") List<Integer> status,HttpSession session) {
		System.out.println("출력 : " + status);
		int result = 0;
		for(int i = 0 ; i < status.size(); i++) {
			result = ss.status(Integer.toString(status.get(i)));
			result ++;
			System.out.println(result);
		}
		if(result == status.size()) {
			result = 1;
			session.setAttribute("toastMsg", "공개되었습니다.");
		}else {result = 0 ; }
		return "" + result;
	}
	
	//회원별 급여명세서리스트ajax
	@PostMapping(value="slipList" , produces = "application/json; charset=utf-8")
	@ResponseBody
	public String salList(HttpSession session,String year) {
		//회원정보 가져오기
		MemberVo loginMember = (MemberVo)session.getAttribute("loginMember");
		String empNo = loginMember.getEmpNo();
		HashMap map = new HashMap();
		map.put("year", year);
		map.put("empNo", empNo);
		List<SalaryVo> salList = ss.salList(map);
		Gson g = new Gson();
		return g.toJson(salList);
	}
}


















