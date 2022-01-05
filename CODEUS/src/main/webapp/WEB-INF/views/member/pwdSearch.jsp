<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="h-100">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>비밀번호 찾기</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="./resources/assets/images/favicon.png">
    <link href="./resources/assets/css/style.css" rel="stylesheet">
    <script src="./resources/js/jquery-3.6.0.min.js"></script>

</head>

<body class="h-100">
    <div class="authincation h-100">
        <div class="container-fluid h-100">
            <div class="row justify-content-center h-100 align-items-center">
                <div class="col-md-6">
                    <div class="authincation-content">
                        <div class="row no-gutters">
                            <div class="col-xl-12">
                                <div class="auth-form">
                                    <a href="${contextPath}" class="brand-logo">
                							<img class="logo-abbr" src="${contextPath}/resources/assets/images/mainlogo.png" alt="" style="border-radius: 100%; width: 250px; height: 120px; text-align : center;
                																														position: relative; left: 195px;">		
            						</a>
                                    <form action="pwdSearch.me" name="pwdSearch">
                                        <div class="form-group">
                                            <label><strong>아이디</strong></label>
                                            <input type="text" id="mId" name="mId" class="form-control">
                                            <label><strong>이름</strong></label>
                                            <input type="text" id="mName" name="mName" class="form-control">
                                            <label><strong>이메일</strong></label>
                                            <input type="text" id="email" name="email" class="form-control">
                                          
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary btn-block" onclick="joinMembercheck();">찾기</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- #/ container-fluid -->
    <!-- Common JS -->
    <script src="../vendor/global/global.min.js"></script>
    <!-- Custom script -->
    <script src="../vendor/quixnav/quixnav.min.js"></script>
    <script src="../js/quixnav-init.js"></script>
    <script src="../js/custom.min.js"></script>
    
    <script>
    	
    </script>
</body>

</html>