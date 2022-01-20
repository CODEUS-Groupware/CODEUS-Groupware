package com.codeusgroup.codeus.common;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.FORBIDDEN) // 해당 예외가 호출되면 Forbidden status, 403 error code가 반환됨
public class ForbiddenException extends RuntimeException {
	
    public ForbiddenException(String message) {
        super(message);
    }
}
