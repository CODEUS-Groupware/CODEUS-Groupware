<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	.member-update{color: black; font-size: medium; margin-left: 10px;}
	.col-form-label{font-weight: bolder; width: 150px;}
	.form-col{padding-left: 15px;}
	.member-update input{display: inline;}
	.profile-photo{margin-top: 20px; margin-top: 60px; margin-left: 30px;}
	.profile-photo label{display: inline; position: absolute; top: 210px; left: 180px;}
	.profile-photo img{width: 150px; height: 150px;}
	.member-update input[type=date], .member-update input[type=text], 
	.member-update select, .member-update input[type=email]{
		display: inline;  width: 395px;
	}
	.guide{display: none; margin-left: 165px; font-size: small;}
</style>
</head>
<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../common/menubar.jsp"/>
    
        <!--**********************************
            Content body start
        ***********************************-->
 		<div class="content-body">
            <div class="container-fluid">
             	<div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                       <b style="color: black; font-size: large;">내 정보 수정</b>
                   	</div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                           		<div class="member-update">
                                   <form id="updateForm" action="${ contextPath }/memberUpdate.mp" method="post" encType="multipart/form-data">
	                                    <div class="email-left-box px-0 mb-5">
	                                        <div class="profile-photo">
	                                        	<c:if test="${ loginUser.imgChangeName eq null }">
					                                <img src="${contextPath}/resources/assets/images/empty-profile.png" alt="profile-image" id="profile-image">
					                            </c:if>
					                            <c:if test="${ loginUser.imgChangeName ne null }">
					                               	<img src="${contextPath}/resources/uploadFiles/${ loginUser.imgChangeName }" alt="profile-image" id="profile-image">
					                            </c:if>
											    <label for="input-image">
											        <i class="fa fa-camera" style="color: black; font-size: xx-large;"></i> <!-- class="fa fa-pencil" -->
											    </label>
											    <input type="file" id="input-image" name="reloadImg" accept=".jpg,.jpeg,.png,.gif" style="display: none;"/>
			                               	</div>
			                            </div>
			                            <br>
			                            <div class="email-right-box ml-0 ml-sm-4 ml-sm-0">
			                               	<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">이름</label>${ loginUser.mName }
			                               	<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">아이디</label>${ loginUser.mId }
			                               	<br>
			                               	<span class="text-danger">*</span><label class="col-form-label">이메일</label>
			                               	<input id="email" type="email" name="email" class="form-control" value="${ loginUser.email }" required maxlength="100">
			                               	<button id="mailConfirm" type="button" class="btn btn-outline-primary" disabled>이메일 인증</button><br>
			                               	<div id="emailCheck">
				                               	&nbsp;&nbsp;<label class="col-form-label">인증코드</label>
				                               	<input type="text" id="authCode" class="form-control" placeholder="인증 코드를 입력하세요."><br>
				                               	<span id="emailGuide" class="text-danger guide">인증 코드가 일치하지 않습니다.</span><br>
			                               	</div>
			                               	<span class="text-danger">*</span><label class="col-form-label">전화번호</label>
			                               	<input id="phone" type="text" name="phone" class="form-control" value="${ loginUser.phone }" required  maxlength="13" placeholder="-을 포함해 휴대전화 형식에 맞게 입력하세요."><br>
			                               	<div class="phoneGuide guide">
			                               		<span id="phoneGuide" class="text-danger">-을 포함해 휴대전화 형식에 맞게 입력하세요.</span>
			                               		<br>
			                               	</div>
			                               	&nbsp;&nbsp;<label class="col-form-label">생년월일</label>
			                               	<input type="text" id="birthDate" name="birthDate" class="form-control" value="${ loginUser.birthDate }" readonly>
			                               	<br>
			                               	<c:forTokens var="addr" items="${ loginUser.address }" delims="/" varStatus="status">
												<c:if test="${ status.index eq 0 && addr >= '0' && addr <= '99999' }">
													<c:set var="post" value="${ addr }"/>
												</c:if>
												<c:if test="${ status.index eq 0 && !(addr >= '0' && addr <= '99999') }">
													<c:set var="address1" value="${ addr }"/>
												</c:if>
												<c:if test="${ status.index eq 1 }">
													<c:set var="address1" value="${ addr }"/>
												</c:if>
												<c:if test="${ status.index eq 2 }">
													<c:set var="address2" value="${ addr }"/>
												</c:if>
											</c:forTokens>
			                               	&nbsp;&nbsp;<label class="col-form-label">우편번호</label>
			                               	<input type="text" id="post" name="post" class="form-control postcodify_postcode5" value="${ post }" readonly>
											<button type="button" class="btn btn-outline-primary" id="postcodify_search_button">검색</button>
											<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">도로명 주소</label>
			                               	<input type="text" id="address1" name="address1" class="form-control postcodify_address" value="${ address1 }" readonly>
			                               	<br>
			                               	&nbsp;&nbsp;<label class="col-form-label">상세 주소</label>
											<input type="text" name="address2" class="form-control postcodify_extra_info" value="${ address2 }">
											<br>
											<!-- jQuery와 Postcodify를 로딩. -->
											<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
											<script>
												// 검색 단추를 누르면 우편주소 검색창 팝업
												$(function(){
													$("#postcodify_search_button").postcodifyPopUp();
												});
											</script>
			                               	<div class="form-group row">
	                                             &nbsp;&nbsp;<label class="form-col col-form-label">자기소개</label>
	                                             <div class="col-lg-6">
	                                                 <textarea id="introduce" name="profile" rows="3" class="form-control" style="resize: none; width: 400px;" maxlength="160">${ loginUser.profile }</textarea>
	                                             </div>
	                                        </div>
			                            </div> 
			                            <br> 	
			                            <input type="hidden" name="mId" value="${ loginUser.mId }">
			                            <input type="hidden" name="imgChangeName" value="${ loginUser.imgChangeName }">
			                            <input type="hidden" name="imgOriginName" value="${ loginUser.imgOriginName }">
				                        <div align="center">
			                            	<button type="button" class="btn btn-primary" id="btnSubmit">저장</button>
				                            <button type="reset" class="btn btn-outline-primary">취소</button>
			                            </div> 
		                            </form>     	
                                </div>
                               	<!-- datepicker cdn  -->
								<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
                                <script>
                                	// 이미지 미리보기
		                			function readImage(input) {
		                				
		                				if(input.files && input.files[0]) {
	
		                					const reader = new FileReader();
	
		                					reader.onload = function(e){
		                						const previewImage = document.getElementById("profile-image");
		                						previewImage.src = e.target.result;
		                					}
		                						
		                					reader.readAsDataURL(input.files[0]);
		                				}
		                			}
		                							
		                			const inputImage = document.getElementById("input-image");
		                			inputImage.addEventListener("change", function(e){readImage(e.target)});		
		                			
		                			$(function(){
		                				$('#emailCheck').hide();
		                				$('.guide').hide();
		                			});
		                			
		                			// 이메일 입력란 변경사항 있을시 이메일 인증 버튼 활성화
		                			let emailCheck = true;
		                			let originEmail = '${loginUser.email.trim()}';
		                			
		                			$('#email').on('change keyup paste', function() {
		                				let inputEmail = $(this).val().trim();
		                				
		                				if (originEmail.trim() != inputEmail) {
		                					$('#mailConfirm').prop('disabled', false);
		                					emailCheck = false;
		                				} else {
		                					$('#mailConfirm').prop('disabled', true);
		                					$('#emailCheck').hide();
		                					emailCheck = true;
		                				}
		                			});
		                			
		                			// 이메일 인증 위한 메일 발송
		                			let authCode = "";
		                			let authCodeCheck = false;
		                			$('#mailConfirm').on('click', function(){
		                				$('#emailCheck').show();
		                				let email = $('#email').val().trim();
		                				
		                				$.ajax({
		                					url: 'sendMail.mp',
		                					data: {email:email},
		                					success: function(data){
		                						console.log(data);
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
		                			});
		                			
		                			// 이메일로 보낸 인증코드와 일치하는지 검증
		                			$('#authCode').on('change keyup paste', function(){
		                				let inputCode = $(this).val().trim();
		                				
		                				if (inputCode != authCode) {
		                					$('#emailGuide').text('일치하지 않습니다.');
		                					$('#emailGuide').addClass('text-danger');
		                					$('#emailGuide').show();
		                					authCodeCheck = false;
		                				} else {
		                					$('#emailGuide').text('인증되었습니다.');
		                					$('#emailGuide').removeClass('text-danger').css('color', 'green');
		                					authCodeCheck = true;
		                				}
		                				
		                			});
		                			
		                			// 휴대전화 형식 체크
		                			let phoneCheck = true;
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
													                				
		                				if (originEmail == $('#email').val().trim()) {
		                					emailCheck = true;
		                					authCodeCheck = true;
		                				}
		                				
		                				console.log($('#email').val().trim());
		                				
		                				if ($('#email').val().trim() == "") {
		                					alert('이메일은 필수 입력사항입니다.');
		                				} else if (!emailCheck) {
		                					alert('이메일 인증을 진행해주세요.');
		                				} else if (!authCodeCheck) {
		                					alert('인증코드가 일치하지  않습니다.');
		                					$('#authCode').focus();
		                				} else if (!phoneCheck) {
		                					$('#phone').focus();
		                				} else {
		                					$('#updateForm').submit();
		                				}
		                				
		                			});
		                			
		                			
		                			// datepicker
		                			$(function(){
                                		// datepicker에 지우기 버튼 추가
                                		var old_fn = $.datepicker._updateDatepicker;
                                		
                                		$.datepicker._updateDatepicker = function(inst) {
                                			old_fn.call(this, inst);
                                			
                                			var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");
                                    		
                                    		$("<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>지우기</button>").appendTo(buttonPane).click(function(ev) {
                                    			$.datepicker._clearDate(inst.input);
                                    		});
                                		}
                                	});
		                			
                                	// 생년월일은 오늘 이전 날짜로만 선택 가능
	                            	$('#birthDate').datepicker({
	                            		dateFormat : 'yy-mm-dd',
	                            		prevText : '이전 달',
	                            		nextText : '다음 달',
	                            		cleanText : '지우기',
	                            		yearRange: '-100:+0',
	                            		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
	                            				'10월', '11월', '12월' ],
	                            		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
	                            				'9월', '10월', '11월', '12월' ],
	                            		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		showMonthAfterYear : true,
	                            		yearSuffix : '년',
	                            		buttonImageOnly : true,
	                            		changeMonth : true,
	                            		changeYear : true,
	                            		maxDate : '0',
	                            		showButtonPanel : true,
	                            		currentText : '오늘 날짜',
	                            		closeText : '닫기',
	                            		showAnim : "slide",
	                            		regional : "ko"
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
        
        <!--**********************************
            Content body end
        ***********************************-->

        <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright © Designed &amp; Developed by <a href="#" target="_blank">CODEUS</a> 2021</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->      
          
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->        
</body>
</html>