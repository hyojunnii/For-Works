package com.kh.forworks.salary.service;

import java.util.HashMap;
import java.util.List;

import com.kh.forworks.salary.vo.AddBenefitVo;
import com.kh.forworks.salary.vo.SalBonusVo;
import com.kh.forworks.salary.vo.SalaryVo;

public interface SalaryService {

	//부서조회
	List selectDepartList();
	//부서별 사원목록
	List selectEmp(String depart);
	
	//직원,날짜기준 보너스 조회
	List<SalBonusVo> selectBonus(SalaryVo sv);
	//초과수당 조회
	List<AddBenefitVo> selectAddBenefit(SalaryVo sv);
	//기본급 + 각종수당 조회
	List<SalaryVo> selectEmpSal(SalaryVo sv);
	//기본급조회
	String selectMoney(SalaryVo sv);
	
	//급여대장등록 저장
	int insertSal(SalaryVo sv);
	//급여대장리스트
	List<SalaryVo> list(SalaryVo sv);
	//공개여부 바꾸기
	int status(String no);
	
	//회원별 급여명세서
	List<SalaryVo> salList(HashMap map);
	//급여명세서 디테일조회
	SalaryVo selectDetail(String no);

}
