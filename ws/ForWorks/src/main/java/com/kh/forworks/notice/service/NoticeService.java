package com.kh.forworks.notice.service;

import java.util.List;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.notice.vo.NoticeVo;
import com.kh.forworks.noticeattachments.vo.NoticeAttachmentsVo;

public interface NoticeService{

	//공지사항 갯수 조회
	int selectTotalCount(String keyword);
	
	//공지사항 목록 조회
	List<NoticeVo> selectList(PageVo pv, String keyword);

	//공지사항 상세조회
	NoticeVo selectOne(String no);
	//첨부파일 확인
	NoticeAttachmentsVo checkFile(String no);
	
	//공지사항 저장
	int insertNotice(NoticeVo ntvo, NoticeAttachmentsVo ntatVo);

	//공지사항 정보수정
	int edit(NoticeVo ntvo, NoticeAttachmentsVo ntatVo, NoticeAttachmentsVo ntatVocheck, String no);

	//공지사항 삭제
	int delete(String no);

	//모든 부서 
	List<DepartmentVo> selectAlldp();
	


}
