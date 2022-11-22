package com.kh.forworks.qa.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.qa.vo.QAAnswerVo;
import com.kh.forworks.qa.vo.QAAttachmentsVo;
import com.kh.forworks.qa.vo.QACategoryVo;
import com.kh.forworks.qa.vo.QAParticipationVo;
import com.kh.forworks.qa.vo.QAVo;


public interface QADao {
	
	//부서정보
	List<DepartmentVo> selectAlldp(SqlSessionTemplate sst);

	//전체  //개수
	int selectTotalCount(SqlSessionTemplate sst);
	//리스트
	List<QAVo> selectList(SqlSessionTemplate sst, PageVo pv);

	//진행중 //개수
	int selecting(SqlSessionTemplate sst, String no);
	//리스트
	List<QAVo> selectListing(SqlSessionTemplate sst, PageVo pving, String no);
	
	//마감 //개수
	int selectEnd(SqlSessionTemplate sst, String no);
	//리스트
	List<QAVo> selectListEnd(SqlSessionTemplate sst, PageVo pvend, String no);

	//설문 내용저장
	int insertQa(SqlSessionTemplate sst, QAVo qavo);
	//설문 첨부파일 저장
	int insertQaAt(SqlSessionTemplate sst, QAAttachmentsVo qaatVo);
	//설문 항목 저장
	int insertQacg(SqlSessionTemplate sst, String string);
	
	//모든 회원 정보 가져오기
	List<MemberVo> mListAll(SqlSessionTemplate sst);
	
	//부서 회원 정보 가져오기
	List<MemberVo> mListDp(SqlSessionTemplate sst, int dept);

	// 대상자 저장 (사원)
	int insertQapt(SqlSessionTemplate sst, MemberVo memberVo);
	
	//설문 정보 가져오기
	QAVo selectOneQa(SqlSessionTemplate sst, String pno);

	//설문 항목 리스트 
	List<QACategoryVo> selectQacg(SqlSessionTemplate sst, String pno);
	//설문 참가자 리스트
	List<QAParticipationVo> selectQapt(SqlSessionTemplate sst, String pno);
	//설문 첨부파일
	QAAttachmentsVo selectQaat(SqlSessionTemplate sst, String pno);
	
	//설문지 마감
	int end(SqlSessionTemplate sst, int pno);
	//설문지 삭제
	int delete(SqlSessionTemplate sst, int pno);
	
	//설문지 대상자 테이블에 insert
	int insertUserQA(SqlSessionTemplate sst, HashMap<String, String> map);
	
	//로그인 사원이 대상자인지 체크
	int check(SqlSessionTemplate sst, HashMap<String, String> map);

	//대상자중 참여한 설문 참여 인원 인지
	List<QAAnswerVo> checkAnswer(SqlSessionTemplate sst, HashMap<String, String> map);
	
	//첨부파일이 있는지 
	QAAttachmentsVo checkFile(SqlSessionTemplate sst, String pno);
	
	//설문수정 
	int editQa(SqlSessionTemplate sst, QAVo qavo);
	//설문 첨부파일 수정
	int editQaat(SqlSessionTemplate sst, QAAttachmentsVo qaat);
	//설문 첨부파일 등록(파일이 없을 경우)(수정화면에서)
	int editQaatInsert(SqlSessionTemplate sst, QAAttachmentsVo qaat);
	//설문 항목 추가(수정화면)
	int editInsertQacg(SqlSessionTemplate sst, HashMap<String, String> map);

	//사원 설문 내용 저장
	int insertQA(SqlSessionTemplate sst, QACategoryVo qacg);
	//상태값 변경
	int updateSt(SqlSessionTemplate sst, HashMap<String, String> map);
	//이미 답변 작성한 경우 수정
	int updateQA(SqlSessionTemplate sst, QACategoryVo qacg);
	
	//설문 참여했는지 확인
	QAParticipationVo checkQa(SqlSessionTemplate sst, HashMap<String, String> map);
	
	//설문 참여자 답변내용
	List<QAAnswerVo> selectQaaw(SqlSessionTemplate sst, String pno);
	
	//설문 참가자수 가져오기
	int selectNum(SqlSessionTemplate sst, String pno);
	
	//답변 내용 수정
	int editAw(SqlSessionTemplate sst, HashMap<String, String> map);
	//참가자 명단 수정일 변경
	int updateSt2(SqlSessionTemplate sst, HashMap<String, String> map);

	


}
