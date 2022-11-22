package com.kh.forworks.qa.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.forworks.PageVo;
import com.kh.forworks.department.vo.DepartmentVo;
import com.kh.forworks.member.vo.MemberVo;
import com.kh.forworks.qa.dao.QADao;
import com.kh.forworks.qa.vo.QAAnswerVo;
import com.kh.forworks.qa.vo.QAAttachmentsVo;
import com.kh.forworks.qa.vo.QACategoryVo;
import com.kh.forworks.qa.vo.QAParticipationVo;
import com.kh.forworks.qa.vo.QAVo;


@Service
public class QAServiceImpl implements QAService{
	private final SqlSessionTemplate sst;
	private final QADao dao;
	
	@Autowired
	public QAServiceImpl(SqlSessionTemplate sst, QADao dao) {
		this.sst = sst;
		this.dao = dao;
	}
	
	//부서정보
	@Override
	public List<DepartmentVo> selectAlldp() {
		return dao.selectAlldp(sst);
	}
	
	//전체  //개수
	@Override
	public int selectTotalCount() {
		return dao.selectTotalCount(sst);
	}
	//리스트
	@Override
	public List<QAVo> selectList(PageVo pv) {
		return dao.selectList(sst, pv);
	}
	
	//진행중 //개수
	@Override
	public int selecting(String no) {
		return dao.selecting(sst,no);
	}
	//리스트
	@Override
	public List<QAVo> selectListing(PageVo pving, String no) {
		return dao.selectListing(sst, pving, no);
	}
	
	//마감 //개수
	@Override
	public int selectEnd(String no) {
		return dao.selectEnd(sst, no);
	}
	//리스트
	@Override
	public List<QAVo> selectListEnd(PageVo pvend, String no) {
		return dao.selectListEnd(sst, pvend, no);
	}
	
	
	//생성
	@Override
	public int insertQA(QAVo qavo, String[] qacgArr, QAAttachmentsVo qaatVo) {
		int[] result =  new int[4];
		//설문 테이블에 정보 저장
		result[0]=dao.insertQa(sst, qavo);
		
		//파일 유무 확인후 첨부파일 테이블에 저장
		//System.out.println(qaatVo==null);
		
		if (qaatVo != null) {
			result[1]=dao.insertQaAt(sst, qaatVo);
		}else {result[1]=1;}
		
		//항목 
		for (int i = 0; i < qacgArr.length; i++) {
			//System.out.println(qacgArr[i]);
			//항목개수 만큼 insert작업
			result[2]=dao.insertQacg(sst,qacgArr[i]);
		}
		
		//참가인원
		qavo.getTarget(); //all , dp 인지 판별
		qavo.getDept();
		
		if (qavo.getTarget().equals("all")) {
			//all 이면 모든 회원 정보를
			//모든회원정보 가져오기
			List<MemberVo> memberListAll = dao.mListAll(sst);
			//대상자 테이블에 입력
			
			for(int i=0; i<memberListAll.size(); i++ ) {
				result[3]=dao.insertQapt(sst, memberListAll.get(i));
				if (result[3] != 1) {
					return -1;
				}
			}

		}else if(qavo.getTarget().equals("dp")) {
			//dp이면 qavo.getDept()배열안에 있는 부서정보만 
			for (int i = 0; i < qavo.getDept().length; i++) {
				//부서 정보 리스트 가져오기
			//	System.out.println(qavo.getDept()[i]);
				List<MemberVo> memberListDp = dao.mListDp(sst,qavo.getDept()[i]);
				//가져온 정보 
				for(int j=0; j < memberListDp.size(); j++) {
					result[3]=dao.insertQapt(sst, memberListDp.get(j));
					if (result[3] != 1) {
						return -2;
					}
				}
				
			}
		}
		
		
		return result[0]*result[1]*result[2]*result[3];
	}
	
	//설문 정보 가져오기
	@Override
	public QAVo selectOneQa(String pno) {
		return dao.selectOneQa(sst,pno);
	}
	//설문 항목정보 가져오기
	@Override
	public List<QACategoryVo> selectQacg(String pno) {
		return dao.selectQacg(sst,pno);
	}
	//설문 대상자 정보 가져오기
	@Override
	public List<QAParticipationVo> selectQapt(String pno) {
		return dao.selectQapt(sst,pno);
	}
	//설문 첨부파일 정보 가져오기	
	@Override
	public QAAttachmentsVo seleQaat(String pno) {
		return dao.selectQaat(sst, pno);
	}
	//설문 종료
	@Override
	public int QAEnd(int pno) {
		return dao.end(sst, pno);
	}
	//설문 삭제
	@Override
	public int qaDelete(int pno) {
		return dao.delete(sst,pno);
	}

	//설문 작성하기
	@Override
	public int insertUserQA(QAAnswerVo awvo, QAParticipationVo checkpt, HashMap<String, String> map) {
		int[] result = new int[2];
		
		
		//설문 항목에대한 답변 등록
		
		String[] awgArr =awvo.getQaawContent().split(",");
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("pno", checkpt.getQaNo());
		map2.put("no", checkpt.getEmpNo());
		int[] num = new int[awgArr.length];
		
		for (int i = 0; i < awgArr.length; i++) {
			num[i]= i+1;
//			System.out.println(awgArr[i]);
//			System.out.println(num[i]);
			String n = String.valueOf(num[i]);
			map.put("num",n);
			map.put("answer",awgArr[i]);
			
			result[0] = dao.insertUserQA(sst, map);
		}
		result[1] = dao.updateSt(sst,map2);
//		System.out.println(result[0]);
//		System.out.println(result[1]);
		
		return result[0]*result[1];
	}
	
	//로그인 사원이 대상자 인지 확인
	@Override
	public int check(HashMap<String, String> map) {
		return dao.check(sst, map);
	}

	//대상자중 참여한 설문정보 가져오기
	@Override
	public List<QAAnswerVo> checkAnswer(HashMap<String, String> map) {
		return dao.checkAnswer(sst,map);
	}
	
	// 설문 첨부파일 확인
	@Override
	public QAAttachmentsVo checkFile(String pno) {
		return dao.checkFile(sst,pno);
	}
	
	//설문내용 수정
	@Override
	public int edit(QAVo qavo, String[] qacgArr, QAAttachmentsVo qaat, QAAttachmentsVo qaatCheck, String pno) {
		int[] result = new int[4]; 

		//설문 내용수정
		result[0] = dao.editQa(sst,qavo);
		
		//설문 첨부파일 확인후 update||insert 선택
		//파일을 수정하는지 확인
		//System.out.println("공백여부::"+!(qavo.getQaFile().isEmpty()));
		if (!(qavo.getQaFile().isEmpty())) {
			if (qaatCheck !=null) {
				//System.out.println("파일있음");
				result[1] = dao.editQaat(sst,qaat);
				//System.out.println("파일수정완료");
			}else if(qaatCheck ==null) {
				//System.out.println("파일없음");
				result[1] = dao.editQaatInsert(sst, qaat);
				//System.out.println("파일등록완료");
			}
		}else {result[1]=1;}
		//추가된 항목이 있는지 확인후 insert
		if(qacgArr != null) {
			for (int i = 0; i < qacgArr.length; i++) {
				//System.out.println(qacgArr[i]);
				//항목개수 만큼 insert작업
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("qacg", qacgArr[i]);
				map.put("pno", qavo.getQaNo());
				result[2]=dao.editInsertQacg(sst,map);
			}
			
		}else {result[2]=1;}
//		System.out.println(result[0]);
//		System.out.println(result[1]);
//		System.out.println(result[2]);
		return result[0]*result[1]*result[2];	}

	@Override
	public QAParticipationVo checkQA(HashMap<String, String> map) {
		return dao.checkQa(sst,map);
	}

	//설문 참여자 답변내용
	@Override
	public List<QAAnswerVo> selectQaaw(String pno) {
		return dao.selectQaaw(sst,pno);
	}

	//설문 참가자수 가져오기
	@Override
	public int selectNum(String pno) {
		return dao.selectNum(sst, pno);
	}

	//답변수정
	@Override
	public int editAw(QAAnswerVo awvo, String no) {
		
		int[] result = new int[2];
		HashMap<String, String> map = new HashMap<String, String>();
		
		String[] awgArr =awvo.getQaawContent().split(",");
		int[] num = new int[awgArr.length];
		List<QAAnswerVo> awlist =  new ArrayList<QAAnswerVo>();
		for (int i = 0; i < awgArr.length; i++) {
			num[i]= i+1;
//			System.out.println(awgArr[i]);
//			System.out.println(num[i]);
			String n = String.valueOf(num[i]);
			map.put("num",n);
			map.put("answer",awgArr[i]);
			map.put("pno", awvo.getQaNo());
			map.put("no", no);
			result[0] = dao.editAw(sst, map );
			result[1] = dao.updateSt2(sst,map);
		}
		
		return result[0]*result[1];
	}


	
	
}
