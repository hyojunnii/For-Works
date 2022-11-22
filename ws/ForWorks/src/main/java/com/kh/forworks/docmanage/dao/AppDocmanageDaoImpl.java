package com.kh.forworks.docmanage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.forworks.PageVo;
import com.kh.forworks.approv.vo.ApprovDocumentVo;
import com.kh.forworks.docmanage.vo.DocControlVo;
import com.kh.forworks.docmanage.vo.SignVo;
import com.kh.forworks.member.vo.MemberVo;

@Repository
public class AppDocmanageDaoImpl implements AppDocmanageDao{
	//부서 불러오기
	@Override
	public List<MemberVo> selectDept(SqlSessionTemplate sst) {
		return sst.selectList("docMapper.selectDept");
	}
	//해당직원의 전자결재문서 받아오기
	@Override
	public List<ApprovDocumentVo> selectDocByEmp(SqlSessionTemplate sst, HashMap map) {
		return sst.selectList("appMapper.DocByEmp",map);
	}
	//문서하나 받아오기
	@Override
	public List<DocControlVo> selectOneDoc(SqlSessionTemplate sst, String adocNo) {
		return sst.selectList("appMapper.selectOneDoc",adocNo);
	}
	//결재문서관리등록
	@Override
	public int insertDocCont(SqlSessionTemplate sst, DocControlVo vo) {
		return sst.insert("appMapper.insertDocCont",vo);
	}
	//해당직원이 작성한 총 갯수
	@Override
	public int selectTotalCnt(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("appMapper.selectCountAll" , empNo);
	}
	//관리등록한 결재문서리스트
	@Override
	public List<DocControlVo> selectContDocByEmp(SqlSessionTemplate sst, HashMap map) {
		PageVo pv =	(PageVo) map.get("pv");
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		String empNo = (String) map.get("empNo");
		return sst.selectList("appMapper.selectContDocByEmp" , empNo , rb);
	}
	//게시상태수정
	@Override
	public int updateStatus(SqlSessionTemplate sst, DocControlVo vo) {
		return sst.update("appMapper.updateStatus", vo);
	}
	//결재문서관리등록한 문서불러오기
	@Override
	public List<DocControlVo> selectContDetail(SqlSessionTemplate sst, String no) {
		return sst.selectList("appMapper.selectContDoc",no);
	}
	//결재문서등록 공개리스트
	@Override
	public List<DocControlVo> selectContDocList(SqlSessionTemplate sst, PageVo pv) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());

		return sst.selectList("appMapper.selectContDocList","",rb);
	}
	//결재문서리스트디테일(화면)
	@Override
	public DocControlVo selectAdocDetail(SqlSessionTemplate sst, String no) {
		return sst.selectOne("appMapper.selectAdoc",no);
	}
	//싸인+부서+직급받아오기
	@Override
	public List<SignVo> selectSign(SqlSessionTemplate sst, String adocNo) {
		return sst.selectList("appMapper.selectSign", adocNo);
	}
	//작성자 부서,직급,싸인 받아오기
	@Override
	public SignVo selectMemInfo(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("appMapper.selectMemInfo" , empNo);
	}
	//협조자 이름받기
	@Override
	public List<SignVo> selectCoo(SqlSessionTemplate sst, String adocNo) {
		return sst.selectList("appMapper.selectCoo", adocNo);
	}
	//파일받기
	@Override
	public List<ApprovDocumentVo> selectFile(SqlSessionTemplate sst, String adocNo) {
		return sst.selectList("appMapper.selectFile" , adocNo);
	}
	//contdoc받기
	@Override
	public List<DocControlVo> selectOneContDoc(SqlSessionTemplate sst, String no) {
		return sst.selectList("appMapper.selectOneContDoc" , no);
	}
	//직원별 비전자결재문서 총갯수
	@Override
	public int selectNoelectTotalCnt(SqlSessionTemplate sst, String empNo) {
		return sst.selectOne("appMapper.selectNoelectCountAll" , empNo);
	}
	//직원별 비전자결재문서 받아오기
	@Override
	public List<DocControlVo> selectNoelectEmp(SqlSessionTemplate sst, HashMap map) {
		PageVo pv =	(PageVo) map.get("pv");
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		String empNo = (String) map.get("empNo");
		return sst.selectList("appMapper.selectNoelectEmp" , empNo , rb);
	}
	//비전자결재문서 하나 불러오기
	@Override
	public DocControlVo selectOneNo(SqlSessionTemplate sst, String no) {
		return sst.selectOne("appMapper.selectOneNo",no);
	}
	//비전자결재문서 문서관리상태변경
	@Override
	public int updateNoStatus(SqlSessionTemplate sst, DocControlVo vo) {
		return sst.update("appMapper.updateNo",vo);
	}
	//비전자결재문서 게시중갯수
	@Override
	public int selectNoToTalCnt(SqlSessionTemplate sst) {
		return sst.selectOne("appMapper.selectNo");
	}
	//공개중 비전자결재가져오기
	@Override
	public List<DocControlVo> selectNoList(SqlSessionTemplate sst, PageVo pv) {
		int offset = (pv.getCurrentPage()-1) * pv.getBoardLimit();
		
		RowBounds rb = new RowBounds(offset, pv.getBoardLimit());
		return sst.selectList("appMapper.selectNoList","",rb);
	}
	//비전자결재 디테일
	@Override
	public DocControlVo selectNoDetail(SqlSessionTemplate sst, int no) {
		return sst.selectOne("appMapper.selectNoDetail",no);
	}
	//write에서 문서가져오기
	@Override
	public List<DocControlVo> selectNoSelectListEmp(SqlSessionTemplate sst, HashMap map) {
		return sst.selectList("appMapper.selectNoSelectList" ,map);
	}
	//write에서 문서하나선택
	@Override
	public List<DocControlVo> selectOneDoc2(SqlSessionTemplate sst, String adocNo) {
		return sst.selectList("appMapper.selectOneDoc2",adocNo);
	}
	//wirte에서 폼으로 control등록
	
}
