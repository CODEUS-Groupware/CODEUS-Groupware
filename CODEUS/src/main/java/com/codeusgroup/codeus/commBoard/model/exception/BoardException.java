package com.codeusgroup.codeus.commBoard.model.exception;

public class BoardException extends RuntimeException {
	private static final long serialVersionUID = -117671615579854799L;

	public BoardException() {}
	
	public BoardException(String msg) {
		super(msg);
	}
}
