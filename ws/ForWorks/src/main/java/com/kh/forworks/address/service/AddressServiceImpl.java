package com.kh.forworks.address.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.dao.AddressDao;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.member.vo.MemberVo;

@Service
public class AddressServiceImpl implements AddressService {
	
	private final AddressDao addressDao;
	
	private final SqlSessionTemplate sst;
	
	public AddressServiceImpl(SqlSessionTemplate sst, AddressDao addressDao) {
		this.addressDao = addressDao;
		this.sst = sst;
	}

	//상태등록
	@Override
	public int updateStatus(MemberVo vo) {
		return addressDao.updateEmpStatByNo(sst, vo);
	}
	
	//즐겨찾기
	@Override
	public int editFavoriteMember(MemberVo vo, String stat) {
		if ("insert".equals(stat)) {
			return addressDao.insertFavoriteMember(sst, vo);
		} else {
			return addressDao.deleteFavoriteMember(sst, vo);
		}
	}
	
	//주소록갯수조회
	@Override
	public int selectListCnt(AddressVo addVo) {
		return addressDao.selectAddCount(sst, addVo);
	}

	//주소록조회
	@Override
	public List<MemberVo> addressList(PageVo pv, AddressVo addVo) {
		return addressDao.selectAddMember(sst, pv, addVo);
	}

	//외부주소록갯수조회
	@Override
	public int selectExListCnt(AddressVo addVo) {
		return addressDao.selectExAddCount(sst, addVo);
	}

	//외부주소록조회
	@Override
	public List<MemberVo> ExternalAddList(PageVo pv, AddressVo addVo) {
		return addressDao.selectExAddMember(sst, pv, addVo);
	}

	//외부주소록추가
	@Override
	public int ExMemberInsert(AddressVo vo) {
		return addressDao.insertExMemberByNo(sst, vo);
	}

	//외부주소록수정
	@Override
	public int ExMemberEdit(AddressVo vo) {
		return addressDao.updateExMemberByNo(sst, vo);
	}

	//외부주소록삭제
	@Override
	public int ExMemberDelete(AddressVo vo) {
		return addressDao.deleteExMemberByNo(sst, vo);
	}
	



}
