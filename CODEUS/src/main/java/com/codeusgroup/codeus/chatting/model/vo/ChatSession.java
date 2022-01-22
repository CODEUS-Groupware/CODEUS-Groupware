package com.codeusgroup.codeus.chatting.model.vo;

import java.util.ArrayList;

import org.springframework.stereotype.Component;

@Component("chSession")
public class ChatSession {
	// static으로 필드변수를 설정하여 같은 ArrayList를 이용 할 수 있도록 선언합니다.
    private static ArrayList<String> loginUser = new ArrayList<String>();
    
    // 로그인 시 ArrayList에 추가합니다.
    public void addLoginUser(String email) {
        loginUser.add(email);
    }
    
    // 로그아웃 시 ArrayList에서 제거합니다.
    public void removeLoginUser(String email) {
        loginUser.remove(email);
    }
 
    // 현재 로그인 되어 있는 유저 목록을 가져옵니다.
    public static ArrayList<String> getLoginUser() {
        return loginUser;
    }
 
    // 자동 setter. 사용하진 않았습니다.
    public static void setLoginUser(ArrayList<String> loginUser) {
        ChatSession.loginUser = loginUser;
    }
}
