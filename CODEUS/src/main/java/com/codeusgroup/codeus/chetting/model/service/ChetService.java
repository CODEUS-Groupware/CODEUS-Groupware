package com.codeusgroup.codeus.chetting.model.service;

import java.util.ArrayList;

import com.codeusgroup.codeus.chetting.model.vo.Chetting;

public interface ChetService {

	ArrayList<Chetting> selectChatroom(String userId);


}
