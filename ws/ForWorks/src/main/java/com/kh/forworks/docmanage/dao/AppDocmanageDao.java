package com.kh.forworks.docmanage.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.docmanage.vo.DocControlVo;
import com.kh.forworks.docmanage.vo.SignVo;
import com.kh.forworks.member.vo.MemberVo;

public interface AppDocmanageDao {
	//부서불러오기
	List<MemberVo> selectDept(SqlSessionTemplate sst);
	//해당직원의 전자결재문서 받아오기
	List<ApprovDocumentVo> selectDocByEmp(SqlSessionTemplate sst, HashMap mapO);
	//문서하나 불러오기-하나만못불러옴
	List<DocControlVo> selectOneDoc(SqlSessionTemplate sst, String adocNo);
	//결재관리문서등록
	int insertDocCont(SqlSessionTemplate sst, DocControlVo vo);
	//해당직원이 작성한 총 갯수
	int selectTotalCnt(SqlSessionTemplate sst, String empNo);
	//관리등록한 결재문서리스트
	List<DocControlVo> selectContDocByEmp(SqlSessionTemplate sst, HashMap map);
	//게시상태수정
	int updateStatus(SqlSessionTemplate sst, DocControlVo vo);
	//결재문서관리등록한 문서불러오기
	List<DocControlVo> selectContDetail(SqlSessionTemplate sst, String no);
	//결재문서등록 공개리스트
	List<DocControlVo> selectContDocList(SqlSessionTemplate sst, PageVo pv);
	//결재문서리스트디테일(화면)
	DocControlVo selectAdocDetail(SqlSessionTemplate sst, String no);
	//싸인+부서+직급받아오기
	List<SignVo> selectSign(SqlSessionTemplate sst, String adocNo);
	//부서,직급 받아오기
	SignVo selectMemInfo(SqlSessionTemplate sst, String empNo);
	//협조자 이름받기
	List<SignVo> selectCoo(SqlSessionTemplate sst, String adocNo);
	//파일받기
	List<ApprovDocumentVo> selectFile(SqlSessionTemplate sst, String adocNo);
	//contdoc받기
	List<DocControlVo> selectOneContDoc(SqlSessionTemplate sst, String no);
	//비전자결재문서 총갯수(직원별)
	int selectNoelectTotalCnt(SqlSessionTemplate sst, String empNo);
	//비전자결재문서리스트(직원별)
	List<DocControlVo> selectNoelectEmp(SqlSessionTemplate sst, HashMap map);
	//비전자결재문서 하나 불러오기
	DocControlVo selectOneNo(SqlSessionTemplate sst, String no);
	//비전자결재문서 문서관리상태변경
	int updateNoStatus(SqlSessionTemplate sst, DocControlVo vo);
	//비전자결재문서 게시중
	int selectNoToTalCnt(SqlSessionTemplate sst);
	//공개중 비전자결재리스트가져오기
	List<DocControlVo> selectNoList(SqlSessionTemplate sst, PageVo pv);
	//비전자결재 디테일
	DocControlVo selectNoDetail(SqlSessionTemplate sst, int no);
	//write에서 문서가져오기
	List<DocControlVo> selectNoSelectListEmp(SqlSessionTemplate sst, HashMap map);
	//write에서 문서하나선택
	List<DocControlVo> selectOneDoc2(SqlSessionTemplate sst, String adocNo);
	
	
	
}
