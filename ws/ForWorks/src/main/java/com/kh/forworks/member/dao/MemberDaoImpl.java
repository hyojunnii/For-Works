package com.kh.forworks.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.member.vo.MemberVo;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public int insertEmployee(SqlSessionTemplate sst, MemberVo vo) {
		return sst.insert("memberMapper.insertEmployee", vo);
	}

	@Override
	public int countId(SqlSessionTemplate sst, String empId) {
		return sst.selectOne("memberMapper.countId", empId);
	}

	@Override
	public MemberVo selectOneById(SqlSessionTemplate sst, MemberVo vo) {
		return sst.selectOne("memberMapper.selectOneById", vo);
	}

	@Override
	public int updateFromMember(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("memberMapper.updateFromMember", vo);
	}

	@Override
	public int updateAccount(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("memberMapper.updateAccount", vo);
	}

	@Override
	public String selectIdByName(SqlSessionTemplate sst, MemberVo vo) {
		return sst.selectOne("memberMapper.selectIdByName", vo);
	}

	@Override
	public int updatePwdByNo(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("memberMapper.updatePwdByNo", vo);
	}

	@Override
	public int updateMemberProfileByNo(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("memberMapper.updateEmpProfile", vo);
	}

	@Override
	public MemberVo checkEmailMember(SqlSessionTemplate sst, MemberVo vo) {
		return sst.selectOne("memberMapper.selectOneByEmail", vo);
	}

	@Override
	public int updateProfileNull(SqlSessionTemplate sst, MemberVo loginMember) {
		return sst.update("memberMapper.updateProfileNull", loginMember);
	}

}
