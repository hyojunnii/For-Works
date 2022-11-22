package com.kh.forworks.admin.service;

import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.admin.vo.AdminVo;
import com.kh.forworks.admin.vo.CorpInfoVo;
import com.kh.forworks.member.vo.MemberVo;

public interface AdminService {

	AdminVo login(AdminVo vo);

	List<CorpInfoVo> selectPosList();
	
	List<CorpInfoVo> selectDeptList();
	
	List<MemberVo> selectApplyList();
	
	int memberApprove(MemberVo vo);

	int deleteApply(String empNo);

	int selectListCnt(AddressVo addVo);

	List<MemberVo> memberList(PageVo pv, AddressVo addVo);

	List<CorpInfoVo> selectOperList();

	List<MemberVo> selectOperMember(String oplevel);

	List<MemberVo> selectSearchMember(CorpInfoVo vo);

	int updateOperLevel(CorpInfoVo vo);

	int resetOpLevel(String empNo);

	MemberVo selectedMember(String empNo);

	int updateMemberInfo(MemberVo vo);

	int updateMemberStatus(MemberVo vo);

}
