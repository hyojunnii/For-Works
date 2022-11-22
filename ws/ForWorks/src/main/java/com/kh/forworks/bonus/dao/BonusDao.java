package com.kh.forworks.bonus.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.bonus.vo.BenefitVo;
import com.kh.forworks.bonus.vo.BonusMemVo;
import com.kh.forworks.bonus.vo.BonusVo;
import com.kh.forworks.member.vo.MemberVo;

public interface BonusDao {
	
	//수당추가
	int insertBenefit(SqlSessionTemplate sst, String title);
	//수당목록조회
	List selectBenefit(SqlSessionTemplate sst);
	//부서조회
	List selectDepart(SqlSessionTemplate sst);
	//부서별 사원조회
	List selectEmp(SqlSessionTemplate sst, String depart);
	//받아온 회원번호 직원의 수당조회
	List<BenefitVo> selectOne(SqlSessionTemplate sst, String no);
	//수당수정
	int updateOne(SqlSessionTemplate sst, BenefitVo vo);
	//직원의 수당내역등록
	int insertBenefitEmp(SqlSessionTemplate sst, BenefitVo vo);

	//상여금 목록조회(화면)
	List<BonusVo> selectList(SqlSessionTemplate sst);
	//상여금 등록 ajax
	int insertBonus(SqlSessionTemplate sst, BonusVo bv);
	//년도별 상여금 조회
	List<BonusVo> selectYearList(SqlSessionTemplate sst, String year);
	//상여금 해당 직원조회
	List<BonusMemVo> selectMem(SqlSessionTemplate sst, String no);
	//상여금 해당 직원추가
	int insertAddEmp(SqlSessionTemplate sst, BonusMemVo bmv);
	//지급율 입력시 지급액 계산
	int selectCalc(SqlSessionTemplate sst,BonusMemVo bmv);
	//멤버한명조회
	MemberVo selectMemOne(SqlSessionTemplate sst, String no);

}
