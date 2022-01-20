<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 내 정보 조회 </title>
<style>
	.profile-photo img{width: 150px; height: 150px; margin-top: 30px; margin-left: 30px;}
	.member-info{color: black; font-size: medium; margin-left: 10px;}
	.form-col{padding-left: 15px;}
	.member-info input{display: inline;}
	.col-form-label{font-weight: bolder; width: 150px;}
	.form-col{padding-left: 15px;}
	.member-info input[type=date], .member-info input[type=text], .member-info select{display: inline;  width: 150px;}
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
                       <b style="color: black; font-size: large;">내 정보</b>
                   	</div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                           		<div class="member-info">
                                    	<div class="email-left-box px-0 mb-5">
		                                	<div class="profile-photo">
		                                    	<c:if test="${ loginUser.imgChangeName eq null }">
				                                	<img src="${contextPath}/resources/assets/images/empty-profile.png" alt="profile-image">
				                               	</c:if>
				                               	<c:if test="${ loginUser.imgChangeName ne null }">
				                                 	<img src="${contextPath}/resources/uploadFiles/${ loginUser.imgChangeName }" alt="profile-image">
				                               	</c:if>
				                       		</div>
		                               	</div>	
		                               	<br>
		                               	<div class="email-right-box ml-0 ml-sm-4 ml-sm-0">
			                               	<label class="col-form-label">이름</label>${ loginUser.mName }
			                               	<br>
			                               	<label class="col-form-label">아이디</label>${ loginUser.mId }
			                               	<input type="hidden" name="mId" value="${ loginUser.mId }">
											<br>
			                               	<label class="col-form-label">이메일</label>${ loginUser.email }
			                               	<br>
			                               	<label class="col-form-label">전화번호</label>${ loginUser.phone }
			                               	<br>
			                               	<label class="col-form-label">생년월일</label>${ loginUser.birthDate }
			                               	<br>
			                               	<label class="col-form-label">주소</label>
			                               	<c:forTokens var="addr" items="${ loginUser.address }" delims="/" varStatus="status">
												<c:if test="${ status.index eq 0 && addr >= '0' && addr <= '99999' }">
													(${ addr })
												</c:if>
												<c:if test="${ status.index eq 0 && !(addr >= '0' && addr <= '99999') }">
													${ addr }
												</c:if>
												<c:if test="${ status.index eq 1 }">
													${ addr }
												</c:if>
												<c:if test="${ status.index eq 2 }">
													${ addr }
												</c:if>
											</c:forTokens>
			                               	<br>
			                               	<div class="form-group row">
	                                             <label class="form-col col-form-label">자기소개</label>
	                                             <div class="col-lg-6">
	                                                 <textarea rows="3" class="form-control" style="resize: none; width: 400px;" disabled>${ loginUser.profile }</textarea>
	                                             </div>
	                                        </div>
	                                        <label class="col-form-label">부서</label>${ loginUser.deptName == null ? "미지정" : loginUser.deptName }
	                                        <br>
	                                        <label class="col-form-label">직위</label>${ loginUser.jobName == null ? "미지정" : loginUser.jobName }
	                                        <br>
	                                        <label class="col-form-label">입사일</label>${ loginUser.hireDate }
	                                        <br>
	                                       	<label class="col-form-label">관리자 여부</label>${ loginUser.managerYn }
                                       </div>
                                       <br>
                                        <div align="center">
	                                       <button type="button" class="btn btn-primary" id="updateFormBtn" onclick="location.href='mupdateView.mp'">정보 수정하기</button>
	                                       <button type="button" class="btn btn-outline-primary" id="pwdUpdateFormBtn" onclick="location.href='pwdupdateView.mp'">비밀번호 수정하기</button>
	                                   </div>
                                </div>
                                <script>            
									
									// 수정 성공시 success 알럿창 띄우기
		                			$(function(){
		                				if ('${message}' != '') {
		                					alert('변경되었습니다.');
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