package com.codeusgroup.codeus.empStatus.model.service;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.empStatus.model.dao.EmpStatusDAO;
import com.codeusgroup.codeus.empStatus.model.vo.EmpStatus;

@Service("esService")
public class EmpStatusServiceImpl implements EmpStatusService{
	
	@Autowired
	private EmpStatusDAO esDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	

	@Override
	public int insertComTime(EmpStatus empStatus) {
		
		return esDAO.insertComTime(sqlSession, empStatus);
		
	}

	@Override
	public EmpStatus selectComTime(String id) {
		
		return esDAO.selectComTime(sqlSession, id);
	}

	@Override
	public int updateOffTime(EmpStatus empStatus) {
		
		return esDAO.updateOffTime(sqlSession, empStatus);
	}

	@Override
	public EmpStatus selectOffTime(String id) {
		
		return esDAO.selectOffTime(sqlSession, id);
	}

	@Override
	public int updateStatus(EmpStatus empStatus) {
		int result = esDAO.updateStatus(sqlSession, empStatus);
		return result;
	}

	
	


}
