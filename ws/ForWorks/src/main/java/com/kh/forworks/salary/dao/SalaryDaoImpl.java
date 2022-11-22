package com.kh.forworks.salary.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.salary.vo.AddBenefitVo;
import com.kh.forworks.salary.vo.SalBonusVo;
import com.kh.forworks.salary.vo.SalaryVo;

@Repository
public class SalaryDaoImpl implements SalaryDao {
	//부서명 조회
	@Override
	public List selectDepart(SqlSessionTemplate sst) {
		return sst.selectList("bonusMapper.selectDepart");
	}
	//부서별 직원조회
	@Override
	public List selectEmp(SqlSessionTemplate sst, String depart) {
		return sst.selectList("bonusMapper.selectEmp" , depart);
	}
	//직원,날짜로 보너스조회
	@Override
	public List<SalBonusVo> selectBonus(SqlSessionTemplate sst, SalaryVo sv) {
		System.out.println(sv.getStartMonth());
		System.out.println(sv.getEndMonth());
		return sst.selectList("salaryMapper.selectBonus", sv);
	}
	//초과수당조회
	@Override
	public List<AddBenefitVo> selectAddBenefit(SqlSessionTemplate sst, SalaryVo sv) {
		return sst.selectList("salaryMapper.selectBenefit",sv);
	}
	//기본급 + 각종 수당 조회
	@Override
	public List<SalaryVo> selectSalary(SqlSessionTemplate sst, SalaryVo sv) {
		return sst.selectList("salaryMapper.selectSalary" , sv);
	}
	//급여대장작성 저장
	@Override
	public int insertSal(SqlSessionTemplate sst, SalaryVo sv) {
		return sst.insert("salaryMapper.insertSal" , sv);
	}
	//급여대장리스트
	@Override
	public List<SalaryVo> selectList(SqlSessionTemplate sst, SalaryVo sv) {
		return sst.selectList("salaryMapper.selectList" , sv);
	}
	//공개여부 바꾸기
	@Override
	public int updateStatus(SqlSessionTemplate sst, String no) {
		return sst.update("salaryMapper.updateStatus" , no);
	}
	//회원별 급여명세서조회
	@Override
	public List<SalaryVo> selectSalList(SqlSessionTemplate sst,HashMap map) {
		return sst.selectList("salaryMapper.salList" , map);
	}
	//급여명세서 디테일조회
	@Override
	public SalaryVo selectDetail(SqlSessionTemplate sst, String no) {
		return sst.selectOne("salaryMapper.detail" , no);
	}
	//기본급 조회
	@Override
	public String selectMoney(SqlSessionTemplate sst, SalaryVo sv) {
		return sst.selectOne("salaryMapper.money", sv);
	}

}
