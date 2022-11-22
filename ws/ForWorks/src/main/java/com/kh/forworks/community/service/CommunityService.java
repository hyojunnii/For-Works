package com.kh.forworks.community.service;

import java.util.List;
import java.util.Map;

import com.kh.forworks.PageVo;
import com.kh.forworks.community.vo.CommunityVo;
import com.kh.forworks.communityattachments.vo.CommunityAttachmentsVo;
import com.kh.forworks.department.vo.DepartmentVo;

public interface CommunityService {
	
	//커뮤니티 전체 갯수
	int selectTotalCount(Map<String, String> map);
	int selectDp(Map<String, String> map);
	//커뮤니티 리스트 가져오기
	List<CommunityVo> selectList(PageVo pv, Map<String, String> map);
	List<CommunityVo> selectListdp(PageVo pvdp, Map<String, String> map);
	
	//커뮤니티글 작성
	int insertCommu(CommunityVo cmuvo, CommunityAttachmentsVo cmatVo);
	
	//커뮤니티글 상세정보 확인
	CommunityVo selectOne(String no);
	//커뮤글 첨부파일 여부 확인
	CommunityAttachmentsVo checkFile(String no);
	
	//커뮤글 수정
	int edit(CommunityVo cmuvo, CommunityAttachmentsVo cmatVo, CommunityAttachmentsVo cmatVoCheck, String no);

	//커뮤글 삭제
	int delete(String no);
	
	//로그인 유저 부서정보 가져오기
	DepartmentVo logDp(String dpNo);
	

}
