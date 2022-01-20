<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="h-100">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>아이디 찾기</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="./resources/assets/images/favicon.png">
    <link href="./resources/assets/css/style.css" rel="stylesheet">
    <script src="./resources/js/jquery-3.6.0.min.js"></script>
<style>
	.auth-form{color: black;}
	input{margin-bottom: 10px;}
</style>
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
                                    <div align="center">
	                                	<a href="${contextPath}" class="brand-logo" >
	                						<img class="logo-abbr" src="${contextPath}/resources/assets/images/mainlogo.png" style="width: 250px; height: 120px;">		
	            						</a>
                               	 	</div>
                                    <form action="idSearch.me" name="idSearch">
                                        <div class="form-group">
                                            <label><strong>이름</strong></label>
                                            <input type="text" id="mName" name="mName" class="form-control" required>
                                            <label><strong>이메일</strong></label>
                                            <input type="email" id="email" name="email" class="form-control" required>
                                          
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary btn-block" onclick="joinMemberCheck();">찾기</button>
                                        </div>
                                        
                                        <!-- 회원정보가 일치하지 않을 때 -->
                                        <c:if test="${check == 1}">
											<script>
												opener.document.idSearch.name.value = "";
												opener.document.idSearch.email.value = "";
											</script>
											<label>일치하는 정보가 존재하지 않습니다.</label>
										</c:if>

										<!-- 회원정보가 일치 할 때 -->
										<c:if test="${check == 0 }">
											<script>
												// alert("찾으시는 아이디는' ${id}' 입니다.");
											</script>
										</c:if>

									</form>
	
									<script type="text/javascript">
										function closethewindow(){
										self.close();
										}
									</script>
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
	<script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
    <!-- Custom script -->
    <script src="${contextPath}/resources/assets/vendor/quixnav/quixnav.min.js"></script>
    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>

</html>