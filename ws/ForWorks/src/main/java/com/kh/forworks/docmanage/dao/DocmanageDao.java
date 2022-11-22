package com.kh.forworks.docmanage.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.docmanage.vo.DfileVo;
import com.kh.forworks.docmanage.vo.DocVo;
import com.kh.forworks.member.vo.MemberVo;

public interface DocmanageDao {
	//일반문서작성
	int insertDoc(SqlSessionTemplate sst, DocVo dv);
	//일반문서리스트
	List<DocVo> selectRangeDoc(SqlSessionTemplate sst, HashMap map);
	//일반문서>파일업로드
	int insertDocFile(SqlSessionTemplate sst, DfileVo fv);
	//전체 문서갯수조회
	int selectCountAll(SqlSessionTemplate sst, String empNo);
	////문서관리 리스트
	List<DocVo> selectDocByEmp(SqlSessionTemplate sst, HashMap map);
	//문서관리 디테일
	DocVo selectOneDoc(SqlSessionTemplate sst, String no);
	//공개범위 받아오기
	List<MemberVo> selectDept(SqlSessionTemplate sst);
	//문서 작성 후 문서관리등록
	int insertDocControl(SqlSessionTemplate sst, DocVo dv);
	//전체 문서갯수조회(range)
	int selectRangeCountAll(SqlSessionTemplate sst, String range);
	//당일 기준 업데이트해서 비공개처리
	int updateRange(SqlSessionTemplate sst);
	//문서에 업로드된 파일 가져오기
	DfileVo selectFileDoc(SqlSessionTemplate sst, String no);
	//문서관리디테일-게시상태수정
	int updateStatus(SqlSessionTemplate sst, DocVo vo);
	//검색
	List<DocVo> selectSearch(SqlSessionTemplate sst, HashMap map);
	//일반문서 작성자조회
	MemberVo selectMem(SqlSessionTemplate sst, String no);

}
