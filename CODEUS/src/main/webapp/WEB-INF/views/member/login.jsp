<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="h-100">
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>CODEUS 로그인 </title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="./resources/assets/images/favicon.png">
    <link href="./resources/assets/css/style.css" rel="stylesheet">
	<%-- <script src="${contextPath}/resources/js/jquery-3.6.0.min.js"></script> --%>
 
</head>

<body class="h-100">

	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	

    <!--**********************************
        Scripts
    ***********************************-->
    <!-- Required vendors -->
	 <script src="./resources/assets/vendor/global/global.min.js"></script>
	 <script src="./resources/assets/js/quixnav-init.js"></script>
	 <script src="./resources/assets/js/custom.min.js"></script>   
	 
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
                                    <form action="login.me" method="post">
                                        <div class="form-group">
                                            <label><strong>아이디</strong></label>
                                            <input type="text" name="mId" class="form-control" placeholder="아이디를 입력하세요">
                                        </div>
                                        <div class="form-group">
                                            <label><strong>비밀번호</strong></label>
                                            <input type="password" name="mPwd" class="form-control" placeholder="비밀번호를 입력하세요">
                                        </div>
                                        <div class="form-row d-flex justify-content-between mt-4 mb-2">
                                        	
                                        	<div class="form-group">
                                                <p><a href="idSearchView.me">아이디를 잊으셨나요?</a></p>
                                                <a href="pwdSearchView.me">비밀번호를 잊으셨나요?</a>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <button name="loginBtn" class="btn btn-primary btn-block">로그인</button>
                                        </div>
                                    </form>
                                    <div class="new-account mt-3">
                                        <p>아직 회원이 아니신가요? <a class="text-primary" href="joinMemberView.me">회원가입</a></p>
                                    </div>
                                    
                                     <!-- 회원정보가 일치하지 않을 때 -->
                                        <c:if test="${check == 1}">
											<script>
												opener.document.idSearch.name.value = "";
												opener.document.idSearch.email.value = "";
											</script>
											<script>
												alert("일치하는 회원정보가 없습니다.");
												
												<c:remove var="check" scope="request"/>
								                history.replaceState({}, null, '${ contextPath }/');
								                
								                var alert = function(msg, title, icon) {
						                            Swal.fire({
						                                position: 'top',
						                                background: 'white',
						                                color: 'black',
						                                title : title,
						                                text : msg,
						                                icon: icon,
						                                // timer : 1500,
						                                customClass : 'sweet-size',
						                                showConfirmButton : true
						                            });
						                        }
											</script>
										</c:if>

										<!-- 회원정보가 일치 할 때 -->
										<c:if test="${check == 0 }">
											<script>
												alert("회원님의 아이디는' ${id}' 입니다.");
												<c:remove var="check" scope="request"/>
							                    history.replaceState({}, null, '${ contextPath }/');
							                    
							                    var alert = function(msg, title, icon) {
						                            Swal.fire({
						                                position: 'top',
						                                background: 'white',
						                                color: 'black',
						                                title : title,
						                                text : msg,
						                                icon: icon,
						                                // timer : 1500,
						                                customClass : 'sweet-size',
						                                showConfirmButton : true
						                            });
						                        }
											</script>
							
										</c:if>
										
										<script>
            								$(function(){
							                    if ('${msg}' != '') {
							                        var msg = '${msg}';
							                        if (msg == '1') {
							                            msg = '관리자에 의해 중지된 계정입니다.'
							                        } else if(msg == '2') {
							                            msg = '관리자의 가입 승인이 필요합니다.'
							                        } else {
							                            msg = '아이디 또는 비밀번호가 잘못 입력 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.'
							                        }
							                         alert(msg)
							                        <c:remove var="msg" scope="request"/>
							                        history.replaceState({}, null, '${ contextPath }/');
							                    }
			            					
							                    var alert = function(msg, title, icon) {
						                            Swal.fire({
						                                position: 'top',
						                                background: 'white',
						                                color: 'black',
						                                title : title,
						                                text : msg,
						                                icon: icon,
						                                // timer : 1500,
						                                customClass : 'sweet-size',
						                                showConfirmButton : true
						                            });
						                        }
            								});
			
					                        
        								</script>
        								 <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
									
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>

</html>