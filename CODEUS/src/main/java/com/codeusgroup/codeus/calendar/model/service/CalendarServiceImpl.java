package com.codeusgroup.codeus.calendar.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.calendar.model.dao.CalendarDAO;
import com.codeusgroup.codeus.calendar.model.vo.CalArrTemp;
import com.codeusgroup.codeus.calendar.model.vo.Calendar;
import com.codeusgroup.codeus.member.model.vo.Member;

@Service("cService")
public class CalendarServiceImpl implements CalendarService{
	
	@Autowired
	private CalendarDAO cDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Calendar> readCalList(String mId) {
		return cDAO.selectCalList(sqlSession, mId);
	}

	@Override
	public ArrayList<Calendar> readAdminCalList() {
		return cDAO.readAdminCalList(sqlSession);
	}

	@Override
	public int addCal(Calendar cal) {
		return cDAO.addCal(sqlSession, cal);
	}

	@Override
	public int addModalSch(Calendar cal) {
//		String seq = cDAO.scheNo(sqlSession);
//		map.put("seq", seq);
		int result2 = cDAO.addModalSch(sqlSession, cal);
		
		return result2;
	}

	@Override
	public ArrayList<Calendar> selectSchList(CalArrTemp cat) {
//		System.out.println("serviceCat1 : " + cat);
		return cDAO.selectSchList(sqlSession, cat);
	}
	public ArrayList<Calendar> selectadminSchList(CalArrTemp cat) {
		return cDAO.selectadminSchList(sqlSession, cat);
	}

	@Override
	public ArrayList<Calendar> selectNoCalSchList(CalArrTemp cat) {
//		System.out.println("serviceCat2 : " + cat);
		return cDAO.selectNoCalSchList(sqlSession, cat);
	}

	@Override
	public Calendar selectOneSch(int scheNo) {
		return cDAO.selectOneSch(sqlSession, scheNo);
	}

	@Override
	public ArrayList<Member> selectAtd(HashMap<String, String> map) {
		return cDAO.selectAtd(sqlSession, map);
	}

	@Override
	public ArrayList<Member> mSearchList(HashMap<String, String> map) {
		return cDAO.mSearchList(sqlSession, map);
	}

	@Override
	public ArrayList<String> findDelSchNo(HashMap<String, Object> map) {
		return cDAO.findDelSchNo(sqlSession, map);
	}

	@Override
	public ArrayList selectGroupId(HashMap<String, Object> map) {
		System.out.println("Service groupId map: " + map);
		return cDAO.selectGroupId(sqlSession, map);
	}
	@Override
	public int delSch(HashMap<String, Object> map) {
		return cDAO.delSch(sqlSession, map);
	}

	@Override
	public int addDetailSch(HashMap<String, Object> map) throws Throwable {
		// doEditSch() 메서드에서 호출했을 시 수정을 위한 삭제도 함께 하기 위해 체크
				if ("del".equals(map.get("checkDel"))) {
					cDAO.delSch(sqlSession, map);
				}
				
				// 참석자 fk_emp_no를 담은 배열
				// 모든 참석자의 [일정]과 [참석자] 테이블에 insert
					cDAO.addDetailSch(sqlSession, map);
					System.out.println("addDetailSch.ca service : " + map);
					// 일정 참석자 추가(다수)
				
				return 1;
	}

	@Override
	public int doEditSch(HashMap<String, Object> map) {
		return cDAO.doEditSch(sqlSession, map);
	}


}
