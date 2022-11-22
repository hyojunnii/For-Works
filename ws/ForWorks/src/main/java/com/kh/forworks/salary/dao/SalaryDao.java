package com.kh.forworks.salary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.salary.vo.AddBenefitVo;
import com.kh.forworks.salary.vo.SalBonusVo;
import com.kh.forworks.salary.vo.SalaryVo;

public interface SalaryDao {
	//부서명 조회
	List selectDepart(SqlSessionTemplate sst);
	//부서별 직원조회
	List selectEmp(SqlSessionTemplate sst, String depart);
	//직원,날짜별 보너스 조회
	List<SalBonusVo> selectBonus(SqlSessionTemplate sst, SalaryVo sv);
	//초과수당 조회
	List<AddBenefitVo> selectAddBenefit(SqlSessionTemplate sst, SalaryVo sv);
	//기본급 + 각종 수당 조회
	List<SalaryVo> selectSalary(SqlSessionTemplate sst, SalaryVo sv);
	//기본급 조회
	String selectMoney(SqlSessionTemplate sst, SalaryVo sv);
	//급여대장등록 저장
	int insertSal(SqlSessionTemplate sst, SalaryVo sv);
	//급여대장리스트
	List<SalaryVo> selectList(SqlSessionTemplate sst, SalaryVo sv);
	//공개여부 바꾸기
	int updateStatus(SqlSessionTemplate sst, String no);
	//회원별 급여명세서 조회
	List<SalaryVo> selectSalList(SqlSessionTemplate sst, HashMap map);
	//급여명세서 디테일조회
	SalaryVo selectDetail(SqlSessionTemplate sst, String no);

}
