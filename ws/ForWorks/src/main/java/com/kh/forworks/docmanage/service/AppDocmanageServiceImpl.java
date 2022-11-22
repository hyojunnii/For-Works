package com.kh.forworks.docmanage.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.docmanage.dao.AppDocmanageDao;
import com.kh.forworks.docmanage.vo.DocControlVo;
import com.kh.forworks.docmanage.vo.SignVo;
import com.kh.forworks.member.vo.MemberVo;

@Service
public class AppDocmanageServiceImpl implements AppDocmanageService{
	private final AppDocmanageDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public AppDocmanageServiceImpl(AppDocmanageDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}
	//부서 불러오기
	@Override
	public List<MemberVo> selectDept() {
		return dao.selectDept(sst);
	}
	//해당직원의 전자결재문서 받아오기
	@Override
	public List<ApprovDocumentVo> selectDocByEmp(HashMap map) {
		return dao.selectDocByEmp(sst,map);
	}
	//문서하나불러오기--하나만 못불러옴
	@Override
	public List<DocControlVo> selectOneDoc(String adocNo) {
		return dao.selectOneDoc(sst,adocNo);
	}
	//결재문서관리등록
	@Override
	public int insertDocCont(DocControlVo vo) {
		return dao.insertDocCont(sst,vo);
	}
	//해당직원이 작성한 총갯수
	@Override
	public int selectTotalCnt(String empNo) {
		return dao.selectTotalCnt(sst,empNo);
	}
	//문서관리등록한 결재문서보기
	@Override
	public List<DocControlVo> selectContDocByEmp(HashMap map) {
		return dao.selectContDocByEmp(sst,map);
	}
	//게시상태수정
	@Override
	public int updateStatus(DocControlVo vo) {
		return dao.updateStatus(sst,vo);
	}
	//결재문서관리등록한 문서불러오기
	@Override
	public List<DocControlVo> selectContDetail(String no) {
		return dao.selectContDetail(sst,no);
	}
	//결재문서등록 공개리스트
	@Override
	public List<DocControlVo> selectContDocList(PageVo pv) {
		return dao.selectContDocList(sst,pv);
	}
	//결재문서리스트디테일(화면)
	@Override
	public DocControlVo selectAdocDetail(String no) {
		return dao.selectAdocDetail(sst,no);
	}
	//싸인+부서+직급받아오기
	@Override
	public List<SignVo> selectSign(String adocNo) {
		return dao.selectSign(sst,adocNo);
	}
	//작성자 부서,직급+싸인 받아오기
	@Override
	public SignVo selectMemInfo(String empNo) {
		return dao.selectMemInfo(sst,empNo);
	}
	//협조자 이름받기
	@Override
	public List<SignVo> selectCooList(String adocNo) {
		return dao.selectCoo(sst, adocNo);
	}
	//파일받기
	@Override
	public List<ApprovDocumentVo> selectFile(String adocNo) {
		return dao.selectFile(sst,adocNo);
	}
	//contdoc받기
	@Override
	public List<DocControlVo> selectOneContDoc(String no) {
		return dao.selectOneContDoc(sst,no);
	}
	//비전자결재문서 총갯수 직원별
	@Override
	public int selectNoelctTotalCnt(String empNo) {
		return dao.selectNoelectTotalCnt(sst,empNo);
	}
	//비전자결재문서불러오기(직원별)
	@Override
	public List<DocControlVo> selectNoelectEmp(HashMap map) {
		return dao.selectNoelectEmp(sst,map);
	}
	//비전자결재문서 하나불러오기
	@Override
	public DocControlVo selectOneNo(String no) {
		return dao.selectOneNo(sst,no);
	}
	//비전자결재문서 문서관리상태변경
	@Override
	public int updateNoStatus(DocControlVo vo) {
		return dao.updateNoStatus(sst,vo);
	}
	//비전자결재게시중 전체갯수
	@Override
	public int selectNoTotalCnt() {
		return dao.selectNoToTalCnt(sst);
	}
	//공개중 비전자결재 가져오기
	@Override
	public List<DocControlVo> selectNoCnt(PageVo pv) {
		return dao.selectNoList(sst,pv);
	}
	//비전자결재 디테일
	@Override
	public DocControlVo selectNoDetail(int no) {
		return dao.selectNoDetail(sst,no);
	}
	//write에서 문서목록가져오기
	@Override
	public List<DocControlVo> selectNoSelectListEmp(HashMap map) {
		return dao.selectNoSelectListEmp(sst,map);
	}
	//write에서 비전자선택
	@Override
	public List<DocControlVo> selectOneDoc2(String adocNo) {
		return dao.selectOneDoc2(sst,adocNo);
	}

}
