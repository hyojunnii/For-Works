package com.kh.forworks.bonus.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.bonus.vo.BenefitVo;
import com.kh.forworks.bonus.vo.BonusMemVo;
import com.kh.forworks.bonus.vo.BonusVo;
import com.kh.forworks.member.vo.MemberVo;

@Repository
public class BonusDaoImpl implements BonusDao {

	//수당추가
	@Override
	public int insertBenefit(SqlSessionTemplate sst, String title) {
		return sst.insert("bonusMapper.addBenefit" , title);
	}
	//수당목록조회
	@Override
	public List selectBenefit(SqlSessionTemplate sst) {
		return sst.selectList("bonusMapper.selectBenefit");
	}
	//부서조회
	@Override
	public List selectDepart(SqlSessionTemplate sst) {
		return sst.selectList("bonusMapper.selectDepart");
	}
	//부서별 사원조회
	@Override
	public List selectEmp(SqlSessionTemplate sst , String depart) {
		return sst.selectList("bonusMapper.selectEmp" , depart);
	}
	//받아온 회원번호 직원의 수당조회
	@Override
	public List<BenefitVo> selectOne(SqlSessionTemplate sst, String no) {
		return sst.selectList("bonusMapper.selectOne" , no);
	}
	//수당수정
	@Override
	public int updateOne(SqlSessionTemplate sst, BenefitVo vo) {
		return sst.update("bonusMapper.updateOne" , vo);
	}
	//직원의 수당정보등록
	@Override
	public int insertBenefitEmp(SqlSessionTemplate sst, BenefitVo vo) {
		return sst.insert("bonusMapper.insertBenefit" , vo);
	}
	
	//상여금파트
	
	//상여금 목록조회(화면)
	@Override
	public List<BonusVo> selectList(SqlSessionTemplate sst) {
		return sst.selectList("bonusMapper.bonusList");
	}
	//상여금 등록 ajax
	@Override
	public int insertBonus(SqlSessionTemplate sst,BonusVo bv) {
		return sst.insert("bonusMapper.insertBonus" , bv);
	}
	//년도별 상여금 조회
	@Override
	public List<BonusVo> selectYearList(SqlSessionTemplate sst, String year) {
		return sst.selectList("bonusMapper.selectYearList" , year);
	}
	//상여금 해당 직원조회
	@Override
	public List<BonusMemVo> selectMem(SqlSessionTemplate sst, String no) {
		return sst.selectList("bonusMapper.selectMemList", no);
	}
	//상여금 해당 직원추가
	@Override
	public int insertAddEmp(SqlSessionTemplate sst, BonusMemVo bmv) {
		System.out.println("dao에서 bmv" + bmv);
		int result = sst.insert("bonusMapper.insertAddEmp" , bmv);
		System.out.println(result);
		return result;
	}
	//지급율 입력시 지급액계산
	@Override
	public int selectCalc(SqlSessionTemplate sst,BonusMemVo bmv) {
		System.out.println("들어온 지급율 DAO : "+ bmv.getRate());
		System.out.println("들어온 직원번호 DAO : "+bmv.getEmpNo());
		int result = sst.selectOne("bonusMapper.selectCalc", bmv);
		System.out.println("계산된 값" + result);
		return result;
	}
	//멤버한명조회
	@Override
	public MemberVo selectMemOne(SqlSessionTemplate sst, String no) {
		return sst.selectOne("bonusMapper.selectMemOne" , no);
	}

}
