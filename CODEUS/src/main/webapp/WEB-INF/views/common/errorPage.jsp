<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html class="h-100">
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title> errorPage </title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/resources/assets/images/favicon.png">
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
</head>

<body class="h-100">
	
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	
    <div class="authincation h-100">
        <div class="container-fluid h-100">
            <div class="row justify-content-center h-100 align-items-center">
                <div class="col-md-5">
                    <div class="form-input-content text-center">
                        <div class="mb-5">
                        	<c:if test="${ error_code ne '403' && loginUser != null }"> 
                            	<a class="btn btn-primary" href="javascript:history.back()">이전 페이지</a> 
                            </c:if>
                            <c:if test="${ error_code eq '403' || loginUser == null }"> <!-- 403, 즉 접근 불가 에러일 경우 시작 페이지로 이동하는 버튼 -->
                            	<a class="btn btn-primary" href="${ contextPath }">시작 페이지</a> 
                            </c:if>
                        </div>
                        <h1 class="error-text font-weight-bold">${ error_code }</h1>
                        <h4 class="mt-4"><i class="fa fa-exclamation-triangle text-warning"></i> ${ msg }</h4>
                        <!-- 나중에 삭제  --><p><%= request.getAttribute("javax.servlet.error.message") %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>