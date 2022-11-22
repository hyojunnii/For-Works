package com.kh.forworks.address.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.member.vo.MemberVo;

public interface AddressDao {
	
	int updateEmpStatByNo(SqlSessionTemplate sst, MemberVo vo);

	int insertFavoriteMember(SqlSessionTemplate sst, MemberVo vo);
	
	int deleteFavoriteMember(SqlSessionTemplate sst, MemberVo vo);
	
	int selectAddCount(SqlSessionTemplate sst, AddressVo addVo);
	
	List<MemberVo> selectAddMember(SqlSessionTemplate sst, PageVo pv, AddressVo addVo);

	int selectExAddCount(SqlSessionTemplate sst, AddressVo addVo);

	List<MemberVo> selectExAddMember(SqlSessionTemplate sst, PageVo pv, AddressVo addVo);

	int insertExMemberByNo(SqlSessionTemplate sst, AddressVo vo);

	int updateExMemberByNo(SqlSessionTemplate sst, AddressVo vo);

	int deleteExMemberByNo(SqlSessionTemplate sst, AddressVo vo);



}
