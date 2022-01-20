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
    <link rel="icon" type="image/png" sizes="16x16" href="${ contextPath }/resources/assets/images/favicon.png">
    <link href="${ contextPath }/resources/assets/css/style.css" rel="stylesheet">
    <script src="${ contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<style>
	.button{display: inline;}
	.display, .pwdUpdate{display: none;}
	strong{color: black;}
	.guide{display: none; font-size: small;}
</style>
</head>

<body class="h-100">
	
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
    
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
                                	<form id="pwdUpdateForm" action="pwdUpdate.me" method="post">
	                                    <div class="beforePwdUpdate"> 
	                                        <div class="form-group">
	                                            <label><strong>아이디</strong></label>
	                                            <input type="text" id="mId" name="mId" class="form-control"><br>
	                                            <label><strong>이름</strong></label>
	                                            <input type="text" id="mName" name="mName" class="form-control"><br>
	                                            <label><strong>이메일</strong></label>
	                                            <input type="text" id="email" name="email" class="form-control" autocomplete="off">
	                                            <!-- <div class="display"><span id="emailGuidev" class="text-danger" style="font-size: small;">이메일 형식으로 입력해 주세요.</span><br></div> -->
	                                            <span style="font-size: small; color: gray;">※회원가입시 입력했던 이메일을 입력해 주세요. 비밀번호 변경을 위한 인증 코드가 발송됩니다.</span><br><br>
	                                        </div>
	                                        <div STYLE='font-size: x-large; font-weight: bolder;'class="button">
	                                            <button id="pwdSearch" type="button" class="btn btn-primary btn-block">찾기</button>
	                                            <button type="button" class="btn btn-primary btn-block" onclick="location.href='${contextPath}'">취소</button>
	                                        </div>
	                                    </div>
                                    
                                   		<div class="pwdUpdate"> 
	                                    	<div id="inputArea">
	                                    		<span class="text-danger">*</span><label class="col-form-label"><strong>인증 코드</strong></label>
						                        <input id="authCode" type="text" name="authCode" class="form-control" required autocomplete="off">
						                        <span id="guide1" class="guide text-danger">인증 코드를 입력하세요.</span>
						                        <br>
						                        <span class="text-danger">*</span><label class="col-form-label"><strong>새 비밀번호</strong></label>
					                            <input id="mPwd" type="password" name="mPwd" class="form-control" required>
					                            <span id="guide2" class="guide text-danger">8~12자로 영어와 숫자, !*$만 가능합니다.(영어로 시작)</span>
					                            <br>
					                            <span class="text-danger">*</span><label class="col-form-label"><strong>새 비밀번호 확인</strong></label>
					                            <input id="mPwdCheck" type="password" name="mPwdCheck" class="form-control" required>
					                            <span id="guide3" class="guide text-danger">비밀번호가 일치하지 않습니다.</span>
					                            <br><br>
                                    		</div>
		                                    <div STYLE='font-size: x-large; font-weight: bolder;'class="button">
	                                            <button id="submitBtn" type="button" class="btn btn-primary btn-block">비밀번호 수정</button>
	                                            <button type="button" class="btn btn-primary btn-block" onclick="location.href='${contextPath}'">취소</button>
	                                        </div>
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
    <script>
    	
		// 찾기 버튼 클릭시 이메일로 인증 코드 발송 
		// 일치하는 회원 정보가 있고, 이메일이 유효할시 비밀번호 변경 화면으로 전환
		let authCode = "";
		$('#pwdSearch').on('click', function() {
			let mId = $('#mId').val().trim();
			let mName = $('#mName').val().trim();
			let email = $('#email').val().trim();
			
			
			if (mId == "") {
				alert('아이디를 입력해주세요.');
			} else if (mName == "") {
				alert('이름을 입력해주세요.');
			} else if (email == "") {
				alert('이메일을 입력해주세요.');
			} else {
				$.ajax({
					url: 'sendMail.me',
					data: {email:email, mName:mName, mId:mId},
					success: function(data){
						// console.log(data);
						if (data.length > 0 && data != "fail" && data != "notfound") {
							console.log(data)
							
							authCode = data.trim();
							$('.beforePwdUpdate').hide();
							$('.pwdUpdate').show();
							
						} else if (data == "notfound"){
							alert('일치하는 회원 정보가 없습니다.');
						} else {
							alert('유효한 이메일을 입력해주세요.');
						}
					},
					error: function(data){
						console.log(data);
						alert('유효한 이메일을 입력해주세요.');
					}
				});
			}
		});
		
		// 이메일로 보낸 인증코드와 일치하는지 검증 
		let authCodeCheck = false;
		
		$('#authCode').on('change keyup paste', function(){
			let inputCode = $(this).val().trim();
			
			if (inputCode != authCode) {
				$('#guide1').text('일치하지 않습니다.');
				$('#guide1').addClass('text-danger');
				$('#guide1').show();
				authCodeCheck = false;
			} else {
				$('#guide1').text('인증되었습니다.');
				$('#guide1').removeClass('text-danger').css('color', 'green');
				authCodeCheck = true;
			}
			
		});
		
        
        let pwdCheck = false; // 비밀번호 정규식 검사
        let pwdCheck2 = false; // 비밀번호 확인 일치 여부
        
        $('#mPwd').on('change blur keyup', function(){
        	
        	let regPwd = /^[A-Za-z]{1}[0-9A-Za-z!*$]{7,11}$/;
        	
        	let inputPwd = $(this).val().trim();
        	$(this).val(inputPwd);
        	
        	if (!regPwd.test(inputPwd)) {
				$('#guide2').text('8~12자로 영어와 숫자, !*$만 가능합니다.(영어로 시작)');
				$('#guide2').addClass('text-danger');
				$('#guide2').show();
				pwdCheck = false;
			} else {
				$('#guide2').text('사용 가능합니다.');
				$('#guide2').removeClass('text-danger').css('color', 'green');
				pwdCheck = true;
			}	        	
        	
        });
        
        // 비밀번호 확인 일치하는지 검증
        $('#mPwdCheck').on('change blur keyup', function(){
        	
        	let mPwdCheck = $(this).val().trim();
        	$(this).val(mPwdCheck);
			
        	if (mPwdCheck != $('#mPwd').val().trim()) {
        		$('#guide3').show();
        		pwdCheck2 = false;
        	} else {
        		$('#guide3').hide();
        		pwdCheck2 = true;
        	}
        	
        });
        
        
        // form 제출 전 입력사항 확인
		$('#submitBtn').on('click', function(){
													          
			if (!authCodeCheck) {
				$('#guide1').show();
				$('#authCode').focus();     
			} else if (!pwdCheck) {
				$('#guide2').show();
				$('#mPwd').focus();    
			} else if (!pwdCheck2) {
				$('#guide3').show();
				$('#mPwdCheck').focus();    
			} else {
				$('#pwdUpdateForm').submit();
			}
		});
        
        
         		
        // 메일 발송 전 없는 회원일시 메시지 가지고 리턴, 일치하는 회원정보가 없습니다. 또는 해당 사용자가 존재하지 않습니다.
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
		});
        
         			// sweet alert customize
			        var alert = function(msg, title, icon) {
			        	Swal.fire({
			        		position: 'top', // top : 상단 중앙에 띄우기
			        		background: '#292B30', // 알럿창 배경색
				       		color: 'white', // 글자색
			        		title : title, // 제목(큰 글씨)
			        		text : msg, // 내용(작은 글씨)
			        		icon: icon, // info, error 등 icon type
			        		showConfirmButton : false // ok버튼 표시 여부
			        	});
			         }
		
    </script>
        
	    <!-- Required vendors -->
	    <script src="${ contextPath }/resources/assets/vendor/global/global.min.js"></script>
	    <script src="${ contextPath }/resources/assets/js/quixnav-init.js"></script>
	    <script src="${ contextPath }/resources/assets/js/custom.min.js"></script>   
	    
	    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>  
    
</body>

</html>