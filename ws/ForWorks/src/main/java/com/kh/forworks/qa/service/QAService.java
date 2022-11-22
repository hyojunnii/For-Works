package com.kh.forworks.qa.service;

import java.util.HashMap;
import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.qa.vo.QAAnswerVo;
import com.kh.forworks.qa.vo.QAAttachmentsVo;
import com.kh.forworks.qa.vo.QACategoryVo;
import com.kh.forworks.qa.vo.QAParticipationVo;
import com.kh.forworks.qa.vo.QAVo;

public interface QAService {

	//부서 전체 정보
	List<DepartmentVo> selectAlldp();
	
	//설문 전체 개수
	int selectTotalCount();
	//전체 리스트
	List<QAVo> selectList(PageVo pv);
	
	//진행중 //설문개수
	int selecting(String no);
	//설문 리스트
	List<QAVo> selectListing(PageVo pving, String no);
	
	//마감  //설문 개수
	int selectEnd(String no);
	//설문 리스트
	List<QAVo> selectListEnd(PageVo pvend, String no);
	
	//설문 생성
	int insertQA(QAVo qavo, String[] qacgArr, QAAttachmentsVo qaatVo);
	
	//설문 정보 가져오기
	QAVo selectOneQa(String pno);
	//설문 항목 정보
	List<QACategoryVo> selectQacg(String pno);
	//설문 참가자 정보
	List<QAParticipationVo> selectQapt(String pno);
	//첨부파일 가져오기
	QAAttachmentsVo seleQaat(String pno);
	
	//설문 종료
	int QAEnd(int pno);
	//설문 삭제
	int qaDelete(int pno);
	
	//설문지 작성
	//int insertUserQA(QAParticipationVo vo, QACategoryVo qacg, QAParticipationVo checkpt, HashMap<String, String> map);
	int insertUserQA(QAAnswerVo awvo, QAParticipationVo checkpt, HashMap<String, String> map);		
	//로그인 사원 대상자인지 확인
	int check(HashMap<String, String> map);
	
	//대상자 일경우 설문 작성을 한적이 있는지 확인
	List<QAAnswerVo> checkAnswer(HashMap<String, String> map);
	//파일 확인
	
	QAAttachmentsVo checkFile(String pno);
	
	//설문 내용 수정
	int edit(QAVo qavo, String[] qacgArr, QAAttachmentsVo qaat, QAAttachmentsVo qaatCheck, String pno);
	
	//설문에 참여했는지 확인
	QAParticipationVo checkQA(HashMap<String, String> map);
	
	//설문 참여자 답변내용
	List<QAAnswerVo> selectQaaw(String pno);
	
	//설문 참가자수 가져오기
	int selectNum(String pno);
	
	//답변 수정
	int editAw(QAAnswerVo awvo, String no);

	
	
	

	

	
}
