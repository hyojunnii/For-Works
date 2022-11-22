package com.kh.forworks.approv.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.approv.vo.DocApprovVo;
import com.kh.forworks.approv.vo.DocFileVo;
import com.kh.forworks.approv.vo.DocFormVo;
import com.kh.forworks.approv.vo.DocSignVo;
import com.kh.forworks.member.vo.MemberVo;

public interface ApprovDao {

	//미결재목록호출
	List<ApprovDocumentVo> selectApprovList(SqlSessionTemplate sst, String empNo);

	//미확인 협조문서 목록 호출
	List<ApprovDocumentVo> selectCoopList(SqlSessionTemplate sst, String empNo);

	//미확인 참조문서 목록 호출
	List<ApprovDocumentVo> selectReferList(SqlSessionTemplate sst, String empNo);
	
	//반려 문서 목록 호출
	List<ApprovDocumentVo> selectRejectApprovList(SqlSessionTemplate sst, String empNo);

	//회원 목록 조회
	List<MemberVo> selectMemberList(SqlSessionTemplate sst);

	//결재문서 작성
	int insertApprovDoc(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//작성된 문서 번호 가져오기
	int selectDocNoOneByContent(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//전자결재자 삽입
	int insertDocApprove(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서협조자 삽입	
	int insertDocCoop(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서참조자 삽입	
	int insertDocRefer(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 첨부파일 삽입
	int insertDocFile(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//비전자문서 파일 업로드
	int insertNoElecDoc(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//비전자문서 삽입
	int insertNoElecApprovDoc(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 결제
	int updateDocApprov(SqlSessionTemplate sst, DocApprovVo vo);

	//서명 생성
	int insertSignFile(SqlSessionTemplate sst, DocSignVo vo);

	//서명 호출
	DocSignVo selectSignOne(SqlSessionTemplate sst, MemberVo memberVo);

	//서명 수정
	int updateSignFile(SqlSessionTemplate sst, DocSignVo vo);
	
	//문서 세부 확인시 관련자 확인
	int selectApprovDocEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 조회
	ApprovDocumentVo selectApprovDocOneByNo(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 조회 결제자명단 호출
	List<ApprovDocumentVo> selectApprovMemberList(SqlSessionTemplate sst, String dno);

	//문서 조회 협조자명단 호출
	List<ApprovDocumentVo> selectCoopMemberList(SqlSessionTemplate sst, String dno);

	//문서 조회 결재자 서명 호출
	List<ApprovDocumentVo> selectApprovSignList(SqlSessionTemplate sst, String dno);

	//협조문서 확인처리
	int updateDocCoopByEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//참조문서 확인처리
	int updateDocReferByEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 작성자 호출
	int selectApprovDocEditEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 수정
	int updateApprovDoc(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 결재 정보 초기화
	int updateDocApprovEdit(SqlSessionTemplate sst, ApprovDocumentVo vo);

	//문서 삭제
	int deleteApprovDoc(SqlSessionTemplate sst, DocApprovVo vo);

	//결제 삭제
	int deleteDocApprov(SqlSessionTemplate sst, DocApprovVo vo);

	//협조 삭제
	int deleteDocCoop(SqlSessionTemplate sst, DocApprovVo vo);

	//참조 삭제
	int deleteDocRefer(SqlSessionTemplate sst, DocApprovVo vo);

	//양식 생성
	int insertForm(SqlSessionTemplate sst, DocFormVo vo);

	//양식 페이지 호출
	List<DocFormVo> selectFormList(SqlSessionTemplate sst, PageVo pv);

	//양식 선택
	DocFormVo selectFormOne(SqlSessionTemplate sst, String fno);

	//양식 수정
	int updateFormOne(SqlSessionTemplate sst, DocFormVo vo);

	//양식 삭제
	int deleteFormOne(SqlSessionTemplate sst, DocFormVo vo);

	//양식 갯수
	int selectFormListCount(SqlSessionTemplate sst);

	//양식 리스트 호출
	List<DocFormVo> selectFormListAll(SqlSessionTemplate sst);

	//미리보기용 양식내용
	String selectFormContentOne(SqlSessionTemplate sst, String formNo);

	//문서 파일 받아오기
	DocFileVo selectDocFile(SqlSessionTemplate sst, String adocNo);

	//협조 관련자 확인
	int selectCoopDocEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo);
	
	//참조 관련자 확인
	int selectReferDocEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo);

}
