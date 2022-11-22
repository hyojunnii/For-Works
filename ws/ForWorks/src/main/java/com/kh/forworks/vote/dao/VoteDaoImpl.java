package com.kh.forworks.vote.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.vote.vo.VoteAttachmentsVo;
import com.kh.forworks.vote.vo.VoteCategoryVo;
import com.kh.forworks.vote.vo.VoteParticipationVo;
import com.kh.forworks.vote.vo.VoteVo;

@Repository
public class VoteDaoImpl implements VoteDao{
	
	public RowBounds rb(PageVo pv) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		RowBounds rb = new RowBounds(offset , pv.getBoardLimit()); 
		return rb;
	} 
	
	//부서 정보가져오기
	@Override
	public List<DepartmentVo> selectAlldp(SqlSessionTemplate sst) {
		return sst.selectList("voteMapper.selectAlldp");
	}
	
	//투표 리스트
	//전체
	@Override
	public int selectTotalCount(SqlSessionTemplate sst) {
		return sst.selectOne("voteMapper.selectTotalCount");
	}

	@Override
	public List<VoteVo> selectList(SqlSessionTemplate sst, PageVo pv) {
		
		return sst.selectList("voteMapper.selectList", null, rb(pv));
	}

	//진행중
	@Override
	public int selecting(SqlSessionTemplate sst, String no) {
		return sst.selectOne("voteMapper.selecting",no);
	}

	@Override
	public List<VoteVo> selectListing(SqlSessionTemplate sst, PageVo pving,String no) {
		return sst.selectList("voteMapper.selectListing",no,rb(pving));
	}
	
	//마감
	@Override
	public int selectEnd(SqlSessionTemplate sst,String no) {
		return sst.selectOne("voteMapper.selectEnd",no);
	}

	@Override
	public List<VoteVo> selectListEnd(SqlSessionTemplate sst, PageVo pvend,String no) {
		return sst.selectList("voteMapper.selectListEnd", no, rb(pvend));
	}
	//----------------------------------------------------------------------
	//투표 내용 저장
	@Override
	public int insertVt(SqlSessionTemplate sst, VoteVo vtvo) {
		return sst.insert("voteMapper.insertVt", vtvo);
	}
	//첨부파일 내용 저장
	@Override
	public int insertVtat(SqlSessionTemplate sst, VoteAttachmentsVo vtatVo) {
		return sst.insert("voteMapper.insertVtat", vtatVo);
	}
	//투표 항목 저장
	@Override
	public int insertVtcg(SqlSessionTemplate sst, String vtct) {
		return sst.insert("voteMapper.insertVtcg", vtct);
	}
	
	//모든 회원 정보 가져오기
	@Override
	public List<MemberVo> mListAll(SqlSessionTemplate sst) {
		return sst.selectList("voteMapper.mListAll");
	}
	//회원 대상자 저장
	@Override
	public int insertVtpt(SqlSessionTemplate sst, MemberVo memberVo) {
		return sst.insert("voteMapper.insertVtpt",memberVo.getEmpNo());
	}
	
	//부서 회원정보 가져오기
	@Override
	public List<MemberVo> mListDp(SqlSessionTemplate sst, int dept) {
		return sst.selectList("voteMapper.mListDp", dept);
	}
//	//선택 부서 대상자 저장
//	@Override
//	public int insertVtptDp(SqlSessionTemplate sst, MemberVo memberVo) {
//		return sst.insert("voteMapper.insertVtptDp", memberVo);
//	}

	//투표 정보 가져오기
	@Override
	public VoteVo selectOneVt(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("voteMapper.selectOneVt", pno);
	}

	//투표 항복 정보 가져오기
	@Override
	public List<VoteCategoryVo> selectVtcg(SqlSessionTemplate sst, String pno) {
		return sst.selectList("voteMapper.selectVtcg", pno);
	}

	//투표 참가자 정보 가져오기
	@Override
	public List<VoteParticipationVo> selectVtpt(SqlSessionTemplate sst, String pno) {
		return sst.selectList("voteMapper.selectVtpt", pno);
	}
	
	//투표 첨부파일 정보
	@Override
	public VoteAttachmentsVo selectVtat(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("voteMapper.selectVtat",pno);
	}

	
	//투표종료
	@Override
	public int end(SqlSessionTemplate sst, int pno) {
		return sst.update("voteMapper.end",pno);
	}

	//투표삭제
	@Override
	public int delete(SqlSessionTemplate sst, int pno) {
		return sst.update("voteMapper.delete",pno);
	}
	
	//투표 대상자 투표
	@Override
	public int insertUserVt(SqlSessionTemplate sst, VoteParticipationVo vo) {
		return sst.insert("voteMapper.insertUserVt",vo);
	}
	
	//투표 대상지인지 확인
	@Override
	public int check(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.selectOne("voteMapper.check",map);
	}

	//대상자중 참여한 투표정보 가져오기
	@Override
	public VoteParticipationVo checkDo(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.selectOne("voteMapper.checkDo",map);
	}
	
	//투표 첨부파일 확인
	@Override
	public VoteAttachmentsVo checkFile(SqlSessionTemplate sst, String pno) {
		return sst.selectOne("voteMapper.checkFile",pno);
	}
	
	//투표 수정
	@Override
	public int editVt(SqlSessionTemplate sst, VoteVo vtvo) {
		return sst.update("voteMapper.editVt", vtvo);
	}
	
	//투표 첨부파일 수정
	@Override
	public int editVtat(SqlSessionTemplate sst, VoteAttachmentsVo vtat) {
		return sst.update("voteMapper.editVtat", vtat);
	}
	
	//투표 첨부파일 등록(수정페이지에서)
	@Override
	public int editVtatInsert(SqlSessionTemplate sst, VoteAttachmentsVo vtat) {
		return sst.insert("voteMapper.editVtatInsert", vtat);
	}
	
	//투표항목 등록(수정)
	@Override
	public int editInsertVtcg(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.insert("voteMapper.editInsertVtcg", map);
	}
	
	//투표 참여했는지 확인
	@Override
	public VoteParticipationVo checkVote(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.selectOne("voteMapper.checkVote", map);
	}
	
	//특표수 증가
	@Override
	public int increaseVote(SqlSessionTemplate sst, VoteCategoryVo vtcg) {
		return sst.update("voteMapper.increaseVote",vtcg);
	}
	//감소
	@Override
	public int decreaseVote(SqlSessionTemplate sst, VoteParticipationVo checkpt) {
		return sst.update("voteMapper.decreaseVote",checkpt);
	}
	
	//투표내용 변경
	@Override
	public int editVote(SqlSessionTemplate sst, HashMap<String, String> map) {
		return sst.update("voteMapper.editVote",map);
	}

	
}
