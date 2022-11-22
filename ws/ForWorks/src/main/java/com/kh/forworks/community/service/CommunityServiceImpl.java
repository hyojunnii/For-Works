package com.kh.forworks.community.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.community.dao.CommunityDao;
import com.kh.forworks.community.vo.CommunityVo;
import com.kh.forworks.communityattachments.vo.CommunityAttachmentsVo;
import com.kh.forworks.department.vo.DepartmentVo;

@Service
public class CommunityServiceImpl implements CommunityService{
	
	private final CommunityDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public CommunityServiceImpl(CommunityDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}

	//커뮤니티 전체 갯수
	@Override
	public int selectTotalCount(Map<String, String> map) {
		return dao.selectTotalCount(sst, map);
	}
	@Override
	public int selectDp(Map<String, String> map) {
		return dao.selectDp(sst,map);
	}
	
	//커뮤니티 리스트 가져오기
	@Override
	public List<CommunityVo> selectList(PageVo pv,Map<String, String> map) {
		return dao.selectList(sst, pv, map);
		
	}
	@Override
	public List<CommunityVo> selectListdp(PageVo pvdp,Map<String, String> map) {
		return dao.selectListdp(sst, pvdp,map);
	}


	//커뮤니티 글 작성
	@Override
	public int insertCommu(CommunityVo cmuvo, CommunityAttachmentsVo cmatVo) {
		
		int result1 = dao.insertCm(sst, cmuvo);
		
		int result2 = 0;
		if (cmatVo != null) {
			result2 = dao.insertCmAt(sst, cmatVo);
		}
		return result1+result2;
	}
	
	//커뮤상세글 보기
	@Override
	public CommunityVo selectOne(String no) {
		//글 조회수증가
		int result = dao.increaseCnt(sst,no);
		
		if (result == 1) {
			return dao.selectOne(sst, no);
		}else {return null;}		
	}
	//커뮤글 파일 첨부여부
	@Override
	public CommunityAttachmentsVo checkFile(String no) {
		return dao.checkFile(sst, no);
	}
	
	//커뮤글 수정
	@Override
	public int edit(CommunityVo cmuvo, CommunityAttachmentsVo cmatVo,CommunityAttachmentsVo cmatVoCheck, String no) {
		
		//글 수정
		int result1 = dao.editCm(sst, cmuvo);
		
		//파일수정
		int result2 = 0;
		if (!(cmuvo.getCmuFileName().isEmpty())) {
			if (cmatVo != null && cmatVoCheck != null) {
				result2 = dao.editCmat(sst, cmatVo);
			}else if(cmatVo != null && cmatVoCheck == null){
				result2 = dao.editCmatInsert(sst, cmatVo);
			}
		}else {result2=1;}
		return result1 + result2;
	}
	
	//커뮤 글삭제
	@Override
	public int delete(String no) {
		return dao.delete(sst,no);
	}

	//로그인 유저 부서정보 가져오기
	@Override
	public DepartmentVo logDp(String dpNo) {
		return dao.logDp(sst,dpNo);
	}
	
	
}
