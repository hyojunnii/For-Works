package com.kh.forworks.qa.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class QAVo {
	//투표
	private String rownum;		//순번
	private String qaNo;		//투표번호
	private String qaSdate;	//시작일
	private String qaEdate;		//종료일
	private String qaUdate;	//수정일
	private String qaDdate;	//삭제일
	private String qaStatus;	//상태 :: 진행중 마감 삭제
	private String qaTitle;		//제목
	private String qaContent;	//내용
	private String empNo;		//사원이름
	private String num; 		//사원번호
	
	//파일 정보
	private MultipartFile qaFile;
	
	//대상자 분류  :: 전체 all, 부서별 dp
	private String target;
	
	//부서별로 선택되었을때 부서번호들
	private int[] dept;
	
	//로그인한 사원의 번호
	private String uno;
}
