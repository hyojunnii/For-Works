package com.kh.forworks.member.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.member.vo.MemberVo;

public interface MemberDao {

	int insertEmployee(SqlSessionTemplate sst, MemberVo vo);

	int countId(SqlSessionTemplate sst, String empId);

	MemberVo selectOneById(SqlSessionTemplate sst, MemberVo vo);

	int updateFromMember(SqlSessionTemplate sst, MemberVo vo);

	int updateAccount(SqlSessionTemplate sst, MemberVo vo);

	String selectIdByName(SqlSessionTemplate sst, MemberVo vo);

	int updatePwdByNo(SqlSessionTemplate sst, MemberVo vo);

	int updateMemberProfileByNo(SqlSessionTemplate sst, MemberVo vo);

	MemberVo checkEmailMember(SqlSessionTemplate sst, MemberVo vo);

	int updateProfileNull(SqlSessionTemplate sst, MemberVo loginMember);

}
