package com.kh.forworks.comments.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.comments.vo.CommentsVo;

@Repository
public class CommentsDaoImpl implements CommentsDao{
	
	//댓글작성
	@Override
	public int insertCmt(SqlSessionTemplate sst, CommentsVo vo) {
		return sst.insert("commentsMapper.insertCmt",vo);
	}

	//댓글조회
	@Override
	public List<CommentsVo> selectList(SqlSessionTemplate sst, String no) {
		//System.out.println("매퍼 접근");
		return sst.selectList("commentsMapper.selectList", no);
	}
	
	//댓글삭제
	@Override
	public int delete(SqlSessionTemplate sst, String no) {
		return sst.update("commentsMapper.delete",no);
	}

	//삭제번호로 댓글정보가져오기
	@Override
	public CommentsVo selectOne(SqlSessionTemplate sst, String cmtNo) {
		return sst.selectOne("commentsMapper.selectOne", cmtNo);
	}

}
