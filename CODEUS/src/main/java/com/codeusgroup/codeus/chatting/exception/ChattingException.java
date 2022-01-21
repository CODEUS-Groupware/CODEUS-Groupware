package com.codeusgroup.codeus.chatting.exception;

public class ChattingException extends RuntimeException {
	public ChattingException() {}
	public ChattingException(String msg) {
		super(msg);
	}
}