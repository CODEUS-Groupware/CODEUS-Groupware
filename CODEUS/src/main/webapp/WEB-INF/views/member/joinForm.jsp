<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.joinArea{color: black; font-size: medium; margin-left: 10px;}
	.col-form-label{font-weight: bolder; width: 150px;}
	.form-col{padding-left: 15px;}
	.joinArea input{display: inline; width: 300px;}
	.joinArea select{ display: inline;  width: 300px;}
	.guide{display: none; margin-left: 165px; font-size: small;}
	.auth-form{color: black;}
	input{margin-bottom: 10px;}
</style>

    <link rel="icon" type="image/png" sizes="16x16" href="./resources/assets/images/favicon.png">
    <link href="./resources/assets/css/style.css" rel="stylesheet">
    
    <!-- flatpicker css  -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

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
                                    <div align="center">
	                                	<a class="brand-logo" >
	                						<img class="logo-abbr" src="${contextPath}/resources/assets/images/mainlogo.png" style="width: 250px; height: 120px;">		
	            						</a>
                                	</div>
                                    <form id="joinForm" action="join.me" method="post" autocomplete="off">
                                        <div class="joinArea">
                                            <br>
			                               	<span class="text-danger">*</span><label class="col-form-label">이름</label>
			                               	<input id="mName" type="text" name="mName" class="form-control" required maxlength="5"><br>
			                               	<div class="nameGuide guide">
                                            	<span id="nameGuide" class="text-danger"></span>
                                            	<br>
                                            </div>
			                               	<span class="text-danger">*</span><label class="col-form-label">아이디</label>
			                               	<input id="mId" type="text" name="mId" class="form-control" required maxlength="30"><br>
			                               	<div class="idGuide guide">
                                            	<span id="idGuide" class="text-danger"></span>
                                            	<br>
                                            </div>
			                               	<span class="text-danger">*</span><label class="col-form-label">비밀번호</label>
                                            <input id="mPwd" type="password" id="mPwd" name="mPwd" class="form-control"><br>
                                            <div class="pwdGuide guide">
                                            	<span id="pwdGuide" class="text-danger"></span>
                                            	<br>
                                            </div>
                                            <span class="text-danger">*</span><label class="col-form-label">비밀번호 확인</label>
                                            <input id="mPwdCheck" type="password" id="mPwdCheck" name="mPwdCheck" class="form-control"><br>
                                            <div class="pwdGuide2 guide">
                                            	<span id="pwdGuide2" class="text-danger"></span>
                                            	<br>
                                            </div>
			                               	<span class="text-danger">*</span><label class="col-form-label">이메일</label>
			                               	<input id="email" type="email" name="email" class="form-control" required maxlength="100">
			                               	<button id="mailConfirm" type="button" class="btn btn-outline-primary">이메일 인증</button
			                               	><br>
				                            <span class="text-danger">*</span><label class="col-form-label">인증코드</label>
				                            <input type="text" id="authCode" class="form-control" placeholder="인증 코드를 입력하세요."><br>
				                           	<div class="emailGuide guide">
                                            	<span id="emailGuide" class="text-danger"></span>
                                            	<br>
                                            </div>
                                            <span class="text-danger">*</span><label class="col-form-label">전화번호</label>
			                               	<input id="phone" type="text" name="phone" class="form-control" required maxlength="13" placeholder="-을 포함해 휴대전화 형식에 맞게 입력하세요."><br>
			                               	<div class="phoneGuide guide">
                                            	<span id="phoneGuide" class="text-danger">-을 포함해 휴대전화 형식에 맞게 입력하세요.</span>
                                            	<br>
                                            </div>
			                               	&nbsp;&nbsp;<label class="col-form-label">생년월일</label>
			                               	<div class="flatpickr" style="display: inline-block;">
												<input type="text" id="birthDate" name="inputBirthDate" class="form-control"  data-input>
												 
												<a class="input-button" title="toggle" data-toggle>
													<i class="icon-calendar"></i>
												</a>
												 
												<a id="clearBtn" class="input-button" title="clear" data-clear>
													<i class="icon-close"></i>
												</a>
											</div>
			                               	<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">우편번호</label>
			                               	<input type="text" id="post" name="post" class="form-control postcodify_postcode5" readonly>
											<button type="button" class="btn btn-outline-primary" id="postcodify_search_button">검색</button>
											<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">도로명 주소</label>
			                               	<input type="text" id="address1" name="address1" class="form-control postcodify_address" readonly>
			                               	<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">상세 주소</label>
											<input type="text" name="address2" class="form-control postcodify_extra_info">
											<br>
											<!-- jQuery와 Postcodify를 로딩. -->
											<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
											<script>
												// 검색 단추를 누르면 우편주소 검색창 팝업
												$(function(){
													$("#postcodify_search_button").postcodifyPopUp();
												});
											</script>
			                            <br> 	
				                        <div align="center">
			                            	<button type="button" class="btn btn-primary" id="btnSubmit">가입하기</button>
				                            <button type="reset" class="btn btn-outline-primary" onclick="location.href='${contextPath}'">취소</button>
			                            </div> 
                                    </div>
                                </form>
                                
                                <script>
                                	
                                	// 이름 형식 체크
                                	let nameCheck = false;
	                                $('#mName').on('change blur', function(){
	                                	let inputName = $(this).val().trim();
	                                	$(this).val(inputName);
	                                	
	                        			let regName = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{2}/; 
	                        			
	                        			if (!regName.test(inputName)) {
	                        				$('#nameGuide').text('한글로 된 2글자 이상으로 입력해 주세요.');
		                					$('#nameGuide').addClass('text-danger');
		                					$('.nameGuide').show();
		                					nameCheck = false;
		                				} else {
		                					$('#nameGuide').text('사용 가능합니다.');
		                					$('#nameGuide').removeClass('text-danger').css('color', 'green');
		                					nameCheck = true;
		                				}
	                        		});
	                                
	                             	// 아이디 형식 체크 및 중복 검사
                                	let idCheck = false;
	                        		$('#mId').on('change blur', function(){
	                        			let inputId = $(this).val().trim();
	                                	$(this).val(inputId);
	                        			
	                        			let regId = /^[A-Za-z]{1}[0-9A-Za-z]{3,11}$/;
	                        			
	                        			if (!regId.test(inputId)) {
	                        				$('#idGuide').text('4~12자로 영어와 숫자만 가능합니다.(영어로 시작)');
		                					$('#idGuide').addClass('text-danger');
		                					$('.idGuide').show();
		                					idCheck = false;
		                				} else {
		                					// 아이디 중복 검사
		                					$.ajax({
		                						url: 'dupId.me',
		                						data: {inputId:inputId},
			                					success: function(data){
			                						console.log(data);
			                						if (data.length > 0 && data == "noUsedId") {
			                							$('#idGuide').text('사용 가능합니다.');
					                					$('#idGuide').removeClass('text-danger').css('color', 'green');
					                					idCheck = true;
			                						} else if (data.length > 0 && data == "usedId"){
			                							$('#idGuide').text('이미 사용 중인 아이디입니다.');
					                					$('#idGuide').addClass('text-danger');
					                					$('.idGuide').show();
					                					idCheck = false;
			                						} else {
			                							alert('알 수 없는 에러가 발생했습니다.');
			                							idCheck = false;
			                						}
			                					},
			                					error: function(data){
			                						console.log(data);
			                						alert('알 수 없는 에러가 발생했습니다.');
			                						idCheck = false;
			                					}
		                					});
		                				}
	                        		});
	                        		
	                        		
	                        		let pwdCheck = false; // 비밀번호 정규식 검사
	                                let pwdCheck2 = false; // 비밀번호 확인 일치 여부
	                                $('#mPwd').on('keyup', function(){
	                                	
	                                	let regPwd = /^[A-Za-z]{1}[0-9A-Za-z!*$]{7,11}$/;
	                                	
	                                	let inputPwd = $(this).val().trim();
	                                	$(this).val(inputPwd);
	                                	
	                                	if (!regPwd.test(inputPwd)) {
		                					$('#pwdGuide').text('8~12자로 영어와 숫자, !*$만 가능합니다.(영어로 시작)');
		                					$('#pwdGuide').addClass('text-danger');
		                					$('.pwdGuide').show();
		                					pwdCheck = false;
		                				} else {
		                					$('#pwdGuide').text('사용 가능합니다.');
		                					$('#pwdGuide').removeClass('text-danger').css('color', 'green');
		                					pwdCheck = true;
		                				}	        	
	                                	
	                                });
	                                
	                                $('#mPwdCheck').on('change blur keyup', function(){
	                                	
	                                	let mPwdCheck = $(this).val().trim();
	                                	$(this).val(mPwdCheck);
	                        			
	                                	if (mPwdCheck != $('#mPwd').val().trim()) {
	                                		$('#pwdGuide2').text('비밀번호가 일치하지 않습니다.');
		                					$('#pwdGuide2').addClass('text-danger');
	                                		$('.pwdGuide2').show();
	                                		pwdCheck2 = false;
	                                	} else {
	                                		$('#pwdGuide2').text('일치합니다.');
		                					$('#pwdGuide2').removeClass('text-danger').css('color', 'green');
		                					pwdCheck2 = true;
	                                	}
	                                	
	                                });
                                	
		                			
		                			// 이메일 인증 위한 메일 발송
		                			let authCode = "";
		                			let emailCheck = false;
		                			let authCodeCheck = false;
		                			$('#mailConfirm').on('click', function(){
		                				$('.emailCheck').show();
		                				let email = $('#email').val().trim();
		                				
		                				if (email != "") {
		                					$.ajax({
			                					url: 'sendJoinMail.me',
			                					data: {email:email},
			                					success: function(data){
			                						if (data.length > 0 && data != "fail") {
			                							authCode = data.trim();
			                							$('#emailCheck').show();
			                							$('#authCode').focus();
			                							emailCheck = true;
			                						} else {
			                							alert('유효한 이메일을 입력해주세요.');
			                						}
			                					},
			                					error: function(data){
			                						console.log(data);
			                						alert('유효한 이메일을 입력해주세요.');
			                					}
			                				});
		                				} else {
		                					alert('이메일을 입력해주세요.');
		                				}
		                				
		                			});
		                			
		                			// 이메일로 보낸 인증코드와 일치하는지 검증
		                			$('#authCode').on('change keyup paste', function(){
		                				let inputCode = $(this).val().trim();
		                				
		                				if (inputCode != authCode) {
		                					$('#emailGuide').text('일치하지 않습니다.');
		                					$('#emailGuide').addClass('text-danger');
		                					$('.emailGuide').show();
		                					authCodeCheck = false;
		                				} else {
		                					$('#emailGuide').text('인증되었습니다.');
		                					$('#emailGuide').removeClass('text-danger').css('color', 'green');
		                					authCodeCheck = true;
		                				}
		                				
		                			});
		                			
		                			// 휴대전화 형식 체크
		                			let phoneCheck = false;
		                			$('#phone').on('change keyup paste', function(){
		                				
		                				let phone = $(this).val().trim();
		                				$(this).val(phone);
		                				
		                				var regExpPhone = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
		                				
		                				if (!regExpPhone.test(phone)) {
		                					$('#phoneGuide').text('-을 포함해 휴대전화 형식에 맞게 입력하세요.');
		                					$('#phoneGuide').addClass('text-danger');
		                					$('.phoneGuide').show();
		                					phoneCheck = false;
		                				} else {
		                					$('#phoneGuide').text('사용 가능합니다.');
		                					$('#phoneGuide').removeClass('text-danger').css('color', 'green');
		                					phoneCheck = true;
		                				}
		                				
		                			});
		                			
		                			$('#introduce').on('change', function(){
		                				 $(this).val($(this).val().trim());
		                			});
		                			
		                			
									// submit했을때 검증
		                			$('#btnSubmit').on('click', function(){
										
		                				if (!nameCheck) {
		                					$('#mName').focus();    
	                        			} else if (!idCheck) {
	                        				$('#mId').focus(); 
	                        			} else if (!pwdCheck) {
		                					$('#mPwd').focus();    
	                        			} else if (!pwdCheck2) {
	                        				$('#mPwdCheck').focus();    
	                        			} else if ($('#email').val().trim() == "") {
		                					alert('이메일은 필수 입력사항입니다.');
		                				} else if (!emailCheck) {
		                					alert('이메일 인증을 진행해주세요.');
		                				} else if (!authCodeCheck) {
		                					alert('인증코드가 일치하지  않습니다.');
		                					$('#authCode').focus();
		                				} else if (!phoneCheck) {
		                					$('#phone').focus();
		                				} else {
		                					$('#joinForm').submit();
		                				}
		                				
		                			});
                            	</script>
                            	
                            	<!-- flatpicker cdn  -->
								<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
								<script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
								<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
                            	<script>
                            		let now = new Date();
                            		let oneYearAgo = new Date(now.setFullYear(now.getFullYear() - 100));
                            		
	                            	// 생년월일은 100년 전부터 오늘 날짜까지만 선택 가능
	                            	const $flatpickr = $("#birthDate").flatpickr({
	                            		dateFormat: "Y-m-d",
	                            		minDate : oneYearAgo,
	                            		maxDate: "today",	
	                            		"locale": "ko" // 언어 한글로 설정
	                            	});
	                            	
	                            	flatpickr.localize(flatpickr.l10ns.ko);
	                            	flatpickr("mySelector");
	                            	
	                            	// 입력한 데이터 지우기 버튼
	                            	$("#clearBtn").click(function() {
	                            	   $flatpickr.clear();
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>