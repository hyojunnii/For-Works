package com.kh.forworks.approv.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.approv.vo.DocApprovVo;
import com.kh.forworks.approv.vo.DocFileVo;
import com.kh.forworks.approv.vo.DocFormVo;
import com.kh.forworks.approv.vo.DocSignVo;
import com.kh.forworks.member.vo.MemberVo;

@Repository
public class ApprovDaoImpl implements ApprovDao {

	//미결재 문서 조회
	@Override
	public List<ApprovDocumentVo> selectApprovList(SqlSessionTemplate sst, String empNo) {
		return sst.selectList("approvMapper.selectApprovList", empNo);
	}
	//미확인 협조 문서 조회
	@Override
	public List<ApprovDocumentVo> selectCoopList(SqlSessionTemplate sst, String empNo) {
		return sst.selectList("approvMapper.selectCoopList", empNo);
	}
	//미확인 참조 문서 조회
	@Override
	public List<ApprovDocumentVo> selectReferList(SqlSessionTemplate sst, String empNo) {
		return sst.selectList("approvMapper.selectReferList", empNo);
	}
	//반려문서 목록 호출
	@Override
	public List<ApprovDocumentVo> selectRejectApprovList(SqlSessionTemplate sst, String empNo) {
		return sst.selectList("approvMapper.selectRejectApprovList", empNo);
	}

	//회원 목록 조회
	@Override
	public List<MemberVo> selectMemberList(SqlSessionTemplate sst) {
		return sst.selectList("approvMapper.selectMemberList");
	}
	
	//결재문서 생성
	@Override
	public int insertApprovDoc(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertApprovDoc", vo);
	}
	
	//작성한 문서 번호 조회
	@Override
	public int selectDocNoOneByContent(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.selectOne("approvMapper.selectDocNoOneByContent", vo);
	}
	
	//전자결재자 삽입
	@Override
	public int insertDocApprove(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertDocApprove",vo);
	}
	
	//문서협조자 삽입
	@Override
	public int insertDocCoop(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertDocCoop",vo);
	}
	
	//문서 참조자 삽입
	@Override
	public int insertDocRefer(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertDocRefer",vo);
	}
	
	//문서 첨부파일 삽입
	@Override
	public int insertDocFile(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertDocFile",vo);
	}
	
	//비전자문서 파일 삽입
	@Override
	public int insertNoElecDoc(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertNoElecDoc", vo);
	}
	
	//비전자문서 삽입
	@Override
	public int insertNoElecApprovDoc(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.insert("approvMapper.insertNoElecApprovDoc", vo);
	}
	
	//문서 결제
	@Override
	public int updateDocApprov(SqlSessionTemplate sst, DocApprovVo vo) {
		return sst.update("approvMapper.updateDocApprov", vo);
	}
	
	//서명 생성
	@Override
	public int insertSignFile(SqlSessionTemplate sst, DocSignVo vo) {
		return sst.insert("approvMapper.insertSignFile", vo);
	}
	
	//서명 선택
	@Override
	public DocSignVo selectSignOne(SqlSessionTemplate sst, MemberVo memberVo) {
		return sst.selectOne("approvMapper.selectSignOne", memberVo);
	}
	
	//서명 수정
	@Override
	public int updateSignFile(SqlSessionTemplate sst, DocSignVo vo) {
		return sst.update("approvMapper.updateSignOne", vo);
	}
	
	//문서 세부 확인시 관련자 확인
	@Override
	public int selectApprovDocEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.selectOne("approvMapper.selectApprovDocEmpNo", vo);
	}
	
	//문서 조회
	@Override
	public ApprovDocumentVo selectApprovDocOneByNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.selectOne("approvMapper.selectApprovDocOneByNo", vo);
	}
	
	//문서 조회 결제자명단 호출
	@Override
	public List<ApprovDocumentVo> selectApprovMemberList(SqlSessionTemplate sst, String dno) {
		return sst.selectList("approvMapper.selectApprovMemberListByAdocNo", dno);
	}
	
	//문서 조회 협조자명단 호출
	@Override
	public List<ApprovDocumentVo> selectCoopMemberList(SqlSessionTemplate sst, String dno) {
		return sst.selectList("approvMapper.selectCoopMemberListByAdocNo", dno);
	}
	
	//문서 조회 결재자 서명 호출
	@Override
	public List<ApprovDocumentVo> selectApprovSignList(SqlSessionTemplate sst, String dno) {
		List<ApprovDocumentVo> resultList = sst.selectList("approvMapper.selectSignOneByAdocNo", dno);
		resultList.addAll(sst.selectList("approvMapper.selectSignListByAdocNo", dno));
		return resultList;
	}
	
	//협조문서 확인처리
	@Override
	public int updateDocCoopByEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.update("approvMapper.updateDocCoopByEmpNo", vo);
	}
	
	//협조문서 확인처리
	@Override
	public int updateDocReferByEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.update("approvMapper.updateDocReferByEmpNo", vo);
	}
	
	//문서 작성자 확인
	@Override
	public int selectApprovDocEditEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.selectOne("approvMapper.selectApprovDocEditEmpNo", vo);
	}
	//문서 수정
	@Override
	public int updateApprovDoc(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.update("approvMapper.updateApprovDoc", vo);
	}
	
	//문서 결제 초기화
	@Override
	public int updateDocApprovEdit(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.update("approvMapper.updateDocApprovEdit", vo);
	}
	
	//문서 삭제
	@Override
	public int deleteApprovDoc(SqlSessionTemplate sst, DocApprovVo vo) {
		return sst.delete("approvMapper.deleteApprovDoc", vo);
	}
	
	//문서 결제선 삭제
	@Override
	public int deleteDocApprov(SqlSessionTemplate sst, DocApprovVo vo) {
		return sst.delete("approvMapper.deleteDocApprov", vo);
	}
	
	//협조 삭제
	@Override
	public int deleteDocCoop(SqlSessionTemplate sst, DocApprovVo vo) {
		return sst.delete("approvMapper.deleteDocCoop", vo);
	}
	
	//참조 삭제
	@Override
	public int deleteDocRefer(SqlSessionTemplate sst, DocApprovVo vo) {
		return sst.delete("approvMapper.deleteDocRefer", vo);
	}
	
	//양식 생성
	@Override
	public int insertForm(SqlSessionTemplate sst, DocFormVo vo) {
		return sst.insert("approvMapper.insertForm", vo);
	}
	
	//양식 페이지 리스트 호출
	@Override
	public List<DocFormVo> selectFormList(SqlSessionTemplate sst, PageVo pv) {
		
		int offset = (pv.getCurrentPage()-1)*pv.getBoardLimit();	
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		
		return sst.selectList("approvMapper.selectFormList", null, rb);
	}
	
	//양식 선택
	@Override
	public DocFormVo selectFormOne(SqlSessionTemplate sst, String fno) {
		return sst.selectOne("approvMapper.selectFormOne", fno);
	}
	
	//양식 수정
	@Override
	public int updateFormOne(SqlSessionTemplate sst, DocFormVo vo) {
		return sst.update("approvMapper.updateFormOne", vo);
	}
	
	//양식 삭제
	@Override
	public int deleteFormOne(SqlSessionTemplate sst, DocFormVo vo){
		return sst.delete("approvMapper.deleteFormOne", vo);
	}
	
	//양식 개수
	@Override
	public int selectFormListCount(SqlSessionTemplate sst) {
		return sst.selectOne("approvMapper.selectFormListCount");
	}
	
	//양식 리스트 호출
	@Override
	public List<DocFormVo> selectFormListAll(SqlSessionTemplate sst) {
		return sst.selectList("approvMapper.selectFormList");
	}
	
	//미리보기용 양식내용
	@Override
	public String selectFormContentOne(SqlSessionTemplate sst, String formNo) {
		return sst.selectOne("approvMapper.selectFormContentOne", formNo);
	}
	
	//문서파일받아오기
	@Override
	public DocFileVo selectDocFile(SqlSessionTemplate sst, String adocNo) {
		return sst.selectOne("approvMapper.selectDocFile", adocNo);
	}
	
	//협조 관련자 확인
	@Override
	public int selectCoopDocEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.selectOne("approvMapper.selectCoopDocEmpNo", vo);
	}
	
	//참조 관련자 확인
	@Override
	public int selectReferDocEmpNo(SqlSessionTemplate sst, ApprovDocumentVo vo) {
		return sst.selectOne("approvMapper.selectReferDocEmpNo", vo);
	}
}
