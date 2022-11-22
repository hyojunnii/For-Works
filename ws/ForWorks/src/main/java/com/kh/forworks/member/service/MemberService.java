package com.kh.forworks.member.service;

import com.kh.forworks.member.vo.MemberVo;

public interface MemberService {

	int memberJoin(MemberVo vo);

	int idCheck(String empId);

	MemberVo memberLogin(MemberVo vo);

	int memberInfoEdit(MemberVo vo);

	int memberAccountEdit(MemberVo vo);

	String findMemberId(MemberVo vo);

	int changePwd(MemberVo vo);

	int updateMemberProfile(MemberVo vo);

	MemberVo checkMember(MemberVo vo);

	int updateTempPwd(MemberVo vo);

	int updateProfileNull(MemberVo loginMember);

}
