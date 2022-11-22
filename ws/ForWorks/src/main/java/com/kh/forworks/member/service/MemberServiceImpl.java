package com.kh.forworks.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.forworks.member.dao.MemberDao;
import com.kh.forworks.member.vo.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {
	
	private final MemberDao memberDao;
	
	private final SqlSessionTemplate sst;
	
	private final PasswordEncoder pwdEnc;
	
	@Autowired
	public MemberServiceImpl(MemberDao memberDao, SqlSessionTemplate sst, PasswordEncoder pwdEnc) {
		this.memberDao = memberDao;
		this.sst = sst;
		this.pwdEnc = pwdEnc;
	}
	
	//회원가입
	@Override
	public int memberJoin(MemberVo vo) {
		vo.encodePwd(pwdEnc);
		
		return memberDao.insertEmployee(sst, vo);
	}

	//아이디 중복확인
	@Override
	public int idCheck(String empId) {
		return memberDao.countId(sst, empId);
	}

	//로그인
	@Override
	public MemberVo memberLogin(MemberVo vo) {
		MemberVo dbMember = memberDao.selectOneById(sst, vo);
		
		if(dbMember != null && pwdEnc.matches(vo.getEmpPwd(), dbMember.getEmpPwd())) {
			return dbMember;
		} else {
			return null;
		}
	}

	//회원정보수정
	@Override
	public int memberInfoEdit(MemberVo vo) {
		return memberDao.updateFromMember(sst, vo);
	}

	//급여계좌수정
	@Override
	public int memberAccountEdit(MemberVo vo) {
		return memberDao.updateAccount(sst, vo);
	}

	//아이디 찾기
	@Override
	public String findMemberId(MemberVo vo) {
		return memberDao.selectIdByName(sst, vo);
	}

	//비밀번호 변경(마이페이지)
	@Override
	public int changePwd(MemberVo vo) {
		MemberVo dbMember = memberDao.selectOneById(sst, vo);
		
		if(dbMember != null && pwdEnc.matches(vo.getNowPwd(), dbMember.getEmpPwd())) {
			vo.setEmpNo(dbMember.getEmpNo());
			vo.encodePwd(pwdEnc);
			int result = memberDao.updatePwdByNo(sst, vo);
			return result;
		} else {
			return 0;
		}
	}

	//프로필사진 변경
	@Override
	public int updateMemberProfile(MemberVo vo) {
		return memberDao.updateMemberProfileByNo(sst, vo);
	}

	//회원 찾기 (아이디, 이름, 이메일)
	@Override
	public MemberVo checkMember(MemberVo vo) {
		return memberDao.checkEmailMember(sst, vo);
	}

	//임시비밀번호로 변경
	@Override
	public int updateTempPwd(MemberVo vo) {
		vo.encodePwd(pwdEnc);
		return memberDao.updatePwdByNo(sst, vo);
	}

	//프로필 사진 삭제
	@Override
	public int updateProfileNull(MemberVo loginMember) {
		return memberDao.updateProfileNull(sst, loginMember);
	}

}
