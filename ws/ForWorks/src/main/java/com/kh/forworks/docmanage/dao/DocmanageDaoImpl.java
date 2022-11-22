package com.kh.forworks.docmanage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.docmanage.vo.DfileVo;
import com.kh.forworks.docmanage.vo.DocVo;
import com.kh.forworks.member.vo.MemberVo;

@Repository
public class DocmanageDaoImpl implements DocmanageDao {
	//일반문서 작성
	@Override
	public int insertDoc(SqlSessionTemplate sst, DocVo dv) {
		return sst.insert("docMapper.insertDoc",dv);
	}
	//일반문서 리스트
	@Override
	public List<DocVo> selectRangeDoc(SqlSessionTemplate sst , HashMap map) {
		PageVo pv =	(PageVo) map.get("pv");
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		String range = (String) map.get("range");
		return sst.selectList("docMapper.selectRangeDoc" , range , rb);
	}
	//일반문서>파일업로드
	@Override
	public int insertDocFile(SqlSessionTemplate sst, DfileVo fv) {
		return sst.insert("docMapper.insertFile" , fv);
	}
	//전체 문서갯수조회
	@Override
	public int selectCountAll(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("docMapper.selectCountAll" , empNo);
	}
	//문서관리 리스트
	@Override
	public List<DocVo> selectDocByEmp(SqlSessionTemplate sst , HashMap map) {
		PageVo pv =	(PageVo) map.get("pv");
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		String empNo = (String) map.get("empNo");
		return sst.selectList("docMapper.selectDocByEmp" , empNo , rb);
	}
	//문서관리 디테일
	@Override
	public DocVo selectOneDoc(SqlSessionTemplate sst, String no) {
		System.out.println("======================="+no);
		return sst.selectOne("docMapper.selectOneDoc" , no);
	}
	//공개범위 받아오기
	@Override
	public List<MemberVo> selectDept(SqlSessionTemplate sst) {
		return  sst.selectList("docMapper.selectDept");
	}
	//문서작성 후 문서관리등록
	@Override
	public int insertDocControl(SqlSessionTemplate sst, DocVo dv) {
		return sst.insert("docMapper.insertControl", dv);
	}
	//전체 문서갯수조회(range)
	@Override
	public int selectRangeCountAll(SqlSessionTemplate sst , String range) {
		return sst.selectOne("docMapper.selectRangeCountAll" , range);
	}
	//당일기준 업데이트해서 비공개처리
	@Override
	public int updateRange(SqlSessionTemplate sst) {
		return sst.update("docMapper.updateRange");
	}
	//문서에 업로드된 파일가져오기
	@Override
	public DfileVo selectFileDoc(SqlSessionTemplate sst, String no) {
		return sst.selectOne("docMapper.selectFile",no);
	}
	//문서관리디테일-게시상태수정
	@Override
	public int updateStatus(SqlSessionTemplate sst, DocVo vo) {
		return sst.update("docMapper.updateStatus" , vo);
	}
	//검색
	@Override
	public List<DocVo> selectSearch(SqlSessionTemplate sst, HashMap map) {
		return sst.selectList("docMapper.search",map);
	}
	//일반문서 작성자조회
	@Override
	public MemberVo selectMem(SqlSessionTemplate sst, String no) {
		return sst.selectOne("docMapper.oneMem",no);
	}

}
