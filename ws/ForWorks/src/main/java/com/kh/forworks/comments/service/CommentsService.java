package com.kh.forworks.comments.service;

import java.util.List;

import com.kh.forworks.comments.vo.CommentsVo;

public interface CommentsService {

	//댓글 작성
	int write(CommentsVo vo);
	
	//댓글 조회
	List<CommentsVo> selectList(String no);

	//뎃글 삭제
	int delete(String cmtno, String no);


}
