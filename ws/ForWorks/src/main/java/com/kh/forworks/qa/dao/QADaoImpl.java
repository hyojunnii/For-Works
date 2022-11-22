package com.kh.forworks.qa.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.qa.vo.QAAnswerVo;
import com.kh.forworks.qa.vo.QAAttachmentsVo;
import com.kh.forworks.qa.vo.QACategoryVo;
import com.kh.forworks.qa.vo.QAParticipationVo;
import com.kh.forworks.qa.vo.QAVo;

@Repository
public class QADaoImpl implements QADao{
	
	//페이징처리
	public RowBounds rb(PageVo pv) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		RowBounds rb = new RowBounds(offset , pv.getBoardLimit()); 
		return rb;
	}

	//부서정보 가져오기
	@Override
	public List<DepartmentVo> selectAlldp(SqlSessionTemplate sst) {
		return sst.selectList("voteMapper.selectAlldp");
	}
	
	//전체  //설문지수
	@Override
	public int selectTotalCount(SqlSessionTemplate sst) {
		return sst.selectOne("qaMapper.selectTotalCount");
	}

	//리스트
	@Override
	public List<QAVo> selectList(SqlSessionTemplate sst, PageVo pv) {
		return sst.selectList("qaMapper.selectList", null, rb(pv));
	}
	
	//진행중 //개수
	@Override
	public int selecting(SqlSessionTemplate sst, String no) {
		return sst.selectOne("qaMapper.selecting",no);
	}
	//리스트
	@Override
	public List<QAVo> selectListing(SqlSessionTemplate sst, PageVo pving, String no) {
		return sst.selectList("qaMapper.selectListing",no,rb(pving));
	}
	
	//마감 //개수
	@Override
	public int selectEnd(SqlSessionTemplate sst, String no) {
		return sst.selectOne("qaMapper.selectEnd",no);
	}
	
	//리스트
	@Override
	public List<QAVo> selectListEnd(SqlSessionTemplate sst, PageVo pvend, String no) {
		return sst.selectList("qaMapper.selectListEnd", no, rb(pvend));
	}
	
	//설문지 등록
	@Override
	public int insertQa(SqlSessionTemplate sst, QAVo qavo) {
		return sst.insert("qaMapper.insertQa", qavo);
	}
	//설문지 첨부파일 등록
	@Override
	public int insertQaAt(SqlSessionTemplate sst, QAAttachmentsVo qaatVo) {
		return sst.insert("qaMapper.insertQaat", qaatVo);
	}
	//설문지 항목 등록
	@Override
	public int insertQacg(SqlSessionTemplate sst, String qact) {
		return sst.insert("qaMapper.insertQacg", qact);
	}
	//모든 회원정보
	@Override
	public List<MemberVo> mListAll(SqlSessionTemplate sst) {
		return sst.selectList("voteMapper.mListAll");
	}
	//부서별 회원정보
	@Override
	public List<MemberVo> mListDp(SqlSessionTemplate sst, int dept) {
		return sst.selectList("voteMapper.mListDp", dept);
	}
	//참여 대상자 사원 등록
	@Override
	public int insertQapt(SqlSessionTemplate sst, MemberVo memberVo) {
		return sst.insert("qaMapper.insertQapt",memberVo.getEmpNo());
	}
	
	// 설문지 정보 가져오기
	@Override
	public QAVo selectOneQa(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("qaMapper.selectOneQa", pno);
	}
	
	//설문지에 맞는 항목 정보 가져오기
	@Override
	public List<QACategoryVo> selectQacg(SqlSessionTemplate sst, String pno) {
		return sst.selectList("qaMapper.selectQacg", pno);
	}
	
	//설문지에 맞는 참가자 정보 가져오기
	@Override
	public List<QAParticipationVo> selectQapt(SqlSessionTemplate sst, String pno) {
		return sst.selectList("qaMapper.selectQapt", pno);
	}
	//설문지 첨부파일 가져오기
	@Override
	public QAAttachmentsVo selectQaat(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("qaMapper.selectQaat",pno);
	}
	
	//설문 종료
	@Override
	public int end(SqlSessionTemplate sst, int pno) {
		return sst.update("qaMapper.end",pno);
	}
	
	//설문지 삭제
	@Override
	public int delete(SqlSessionTemplate sst, int pno) {
		return sst.update("qaMapper.delete",pno);
	}
	
	//설문 답변내용 등록
	@Override
	public int insertUserQA(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.insert("qaMapper.insertUserQa",map);
	}
	//참여여부 상태 변경
	@Override
	public int updateSt(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.update("qaMapper.updateSt", map);
	}
	//설문 참여대상자 확인
	@Override
	public int check(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.selectOne("qaMapper.check",map);
	}
	
	//대상자인 사원중 참가여부확인
	@Override
	public List<QAAnswerVo> checkAnswer(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.selectList("qaMapper.checkAnswer",map);
	}
	
	// 설문 첨부파일 확인
	@Override
	public QAAttachmentsVo checkFile(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("qaMapper.checkFile",pno);
	}
	
	//설문 수정
	@Override
	public int editQa(SqlSessionTemplate sst, QAVo qavo) {
		return sst.update("qaMapper.editQa", qavo);
	}
	//설문 첨부파일 수정
	@Override
	public int editQaat(SqlSessionTemplate sst, QAAttachmentsVo qaat) {
		return sst.update("qaMapper.editQaat", qaat);
	}
	//설문 첨부파일 등록(수정중 첨부파일이 없을경우)
	@Override
	public int editQaatInsert(SqlSessionTemplate sst, QAAttachmentsVo qaat) {
		return sst.insert("qaMapper.editQaatInsert", qaat);
	}

	//투표 참여햇는지 확인
	@Override
	public QAParticipationVo checkQa(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.selectOne("qaMapper.checkQa", map);
	}
	
	//설문지 항목 추가
	@Override
	public int editInsertQacg(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.insert("qaMapper.editInsertQacg", map);
	}
	
	//설문지 항목에대한 내용 등록
	@Override
	public int insertQA(SqlSessionTemplate sst, QACategoryVo qacg) {
		return sst.update("qaMapper.checkVote", qacg);
	}
	
	//설문 내용 수정(이미 작성한 경우)
	@Override
	public int updateQA(SqlSessionTemplate sst, QACategoryVo qacg) {
		return sst.update("qaMapper.decreaseVote",qacg);
	}

	//설문 참여자 답변내용
	@Override
	public List<QAAnswerVo> selectQaaw(SqlSessionTemplate sst, String pno) {
		return sst.selectList("qaMapper.selectQaaw",pno);
	}
	
	//설문 참가자수 가져오기
	@Override
	public int selectNum(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("qaMapper.selectNum",pno);
	}
	
	
	//답변내용 수정
	@Override
	public int editAw(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.update("qaMapper.editAw",map);
	}
	//참가자 명단 수정일변경
	@Override
	public int updateSt2(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.update("qaMapper.updateSt2", map);
	}


	

	
}
