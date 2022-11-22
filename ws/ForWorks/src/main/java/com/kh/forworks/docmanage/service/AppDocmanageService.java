package com.kh.forworks.docmanage.service;

import java.util.HashMap;
import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.docmanage.vo.DocControlVo;
import com.kh.forworks.docmanage.vo.SignVo;
import com.kh.forworks.member.vo.MemberVo;

public interface AppDocmanageService {
	//부서 불러오기
	List<MemberVo> selectDept();
	//해당직원의 전자결재문서 가져오기
	List<ApprovDocumentVo> selectDocByEmp(HashMap map);
	//문서하나불러오기--하나만 못불러옴
	List<DocControlVo> selectOneDoc(String adocNo);
	//결재문서관리등록
	int insertDocCont(DocControlVo vo);
	//해당직원이 작성한 총갯수
	int selectTotalCnt(String empNo);
	//해당직원 작성 결재문서가져오기
	List<DocControlVo> selectContDocByEmp(HashMap map);
	//게시상태수정
	int updateStatus(DocControlVo vo);
	//결재문서관리등록한 문서불러오기
	List<DocControlVo> selectContDetail(String no);
	//결재문서등록 공개 리스트
	List<DocControlVo> selectContDocList(PageVo pv);
	//결재문서리스트디테일(화면)
	DocControlVo selectAdocDetail(String no);
	//싸인받아오기
	List<SignVo> selectSign(String adocNo);
	//부서,직급,싸인 받아오기
	SignVo selectMemInfo(String empNo);
	//협조자 이름받기
	List<SignVo> selectCooList(String string);
	//파일받기
	List<ApprovDocumentVo> selectFile(String adocNo);
	//contdoc받기
	List<DocControlVo> selectOneContDoc(String no);
	//비전자결재 총갯수(직원별)
	int selectNoelctTotalCnt(String empNo);
	//비전자결재문서불러오기(직원별)
	List<DocControlVo> selectNoelectEmp(HashMap map);
	//비전자결재문서 하나 불러오기
	DocControlVo selectOneNo(String no);
	//비전자결재문서 문서관리상태변경
	int updateNoStatus(DocControlVo vo);
	//비전자결재 게시중 전체갯수
	int selectNoTotalCnt();
	//공개중 비전자결재 가져오기
	List<DocControlVo> selectNoCnt(PageVo pv);
	//비전자결재 디테일
	DocControlVo selectNoDetail(int no);
	//write에서 문서목록가져오기
	List<DocControlVo> selectNoSelectListEmp(HashMap map);
	//write에서 비전자선택
	List<DocControlVo> selectOneDoc2(String adocNo);

}
