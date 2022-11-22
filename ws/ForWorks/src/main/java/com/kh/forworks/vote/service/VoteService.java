package com.kh.forworks.vote.service;

import java.util.HashMap;
import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.vote.vo.VoteAttachmentsVo;
import com.kh.forworks.vote.vo.VoteCategoryVo;
import com.kh.forworks.vote.vo.VoteParticipationVo;
import com.kh.forworks.vote.vo.VoteVo;

public interface VoteService {

	//부서정보 가져오기
	List<DepartmentVo> selectAlldp();
	
	//투표 전체 개수
	int selectTotalCount();
	//투표 전체 리스트
	List<VoteVo> selectList(PageVo pv);
	
	//진행중
	//투표 개수
	int selecting(String no);
	//리스트
	List<VoteVo> selectListing(PageVo pving,String no);

	//마감
	//개수
	int selectEnd(String no);
	//리스트
	List<VoteVo> selectListEnd(PageVo pvend,String no);

	//투표생성
	int insertVote(VoteVo vtvo, String[] vtcgArr, VoteAttachmentsVo vtatVo);

	//투표 정보 가져오기
	VoteVo selectOneVt(String pno);
	//투표 항복 정보 가져오기
	List<VoteCategoryVo> selectVtcg(String pno);
	//투표 참가자 정보 가져오기
	List<VoteParticipationVo> selectVtpt(String pno);
	//첨부파일 가져오기
	VoteAttachmentsVo seleVtat(String pno);
	
	//투표종료
	int voteEnd(int pno);
	//투표 삭제
	int voteDelete(int pno);

	//투표 대상자 투표
	int insertUserVt(VoteParticipationVo vo, VoteCategoryVo vtcg, VoteParticipationVo checkpt, HashMap<String, String> map);
	
	//로그인사원이 대상자 여부 확인
	int check(HashMap<String, String> map);
	
	//대상자중 참여한 투표정보 가져오기
	VoteParticipationVo checkDo(HashMap<String, String> map);

	//파일 확인
	VoteAttachmentsVo checkFile(String pno);

	//투표 내용 수정
	int edit(VoteVo vtvo, String[] vtcgArr, VoteAttachmentsVo vtat, VoteAttachmentsVo vtatCheck, String pno);
	
	//투표 참여했는지 확인
	VoteParticipationVo checkVote(HashMap<String, String> map);
	

	

}
