package com.kh.forworks.admin.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.admin.vo.AdminVo;
import com.kh.forworks.admin.vo.CorpInfoVo;
import com.kh.forworks.member.vo.MemberVo;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public AdminVo selectOneById(SqlSessionTemplate sst, AdminVo vo) {
		return sst.selectOne("adminMapper.selectOneById", vo);
	}

	@Override
	public List<CorpInfoVo> selectPosList(SqlSessionTemplate sst) {
		return sst.selectList("adminMapper.selectPosList");
	}
	
	@Override
	public List<CorpInfoVo> selectDeptList(SqlSessionTemplate sst) {
		return sst.selectList("adminMapper.selectDeptList");
	}
	
	@Override
	public List<MemberVo> selectApplyList(SqlSessionTemplate sst) {
		return sst.selectList("adminMapper.selectApplyList");
	}

	@Override
	public int updateApplyMember(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("adminMapper.updateApplyMember", vo);
	}

	@Override
	public int deleteMemberByNo(SqlSessionTemplate sst, String empNo) {
		return sst.delete("adminMapper.deleteMemberByNo", empNo);
	}

	@Override
	public int selectListCnt(SqlSessionTemplate sst, AddressVo addVo) {
		return sst.selectOne("adminMapper.selectListCnt", addVo);
	}

	@Override
	public List<MemberVo> selectMemberList(SqlSessionTemplate sst, PageVo pv, AddressVo addVo) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pv.getBoardLimit());
		
		return sst.selectList("adminMapper.selectMemberList", addVo, rowBounds);
	}

	@Override
	public List<CorpInfoVo> selectOperList(SqlSessionTemplate sst) {
		return sst.selectList("adminMapper.selectOperList");
	}

	@Override
	public List<MemberVo> selectOperMember(SqlSessionTemplate sst, String oplevel) {
		return sst.selectList("adminMapper.selectOperMember", oplevel);
	}

	@Override
	public List<MemberVo> selectSearchMember(SqlSessionTemplate sst, CorpInfoVo vo) {
		return sst.selectList("adminMapper.selectSearchMember", vo);
	}

	@Override
	public int updateOpLevelByNo(SqlSessionTemplate sst, CorpInfoVo vo) {
		return sst.update("adminMapper.updateOpLevelByNo", vo);
	}

	@Override
	public int updateOpLevelToOne(SqlSessionTemplate sst, String empNo) {
		return sst.update("adminMapper.updateOpLevelToOne", empNo);
	}

	@Override
	public MemberVo selectMemberByNo(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("adminMapper.selectMemberByNo", empNo);
	}

	@Override
	public int updateMemberInfo(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("adminMapper.updateMemberInfo", vo);
	}

	@Override
	public int updateMemberStatus(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("adminMapper.updateMemberStatus", vo);
	}

}
