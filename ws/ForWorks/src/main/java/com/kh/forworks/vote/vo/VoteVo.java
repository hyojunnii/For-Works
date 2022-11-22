package com.kh.forworks.vote.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class VoteVo {
	
	//투표
	private String rownum;		//순번
	private String vtNo;		//투표번호
	private String vtCreate;	//시작일
	private String vtEnd;		//종료일
	private String vtDtdate;	//삭제일
	private String vtUpdate;	//수정일
	private String vtStatus;	//상태 :: 진행중 마감 삭제
	private String vtTitle;		//제목
	private String vtContent;	//내용
	private String empNo;		//사원이름
	private String num; 		//사원번호
	
	//파일 정보
	private MultipartFile vtFile;
	
	//대상자 분류  :: 전체 all, 부서별 dp
	private String target;
	
	//부서별로 선택되었을때 부서번호들
	private int[] dept;
	
	//로그인한 사원의 번호
	private String uno;
}



