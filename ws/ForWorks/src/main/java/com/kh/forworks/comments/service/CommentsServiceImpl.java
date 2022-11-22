package com.kh.forworks.comments.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.comments.dao.CommentsDao;
import com.kh.forworks.comments.vo.CommentsVo;

@Service
public class CommentsServiceImpl implements CommentsService{
	
    private final CommentsDao dao;
    private final SqlSessionTemplate sst;
    
    @Autowired
    public CommentsServiceImpl(CommentsDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}

    //댓글자성
	@Override
	public int write(CommentsVo vo) {
		return dao.insertCmt(sst,vo);
	}
	
	//댓글 조회
	@Override
	public List<CommentsVo> selectList(String no) {
		return dao.selectList(sst,no);
	}
	
	//댓글 삭제
	@Override
	public int delete(String cmtno, String no) {
		
		//댓글 작성자가 로그인한 사원인지 확인
		CommentsVo dvo =dao.selectOne(sst, cmtno);
		//System.out.println(dvo);
		
		//만약 로그인 사원번호와 댓글 사원번호가 일치하면 삭제
		if (no.equals(dvo.getEmpNo()) ) {
			return dao.delete(sst, cmtno);
			
		}else {
			//일치하지 않은 경우
			return 0; 
		}
		
		
	}


	
    
    
}
