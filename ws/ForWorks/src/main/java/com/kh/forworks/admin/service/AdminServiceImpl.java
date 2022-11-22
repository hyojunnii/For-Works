package com.kh.forworks.admin.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.admin.dao.AdminDao;
import com.kh.forworks.admin.vo.AdminVo;
import com.kh.forworks.admin.vo.CorpInfoVo;
import com.kh.forworks.member.vo.MemberVo;

@Service
public class AdminServiceImpl implements AdminService {
	
	private final AdminDao adminDao;
	
	private final SqlSessionTemplate sst;
	
	private final PasswordEncoder pwdEnc;
	
	public AdminServiceImpl(SqlSessionTemplate sst, PasswordEncoder pwdEnc, AdminDao adminDao) {
		this.adminDao = adminDao;
		this.sst = sst;
		this.pwdEnc = pwdEnc;
	}

	//관리자 로그인
	@Override
	public AdminVo login(AdminVo vo) {
		AdminVo dbAdmin = adminDao.selectOneById(sst, vo);
		
		if(dbAdmin != null && pwdEnc.matches(vo.getManPwd(), dbAdmin.getManPwd())) {
			return dbAdmin;
		} else {
			return null;
		}
	}

	//직급테이블
	@Override
	public List<CorpInfoVo> selectPosList() {
		return adminDao.selectPosList(sst);
	}
	
	//부서테이블
	@Override
	public List<CorpInfoVo> selectDeptList() {
		return adminDao.selectDeptList(sst);
	}
	
	//구성원 신청목록 조회
	@Override
	public List<MemberVo> selectApplyList() {
		return adminDao.selectApplyList(sst);
	}

	//구성원 승인 (정보입력)
	@Override
	public int memberApprove(MemberVo vo) {
		return adminDao.updateApplyMember(sst, vo);
	}

	//구성원 승인 거절 (삭제)
	@Override
	public int deleteApply(String empNo) {
		return adminDao.deleteMemberByNo(sst, empNo);
	}

	//구성원 목록 갯수
	@Override
	public int selectListCnt(AddressVo addVo) {
		return adminDao.selectListCnt(sst, addVo);
	}

	//구성원 목록 조회
	@Override
	public List<MemberVo> memberList(PageVo pv, AddressVo addVo) {
		return adminDao.selectMemberList(sst, pv, addVo);
	}

	//운영자 현황 조회
	@Override
	public List<CorpInfoVo> selectOperList() {
		return adminDao.selectOperList(sst);
	}

	//운영자 목록 조회
	@Override
	public List<MemberVo> selectOperMember(String oplevel) {
		return adminDao.selectOperMember(sst, oplevel);
	}

	//관리자 지정 검색
	@Override
	public List<MemberVo> selectSearchMember(CorpInfoVo vo) {
		return adminDao.selectSearchMember(sst, vo);
	}

	//관리자 추가
	@Override
	public int updateOperLevel(CorpInfoVo vo) {
		return adminDao.updateOpLevelByNo(sst, vo);
	}

	//관리자 삭제
	@Override
	public int resetOpLevel(String empNo) {
		return adminDao.updateOpLevelToOne(sst, empNo);
	}

	//구성원 정보 조회 (한명)
	@Override
	public MemberVo selectedMember(String empNo) {
		return adminDao.selectMemberByNo(sst, empNo);
	}

	//구성원 정보 수정
	@Override
	public int updateMemberInfo(MemberVo vo) {
		return adminDao.updateMemberInfo(sst, vo);
	}
	
	//구성원 일시정지
	@Override
	public int updateMemberStatus(MemberVo vo) {
		return adminDao.updateMemberStatus(sst, vo);
	}

}
