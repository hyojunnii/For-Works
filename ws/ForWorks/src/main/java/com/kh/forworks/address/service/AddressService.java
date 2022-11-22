package com.kh.forworks.address.service;

import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.member.vo.MemberVo;

public interface AddressService {

	int updateStatus(MemberVo vo);
	
	int editFavoriteMember(MemberVo vo, String stat);
	
	int selectListCnt(AddressVo addVo);
	
	List<MemberVo> addressList(PageVo pv, AddressVo addVo);

	int selectExListCnt(AddressVo addVo);

	List<MemberVo> ExternalAddList(PageVo pv, AddressVo addVo);

	int ExMemberInsert(AddressVo vo);

	int ExMemberEdit(AddressVo vo);

	int ExMemberDelete(AddressVo vo);




}
