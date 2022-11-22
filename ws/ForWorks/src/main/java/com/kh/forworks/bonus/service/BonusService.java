package com.kh.forworks.bonus.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.bonus.vo.BenefitVo;
import com.kh.forworks.bonus.vo.BonusMemVo;
import com.kh.forworks.bonus.vo.BonusVo;
import com.kh.forworks.member.vo.MemberVo;

public interface BonusService {
	
	//수당추가
	int insertBenefit(String title);
	//수당목록조회
	List selectList();
	//부서조회
	List selectDepartList();
	//부서별 사원목록
	List selectEmp(String depart);
	//받아온 회원번호 직원의 수당조회
	List<BenefitVo> selectOne(String no);
	//수당 수정
	List<BenefitVo> edit(BenefitVo vo);
	
	//상여금 목록조회(화면)
	List<BonusVo> bonusList();
	//상여금 등록 ajax
	int addBonus(BonusVo bv);
	//년도별 상여금 조회
	List<BonusVo> bonusYearList(String year);
	//상여금 해당직원조회
	List<BonusMemVo> memList(String no);
	//상여금 해당직원 추가
	int addEmp(BonusMemVo bmv);
	//지급율 입력시 지급액계산
	int calc(BonusMemVo bmv);
	//멤버한명조회
	MemberVo selectMem(String no);
	
}
