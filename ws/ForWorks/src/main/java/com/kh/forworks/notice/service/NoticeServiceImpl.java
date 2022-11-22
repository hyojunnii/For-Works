package com.kh.forworks.notice.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.notice.dao.NoticeDao;
import com.kh.forworks.notice.vo.NoticeVo;
import com.kh.forworks.noticeattachments.vo.NoticeAttachmentsVo;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	private final NoticeDao dao;
	private final SqlSessionTemplate sst;
	
	@Autowired
	public NoticeServiceImpl(NoticeDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}
	
	//공지사항 갯수 조회
	@Override
	public int selectTotalCount(String keyword) {
		return dao.selectTotalCount(sst, keyword);
	}


	//공지사항 목록 조회
	@Override
	public List<NoticeVo> selectList(PageVo pv, String keyword) {
		return dao.selectList(sst, pv, keyword);
	}
	
	//공지사항 상세 조회
	@Override
	public NoticeVo selectOne(String no) {
		//게시글 조회수증가
		int result = dao.increaseCnt(sst,no);
		
		if (result == 1) {
			return dao.selectOne(sst, no);
		}else {return null;}
		
		
	}
	//첨부파일 확인
	@Override
	public NoticeAttachmentsVo checkFile(String no) {
		return dao.checkFile(sst, no);
	}

	
	//공지사항 저장
	@Override
	public int insertNotice(NoticeVo ntvo, NoticeAttachmentsVo ntatVo) {

		//공지사항 테이블에 저장
		int result = dao.insertNotice(sst, ntvo);
		
		int result2=0;
		//파일이 있는경우 
		if (ntatVo!= null) {
			//System.out.println("공지사항 파일insert 시작");
			result2 = dao.insertNtAt(sst,ntatVo);
		}
		
		return result+result2;
	}
	
	//공지사항 정보수정
	@Override
	public int edit(NoticeVo ntvo, NoticeAttachmentsVo ntatVo, NoticeAttachmentsVo ntatVocheck, String no) {
		//System.out.println(ntatVo);
		//System.out.println(ntatVocheck);
		//공지사항 수정
		int result = dao.editNt(sst, ntvo);
		
		int result2 =0;
		//공지사항 파일 수정
		if (!(ntvo.getNtFileName().isEmpty())) {
			if (ntatVocheck !=null) {
				result2 = dao.editNtat(sst,ntatVo);
			}else if( ntatVocheck ==null) {
				result2 = dao.editNtatInsert(sst, ntatVo);
			}
		}else {result2 =1;}
		return result+result2;
	}
	
	//공지사항 삭제
	@Override
	public int delete(String no) {
		return dao.delete(sst, no);
	}
	
	//부서정보 가져오기
	@Override
	public List<DepartmentVo> selectAlldp() {
		return dao.selectAlldp(sst);
	}



}
