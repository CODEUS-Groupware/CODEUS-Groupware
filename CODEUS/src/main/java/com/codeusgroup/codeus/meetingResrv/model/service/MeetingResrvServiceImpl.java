package com.codeusgroup.codeus.meetingResrv.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codeusgroup.codeus.meetingResrv.model.dao.MeetingResrvDAO;

@Service("mrService")
public class MeetingResrvServiceImpl implements MeetingResrvService {
    
    @Autowired
    private MeetingResrvDAO mrDAO;
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
}
