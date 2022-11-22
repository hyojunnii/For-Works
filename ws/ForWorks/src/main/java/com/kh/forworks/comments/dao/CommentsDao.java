package com.kh.forworks.comments.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.forworks.comments.vo.CommentsVo;

public interface CommentsDao {

	//댓글작성
	int insertCmt(SqlSessionTemplate sst, CommentsVo vo);

	//댓글조회
	List<CommentsVo> selectList(SqlSessionTemplate sst, String no);

	//댓글삭제
	int delete(SqlSessionTemplate sst, String no);
	
	//삭제번호로 댓글정보가져오기
	CommentsVo selectOne(SqlSessionTemplate sst, String cmtNo);

}
