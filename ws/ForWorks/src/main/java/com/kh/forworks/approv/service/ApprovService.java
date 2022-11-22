package com.kh.forworks.approv.service;

import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.approv.vo.DocApprovVo;
import com.kh.forworks.approv.vo.DocFileVo;
import com.kh.forworks.approv.vo.DocFormVo;
import com.kh.forworks.approv.vo.DocSignVo;
import com.kh.forworks.member.vo.MemberVo;

public interface ApprovService {

	//미결재목록호출
	List<ApprovDocumentVo> selectApprovList(String empNo);
	//미확인 협조문서 목록 호출
	List<ApprovDocumentVo> selectCoopList(String empNo);
	//미확인 참조문서 목록 호출
	List<ApprovDocumentVo> selectReferList(String empNo);
	//반려 문서 목록 호출
	List<ApprovDocumentVo> selectRejectApprovList(String empNo);
	
	//양식 목록 호출
	List<DocFormVo> selectFormList(PageVo pv);
	
	//전자문서 작성
	int insertApprovDoc(ApprovDocumentVo vo);
		
	//회원 목록 조회
	List<MemberVo> selectMemberList();
	
	//비전자문서 작성
	int insertApprovNoElecDoc(ApprovDocumentVo vo);
	
	//결재 or 반려
	int updateApprov(DocApprovVo vo);
	
	//서명 생성
	int insertSignFile(DocSignVo vo);
	
	//서명 호출
	DocSignVo selectSignOne(MemberVo memberVo);
	
	//서명 수정
	int updateSignFile(DocSignVo vo);
	
	//문서 세부 확인시 관련자 확인
	int selectApprovDocEmpNo(ApprovDocumentVo vo);
	
	//문서 조회
	ApprovDocumentVo selectApprovDocOneByNo(ApprovDocumentVo vo);
	
	//문서 조회 결제자명단 호출
	List<ApprovDocumentVo> selectApprovMemberList(String dno);
	
	//문서 조회 협조자명단 호출
	List<ApprovDocumentVo> selectCoopMemberList(String dno);
	
	//문서 조회 결재자 서명 호출
	List<ApprovDocumentVo> selectApprovSignList(String dno);
	
	//협조문서 확인처리
	int updateDocCoopByEmpNo(ApprovDocumentVo vo);
	
	//참조문서 확인처리
	int updateDocReferByEmpNo(ApprovDocumentVo vo);
	
	//문서 작성자 확인
	int selectApprovDocEditEmpNo(ApprovDocumentVo vo);
	
	//문서 수정
	int updateApprovDoc(ApprovDocumentVo vo);
	
	//문서 삭제
	int deleteApprovDoc(DocApprovVo vo);
	
	//양식 생성
	int insertForm(DocFormVo vo);
	
	//양식 페이지 호출
	DocFormVo selectFormOne(String fno);
	
	//양식 수정
	int updateFormOne(DocFormVo vo);
	
	//양식 삭제
	int deleteFormOne(DocFormVo vo);
	
	//양식 개수
	int selectFormListCount();
	
	//양식 호출
	List<DocFormVo> selectFormListAll();
	
	//미리보기용 반환정보
	String selectFormContentOne(String formNo);
	
	//파일 받아오기
	DocFileVo selectDocFile(String adocNo);
	
	//협조 관련자 확인
	int selectCoopDocEmpNo(ApprovDocumentVo vo);
	
	//참조 관련자 확인
	int selectReferDocEmpNo(ApprovDocumentVo vo);

}
