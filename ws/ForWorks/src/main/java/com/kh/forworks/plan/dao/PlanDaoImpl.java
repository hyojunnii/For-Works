package com.kh.forworks.plan.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.forworks.plan.dto.PlanDto;

@Repository
public class PlanDaoImpl implements PlanDao {
	

		@Inject
		private SqlSession sqlSession;

		//private static final String namespace = "com.kh.forworks.plan.dto";
		
		public List<PlanDto> showSchedule() throws Exception {
			//namespace + ".showSchedule"
			return sqlSession.selectList("planPopMapper.showSchedule");
		}
		
		public int addSchedule(PlanDto dto) throws Exception  {
			return sqlSession.insert("planPopMapper" + ".addSchedule", dto);
		}
		
		
		@Override
		public int deleteSchedule(PlanDto dto)  {
			return sqlSession.delete("planPopMapper" + ".deleteSchedule", dto);
		}
	}
			



