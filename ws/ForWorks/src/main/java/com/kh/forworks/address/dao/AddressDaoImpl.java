package com.kh.forworks.address.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.address.vo.AddressVo;
import com.kh.forworks.member.vo.MemberVo;

@Repository
public class AddressDaoImpl implements AddressDao {

	@Override
	public int updateEmpStatByNo(SqlSessionTemplate sst, MemberVo vo) {
		return sst.update("addressMapper.updateEmpStatByNo", vo);
	}
	
	@Override
	public int insertFavoriteMember(SqlSessionTemplate sst, MemberVo vo) {
		return sst.insert("addressMapper.insertBookmark", vo);
	}
	
	@Override
	public int deleteFavoriteMember(SqlSessionTemplate sst, MemberVo vo) {
		return sst.delete("addressMapper.deleteBookmark", vo);
	}
	
	@Override
	public int selectAddCount(SqlSessionTemplate sst, AddressVo addVo) {
		return sst.selectOne("addressMapper.selectAddCount", addVo);
	}
	
	@Override
	public List<MemberVo> selectAddMember(SqlSessionTemplate sst, PageVo pv, AddressVo addVo) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pv.getBoardLimit());
		
		return sst.selectList("addressMapper.selectAddMember", addVo, rowBounds);
	}

	@Override
	public int selectExAddCount(SqlSessionTemplate sst, AddressVo addVo) {
		return sst.selectOne("addressMapper.selectExCount", addVo);
	}

	@Override
	public List<MemberVo> selectExAddMember(SqlSessionTemplate sst, PageVo pv, AddressVo addVo) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pv.getBoardLimit());
		
		return sst.selectList("addressMapper.selectExMember", addVo, rowBounds);
	}

	@Override
	public int insertExMemberByNo(SqlSessionTemplate sst, AddressVo vo) {
		return sst.insert("insertAddressByNo", vo);
	}

	@Override
	public int updateExMemberByNo(SqlSessionTemplate sst, AddressVo vo) {
		return sst.update("updateAddressByNo", vo);
	}

	@Override
	public int deleteExMemberByNo(SqlSessionTemplate sst, AddressVo vo) {
		return sst.delete("deleteAddressByNo", vo);
	}






}
