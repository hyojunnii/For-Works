package com.kh.forworks.bonus.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.bonus.dao.BonusDao;
import com.kh.forworks.bonus.vo.BenefitVo;
import com.kh.forworks.bonus.vo.BonusMemVo;
import com.kh.forworks.bonus.vo.BonusVo;
import com.kh.forworks.member.vo.MemberVo;

@Service
public class BonusServiceImpl implements BonusService {
	
	private final BonusDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public BonusServiceImpl(BonusDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}

	//수당카테추가
	@Override
	public int insertBenefit(String title) {
		System.out.println(title);
		return dao.insertBenefit(sst,title);
	}
	//수당목록조회
	@Override
	public List selectList() {
		return dao.selectBenefit(sst);
	}
	//부서조회
	@Override
	public List selectDepartList() {
		return dao.selectDepart(sst);
	}
	//부서별 사원조회
	@Override
	public List selectEmp(String depart) {
		return dao.selectEmp(sst , depart);
	}
	
	//받아온 회원번호 직원의 수당조회
	@Override
	public List<BenefitVo> selectOne(String no) {
		return dao.selectOne(sst, no);
	}
	//수당 수정
	@Override
	public List<BenefitVo> edit(BenefitVo vo) {
		int result = 0;
		int no = Integer.parseInt(vo.getNo());
		if(no == 0) {
			result = dao.insertBenefitEmp(sst,vo);
		}else {
			result = dao.updateOne(sst,vo);			
		}
		List<BenefitVo> updatedBenefit = null;
		if(result ==1 ) {
			updatedBenefit = this.selectOne(vo.getEmpNo());
			System.out.println("수정 후 vo ::: " + updatedBenefit);
		}
		return updatedBenefit; 
	}
	
	
	//상여금파트
	
	//상여금 목록조회(화면)
	@Override
	public List<BonusVo> bonusList() {
		return dao.selectList(sst);
	}
	
	//상여금 등록ajax
	@Override
	public int addBonus(BonusVo bv) {
		return dao.insertBonus(sst, bv);
	}
	//년도별 상여금조회
	@Override
	public List<BonusVo> bonusYearList(String year) {
		return dao.selectYearList(sst,year);
	}
	//상여금 해당 직원조회
	@Override
	public List<BonusMemVo> memList(String no) {
		return dao.selectMem(sst, no);
	}
	//상여금 해당 직원 추가
	@Override
	public int addEmp(BonusMemVo bmv) {
		System.out.println(bmv);
		return dao.insertAddEmp(sst,bmv);
	}
	//지급율 입력시 지급액 계산
	@Override
	public int calc(BonusMemVo bmv) {
		System.out.println("처음 들어온 데이터 중 지급율" + bmv.getRate());
		return dao.selectCalc(sst, bmv);
	}
	//멤버한명조회
	@Override
	public MemberVo selectMem(String no) {
		return dao.selectMemOne(sst, no);
	}
	

}
