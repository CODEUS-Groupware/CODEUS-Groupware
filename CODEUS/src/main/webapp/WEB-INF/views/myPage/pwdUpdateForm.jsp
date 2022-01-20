<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	.pwd-update{color: black; font-size: medium;}
	.col-form-label{font-weight: bolder; width: 150px;} 
	.pwd-update input{
		display: inline;  width: 395px;
	}
	.guide{display: none; margin-left: 165px; font-size: small;}
	#inputArea{margin-left: 20%;}
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
                       <b style="color: black; font-size: large;">비밀번호 수정</b>
                   	</div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                           		<div class="pwd-update">
                           		 	<br><br>
                                    <form id="updatePwdForm" action="pwdpdate.mp" method="post">
                                    	<div id="inputArea">
                                    		<span class="text-danger">*</span><label class="col-form-label">현재 비밀번호</label>
					                        <input id="originPwd" type="password" name="originPwd" class="form-control" required><br>
					                        <span id="guide1" class="guide text-danger">내용을 입력하세요.</span>
					                        <br>
					                        <span class="text-danger">*</span><label class="col-form-label">새 비밀번호</label>
				                            <input id="mPwd" type="password" name="mPwd" class="form-control" required><br>
				                            <span id="guide2" class="guide text-danger">8~12자로 영어와 숫자, !*$만 가능합니다.(영어로 시작)</span>
				                            <br>
				                            <span class="text-danger">*</span><label class="col-form-label">새 비밀번호 확인</label>
				                            <input id="mPwdCheck" type="password" name="mPwdCheck" class="form-control" required><br>
				                            <span id="guide3" class="guide text-danger">비밀번호가 일치하지 않습니다.</span>
				                            <br><br>
				                            <input type="hidden" name="mId" value="${ loginUser.mId }">
                                    	</div>
				                        <div align="center">
			                            	<button type="button" class="btn btn-primary" id="submitBtn">저장</button>
				                            <button type="reset" class="btn btn-outline-primary">취소</button>
			                            </div> 
                                    </form>
                                </div>
                                <script>
                                
	                                let pwdCheck = false; // 비밀번호 정규식 검사
	                                let pwdCheck2 = false; // 비밀번호 확인 일치 여부
	                                
	                                $('#originPwd').on('blur', function(){
	                                	let originPwd = $('#originPwd').val().trim();
	                        			$('#originPwd').val(originPwd);	
	                        			
	                                	if (originPwd != "") {
	                                		$('#guide1').hide();
	                                	}
	                                });
	                                
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
	                        			
	                        			if ($('#originPwd').val().trim() == "") {
		                					$('#guide1').show();
		                					$('#originPwd').focus();     
	                        			} else if (!pwdCheck) {
	                        				$('#guide2').show();
		                					$('#mPwd').focus();    
	                        			} else if (!pwdCheck2) {
	                        				$('#guide3').show();
	                        				$('#mPwdCheck').focus();    
	                        			} else {
	                        				$('#updatePwdForm').submit();
	                        			}
	                        		});
                                	
	                        		// 현재 비밀번호와 일치하지 않을시 알럿창 띄움
		                			$(function(){
		                				if ('${message}' != '') {
		                					alert('현재 비밀번호가 일치하지 않습니다.');
		                					<c:remove var="message" scope="request"/>
		                					history.replaceState({}, null, location.pathname);
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