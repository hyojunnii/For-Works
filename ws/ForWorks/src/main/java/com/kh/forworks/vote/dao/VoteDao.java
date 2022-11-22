package com.kh.forworks.vote.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.vote.vo.VoteAttachmentsVo;
import com.kh.forworks.vote.vo.VoteCategoryVo;
import com.kh.forworks.vote.vo.VoteParticipationVo;
import com.kh.forworks.vote.vo.VoteVo;

public interface VoteDao {
	
	//부서정보 가져오기
	List<DepartmentVo> selectAlldp(SqlSessionTemplate sst);
	
	//전체
	int selectTotalCount(SqlSessionTemplate sst);
	List<VoteVo> selectList(SqlSessionTemplate sst, PageVo pv);
	
	//진행중
	int selecting(SqlSessionTemplate sst, String no);
	List<VoteVo> selectListing(SqlSessionTemplate sst, PageVo pving,String no);

	//마감
	int selectEnd(SqlSessionTemplate sst,String no);
	List<VoteVo> selectListEnd(SqlSessionTemplate sst, PageVo pvend,String no);
	
	//투표 내용 저장
	int insertVt(SqlSessionTemplate sst, VoteVo vtvo);
	//첨부파일 내용 저장
	int insertVtat(SqlSessionTemplate sst, VoteAttachmentsVo vtatVo);
	//투표 항목 저장
	int insertVtcg(SqlSessionTemplate sst, String vtct);
	
	//모든 회원 정보 가져오기
	List<MemberVo> mListAll(SqlSessionTemplate sst);
	//회원 대상자 저장
	int insertVtpt(SqlSessionTemplate sst, MemberVo memberVo);
	
	//부서 회원정보 가져오기
	List<MemberVo> mListDp(SqlSessionTemplate sst, int dept);
	//선택 부서 대상자 저장
	//int insertVtpt(SqlSessionTemplate sst, MemberVo memberVo);

	//투표 정보 가져오기
	VoteVo selectOneVt(SqlSessionTemplate sst, String pno);
	//투표 항복 정보 가져오기
	List<VoteCategoryVo> selectVtcg(SqlSessionTemplate sst, String pno);
	//투표 참가자 정보 가져오기
	List<VoteParticipationVo> selectVtpt(SqlSessionTemplate sst, String pno);
	//투표 첨부파일
	VoteAttachmentsVo selectVtat(SqlSessionTemplate sst, String pno);
	
	//투표종료
	int end(SqlSessionTemplate sst, int pno);
	//투표삭제
	int delete(SqlSessionTemplate sst, int pno);
	
	//투표 대상자 투표
	int insertUserVt(SqlSessionTemplate sst, VoteParticipationVo vo);

	//로그인사원이 대상자 여부 확인
	int check(SqlSessionTemplate sst, HashMap<String, String> map);
	//대상자중 참여한 투표정보 가져오기
	VoteParticipationVo checkDo(SqlSessionTemplate sst, HashMap<String, String> map);

	//투표 수정
	int editVt(SqlSessionTemplate sst, VoteVo vtvo);
	// 투표 첨부파일 확인
	VoteAttachmentsVo checkFile(SqlSessionTemplate sst, String pno);
	//투표 첨부파일 수정
	int editVtat(SqlSessionTemplate sst, VoteAttachmentsVo vtat);
	//투표 첨부파일 등록(수정페이지에서)
	int editVtatInsert(SqlSessionTemplate sst, VoteAttachmentsVo vtat);
	//투표 항목 등록(수정)
	int editInsertVtcg(SqlSessionTemplate sst, HashMap<String, String> map);

	//투표 참여했는지 확인
	VoteParticipationVo checkVote(SqlSessionTemplate sst, HashMap<String, String> map);
	
	//특표수 증가
	int increaseVote(SqlSessionTemplate sst, VoteCategoryVo vtcg);
	//감소
	int decreaseVote(SqlSessionTemplate sst, VoteParticipationVo checkpt);
	//투표내용 변경
	int editVote(SqlSessionTemplate sst, HashMap<String, String> map);


	

	

	

}
