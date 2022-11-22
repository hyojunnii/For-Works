package com.kh.forworks.admin.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.admin.vo.AdminVo;
import com.kh.forworks.admin.vo.CorpInfoVo;
import com.kh.forworks.member.vo.MemberVo;

public interface AdminDao {

	AdminVo selectOneById(SqlSessionTemplate sst, AdminVo vo);
	
	List<CorpInfoVo> selectPosList(SqlSessionTemplate sst);
	
	List<CorpInfoVo> selectDeptList(SqlSessionTemplate sst);

	List<MemberVo> selectApplyList(SqlSessionTemplate sst);

	int updateApplyMember(SqlSessionTemplate sst, MemberVo vo);

	int deleteMemberByNo(SqlSessionTemplate sst, String empNo);

	int selectListCnt(SqlSessionTemplate sst, AddressVo addVo);

	List<MemberVo> selectMemberList(SqlSessionTemplate sst, PageVo pv, AddressVo addVo);

	List<CorpInfoVo> selectOperList(SqlSessionTemplate sst);

	List<MemberVo> selectOperMember(SqlSessionTemplate sst, String oplevel);

	List<MemberVo> selectSearchMember(SqlSessionTemplate sst, CorpInfoVo vo);

	int updateOpLevelByNo(SqlSessionTemplate sst, CorpInfoVo vo);

	int updateOpLevelToOne(SqlSessionTemplate sst, String empNo);

	MemberVo selectMemberByNo(SqlSessionTemplate sst, String empNo);

	int updateMemberInfo(SqlSessionTemplate sst, MemberVo vo);

	int updateMemberStatus(SqlSessionTemplate sst, MemberVo vo);

}
