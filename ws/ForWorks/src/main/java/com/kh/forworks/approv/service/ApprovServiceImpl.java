package com.kh.forworks.approv.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.dao.ApprovDao;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.approv.vo.DocApprovVo;
import com.kh.forworks.approv.vo.DocFileVo;
import com.kh.forworks.approv.vo.DocFormVo;
import com.kh.forworks.approv.vo.DocSignVo;
import com.kh.forworks.member.vo.MemberVo;

@Service
public class ApprovServiceImpl implements ApprovService {
	
	private final ApprovDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public ApprovServiceImpl(ApprovDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}
	
	//미결재목록호출
	@Override
	public List<ApprovDocumentVo> selectApprovList(String empNo) {
		return dao.selectApprovList(sst, empNo);
	}

	//미확인 협조문서 목록 호출
	@Override
	public List<ApprovDocumentVo> selectCoopList(String empNo) {
		return dao.selectCoopList(sst, empNo);
	}

	//미확인 참조문서 목록 호출
	@Override
	public List<ApprovDocumentVo> selectReferList(String empNo) {
		return dao.selectReferList(sst, empNo);
	}
	
	//반려문서 목록 호출
	@Override
	public List<ApprovDocumentVo> selectRejectApprovList(String empNo) {
		return dao.selectRejectApprovList(sst, empNo);
	}

	//양식 목록 호출
	@Override
	public List<DocFormVo> selectFormList(PageVo pv) {
		return dao.selectFormList(sst, pv);
	}

	//전자문서 생성
	@Override
	public int insertApprovDoc(ApprovDocumentVo vo) {
		
		int result = 1;
		
		int result1 = dao.insertApprovDoc(sst, vo);
		
		
		
		result = result*result1;
		
		if(vo.getDocFile().getSize()!=0) {
			result = result*dao.insertDocFile(sst, vo);
		}
		
		if(vo.getApprovMember()!=null) {
		int result2 = dao.insertDocApprove(sst, vo);
		}
		
		if(vo.getCoopMember()!=null) {
		int result3 = dao.insertDocCoop(sst, vo);
		}
		
		if(vo.getReferMember()!=null) {
		int result4 = dao.insertDocRefer(sst, vo);
		}
		
		
		
		return result;
	}

	//전자문서 결재
	@Override
	public int updateApprov(DocApprovVo vo) {
		return dao.updateDocApprov(sst, vo);
	}


	//회원 목록 조회
	@Override
	public List<MemberVo> selectMemberList() {
		return dao.selectMemberList(sst);
	}

	
	//비전자문서 작성
	@Override
	public int insertApprovNoElecDoc(ApprovDocumentVo vo) {
		
		int result1 = dao.insertNoElecApprovDoc(sst,vo);
		
		int result2 = dao.insertNoElecDoc(sst, vo);
		
		return result1*result2;
	}

	//서명 생성
	@Override
	public int insertSignFile(DocSignVo vo) {
		return dao.insertSignFile(sst, vo);
	}

	//서명 선택
	@Override
	public DocSignVo selectSignOne(MemberVo memberVo) {
		return dao.selectSignOne(sst,memberVo);
	}

	//서명 수정
	@Override
	public int updateSignFile(DocSignVo vo) {
		return dao.updateSignFile(sst, vo);
	}

	//문서 세부 확인시 관련자 확인
	@Override
	public int selectApprovDocEmpNo(ApprovDocumentVo vo) {
		return dao.selectApprovDocEmpNo(sst, vo);
	}

	//문서 조회
	@Override
	public ApprovDocumentVo selectApprovDocOneByNo(ApprovDocumentVo vo) {
		return dao.selectApprovDocOneByNo(sst, vo);
	}

	//문서 조회 결제자명단 호출
	@Override
	public List<ApprovDocumentVo> selectApprovMemberList(String dno) {
		return dao.selectApprovMemberList(sst, dno);
	}

	//문서 조회 협조자명단 호출
	@Override
	public List<ApprovDocumentVo> selectCoopMemberList(String dno) {
		return dao.selectCoopMemberList(sst, dno);
	}

	//문서 조회 결재자 서명 호출
	@Override
	public List<ApprovDocumentVo> selectApprovSignList(String dno) {
		return dao.selectApprovSignList(sst, dno);
	}

	//협조문서 확인처리
	@Override
	public int updateDocCoopByEmpNo(ApprovDocumentVo vo) {
		return dao.updateDocCoopByEmpNo(sst, vo);
	}

	//참조문서 확인처리
	@Override
	public int updateDocReferByEmpNo(ApprovDocumentVo vo) {
		return dao.updateDocReferByEmpNo(sst, vo);
	}

	//문서 작성자 확인
	@Override
	public int selectApprovDocEditEmpNo(ApprovDocumentVo vo) {
		return dao.selectApprovDocEditEmpNo(sst, vo);
	}

	//문서수정
	@Override
	public int updateApprovDoc(ApprovDocumentVo vo) {
		int result1 = dao.updateApprovDoc(sst,vo);
		int result2 = dao.updateDocApprovEdit(sst, vo);
		int result = result1*result2;
		
		if(result>1) {
			result = 1;
		}
		
		return result;
	}

	//문서삭제
	@Override
	public int deleteApprovDoc(DocApprovVo vo) {
		int result1 = dao.deleteDocApprov(sst, vo);
		int result2 = dao.deleteDocCoop(sst, vo);
		int result3 = dao.deleteDocRefer(sst, vo);
		int result4 = dao.deleteApprovDoc(sst,vo);
		int result = result1*result2*result3*result4;
		
		if(result>1) {
			result = 1;
		}
		
		return result;
	}

	//양식 생성
	@Override
	public int insertForm(DocFormVo vo) {
		return dao.insertForm(sst, vo);
	}

	//양식 선택
	@Override
	public DocFormVo selectFormOne(String fno) {
		return dao.selectFormOne(sst, fno);
	}

	//양식 수정
	@Override
	public int updateFormOne(DocFormVo vo) {
		return dao.updateFormOne(sst, vo);
	}

	//양식 삭제
	@Override
	public int deleteFormOne(DocFormVo vo) {
		return dao.deleteFormOne(sst, vo);
	}

	//양식개수
	@Override
	public int selectFormListCount() {
		return dao.selectFormListCount(sst);
	}

	//모든양식 호출
	@Override
	public List<DocFormVo> selectFormListAll() {
		return dao.selectFormListAll(sst);
	}

	//미리보기용 반환정보
	@Override
	public String selectFormContentOne(String formNo) {
		return dao.selectFormContentOne(sst, formNo);
	}

	//문서 파일 받기
	@Override
	public DocFileVo selectDocFile(String adocNo) {
		return dao.selectDocFile(sst, adocNo);
	}

	//협조 관련자 확인
	@Override
	public int selectCoopDocEmpNo(ApprovDocumentVo vo) {
		return dao.selectCoopDocEmpNo(sst, vo);
	}

	//참조 관련자 확인
	@Override
	public int selectReferDocEmpNo(ApprovDocumentVo vo) {
		return dao.selectReferDocEmpNo(sst, vo);
	}

	
	
	

}
