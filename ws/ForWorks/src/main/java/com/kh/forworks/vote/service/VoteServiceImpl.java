package com.kh.forworks.vote.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.vote.dao.VoteDao;
import com.kh.forworks.vote.vo.VoteAttachmentsVo;
import com.kh.forworks.vote.vo.VoteCategoryVo;
import com.kh.forworks.vote.vo.VoteParticipationVo;
import com.kh.forworks.vote.vo.VoteVo;

@Service
public class VoteServiceImpl implements VoteService{
	
	private final SqlSessionTemplate sst;
	private final VoteDao dao;
	
	@Autowired
	public VoteServiceImpl(SqlSessionTemplate sst, VoteDao dao) {
		this.sst = sst;
		this.dao = dao;
	}
	
	//부서정보 가져오기
	@Override
	public List<DepartmentVo> selectAlldp() {
		return dao.selectAlldp(sst);
	}
	
	//전체
	@Override
	public int selectTotalCount() {
		return dao.selectTotalCount(sst);
	}

	@Override
	public List<VoteVo> selectList(PageVo pv) {
		return dao.selectList(sst, pv);
	}
	
	//진행중
	@Override
	public int selecting(String no) {
		return dao.selecting(sst,no);
	}
	@Override
	public List<VoteVo> selectListing(PageVo pving, String no) {
		return dao.selectListing(sst, pving, no);
	}
	
	//마감
	@Override
	public int selectEnd(String no) {
		return dao.selectEnd(sst, no);
	}
	@Override
	public List<VoteVo> selectListEnd(PageVo pvend,String no) {
		return dao.selectListEnd(sst, pvend, no);
	}
	
	//투표생성
	@Override
	public int insertVote(VoteVo vtvo, String[] vtcgArr, VoteAttachmentsVo vtatVo) {
		
		int[] result =  new int[4];
		//투표 테이블에 정보 저장
		result[0]=dao.insertVt(sst, vtvo);
		
		//파일 유무 확인후 첨부파일 테이블에 저장
		if(vtatVo != null) {
			result[1]=dao.insertVtat(sst, vtatVo);
		}else {result[1]=1;}
		
		//항목 
		for (int i = 0; i < vtcgArr.length; i++) {
			//System.out.println(vtcgArr[i]);
			//항목개수 만큼 insert작업
			result[2]=dao.insertVtcg(sst,vtcgArr[i]);
		}
		
		//참가인원
		vtvo.getTarget(); //all , dp 인지 판별
		vtvo.getDept();
		
		if (vtvo.getTarget().equals("all")) {
			//all 이면 모든 회원 정보를
			//모든회원정보 가져오기
			List<MemberVo> memberListAll = dao.mListAll(sst);
			//대상자 테이블에 입력
			
			for(int i=0; i<memberListAll.size(); i++ ) {
				result[3]=dao.insertVtpt(sst, memberListAll.get(i));
				if (result[3] != 1) {
					return -1;
				}
			}

		}else if(vtvo.getTarget().equals("dp")) {
			//dp이면 vtvo.getDept()배열안에 있는 부서정보만 
			for (int i = 0; i < vtvo.getDept().length; i++) {
				//부서 정보 리스트 가져오기
				//System.out.println(vtvo.getDept()[i]);
				List<MemberVo> memberListDp = dao.mListDp(sst,vtvo.getDept()[i]);
				//가져온 정보 
				for(int j=0; j < memberListDp.size(); j++) {
					result[3]=dao.insertVtpt(sst, memberListDp.get(j));
					if (result[3] != 1) {
						return -2;
					}
				}
				
			}
		}
		
		
		return result[0]*result[1]*result[2]*result[3];
	}

	//투표 정보 가져오기
	@Override
	public VoteVo selectOneVt(String pno) {
		return dao.selectOneVt(sst,pno);
	}

	//투표 항복 정보 가져오기
	@Override
	public List<VoteCategoryVo> selectVtcg(String pno) {
		return dao.selectVtcg(sst,pno);
	}

	//투표 참가자 정보 가져오기
	@Override
	public List<VoteParticipationVo> selectVtpt(String pno) {
		return dao.selectVtpt(sst,pno);
	}
	//투표 첨부파일 가져오기
	@Override
	public VoteAttachmentsVo seleVtat(String pno) {
		return dao.selectVtat(sst, pno);
	}

	
	//투표 종료
	@Override
	public int voteEnd(int pno) {
		return dao.end(sst, pno);
	}
	
	//투표삭제
	@Override
	public int voteDelete(int pno) {
		return dao.delete(sst,pno);
	}
	
	//투표 대상자 투표
	@Override
	public int insertUserVt(VoteParticipationVo vo, VoteCategoryVo vtcg, VoteParticipationVo checkpt, HashMap<String, String> map) {
		
		int[] result = new int[4];
		
		//투표 득표수 ++ 필요한것 :: 투표번호 투표항목번호 == vtcg
		//투표 득표수 -- 필요한것 :: 투표번호 투표항목번호 == 
		
		//투표를 참가하지 않은 인원이면
		if (checkpt.getVtcgNo() == null) {
			//득표수 ++ 
			result[1]= dao.increaseVote(sst,vtcg);
			//투표 참여 등록(참가자 테이블)
			result[2] =dao.insertUserVt(sst,vo);
			
			result[0] = result[1]*result[2];
		}else {
			//투표를 참여한 경우
			
			//checkpt에 투표번호 투표항목번호의 득표수 --
			result[2]=dao.decreaseVote(sst,checkpt);
			//현재 투표하는 항목의 득표수 ++
			result[1]=dao.increaseVote(sst,vtcg);
			
			//투표 내용 변경 (데이터:: )
			result[3] = dao.editVote(sst,map);
			result[0] = result[1]*result[2]*result[3];
		}
		
		return result[0];
	}

	//로그인사원이 대상자 여부 확인
	@Override
	public int check(HashMap<String, String> map) {
		return dao.check(sst, map);
	}
	
	//대상자중 참여한 투표정보 가져오기
	@Override
	public VoteParticipationVo checkDo(HashMap<String, String> map) {
		return dao.checkDo(sst,map);
	}
	
	// 투표 첨부파일 확인
	@Override
	public VoteAttachmentsVo checkFile(String pno) {
		return dao.checkFile(sst,pno);
	}
	
	//투표내용 수정
	@Override
	public int edit(VoteVo vtvo, String[] vtcgArr, VoteAttachmentsVo vtat, VoteAttachmentsVo vtatCheck, String pno) {
		int[] result = new int[4]; 

		//투표 내용수정
		result[0] = dao.editVt(sst,vtvo);
		
		//투표 첨부파일 확인후 update||insert 선택
		//파일을 수정하는지 확인
		//System.out.println("공백여부::"+!(vtvo.getVtFile().isEmpty()));
		if (!(vtvo.getVtFile().isEmpty())) {
			if (vtatCheck !=null) {
				//System.out.println("파일있음");
				result[1] = dao.editVtat(sst,vtat);
				//System.out.println("파일수정완료");
			}else if(vtatCheck ==null) {
				//System.out.println("파일없음");
				result[1] = dao.editVtatInsert(sst, vtat);
				//System.out.println("파일등록완료");
			}
		}else {result[1]=1;}
		//추가된 항목이 있는지 확인후 insert
		if(vtcgArr != null) {
			for (int i = 0; i < vtcgArr.length; i++) {
				//System.out.println(vtcgArr[i]);
				//항목개수 만큼 insert작업
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("vtcg", vtcgArr[i]);
				map.put("pno", vtvo.getVtNo());
				result[2]=dao.editInsertVtcg(sst,map);
			}
			
		}else {result[2]=1;}
//		System.out.println(result[0]);
//		System.out.println(result[1]);
//		System.out.println(result[2]);
		return result[0]*result[1]*result[2];
	}
	
	//투표 참여했는지 확인
	@Override
	public VoteParticipationVo checkVote(HashMap<String, String> map) {
		return dao.checkVote(sst,map);
	}
	
	
	
}
