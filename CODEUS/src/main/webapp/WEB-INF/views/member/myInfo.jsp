<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Member Detail</title>
<style>
	.profile-photo img{width: 120px; height: 120px; margin-left: 10px;}
	.member-info{color: black; font-size: medium; margin-left: 10px;}
	.col-form-label{font-weight: bolder; width: 150px;}
	.form-col{padding-left: 15px;}
	.member-info input{display: inline;}
</style>
</head>
<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../member/menubar.jsp"/>
    
        <!--**********************************
            Content body start
        ***********************************-->
 		<div class="content-body">
            <div class="container-fluid">
             	<div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                       <b style="color: black; font-size: large;">사원 상세</b>
                   	</div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">조직 관리</li>
                            <li class="breadcrumb-item active">사원 상세</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                           		<div class="member-info">
                                    <form>
                                        <div class="profile-photo">
                                        	<c:if test="${ member.imgChangeName eq null }">
		                                 		<img src="${contextPath}/resources/assets/images/empty-profile.png" alt="profile-image">
		                               		</c:if>
		                               		<c:if test="${ member.imgChangeName ne null }">
		                                 		<img src="${contextPath}/resources/uploadFiles/${ member.imgChangeName }" alt="profile-image">
		                               		</c:if>
		                               	</div>
		                               	<br>
		                               	<label class="col-form-label">이름</label>
		                               	<input type="text" name="mName" class="form-control" style="width: 150px;">
		                               	<br>
		                               	<label class="col-form-label">아이디</label>${ member.mId }
		                               	<input type="hidden" name="mId" value="${ m.mId }">
										<br>
		                               	<label class="col-form-label">이메일</label>${ member.email }
		                               	<br>
		                               	<label class="col-form-label">생년월일</label>${ member.birthDate }
		                               	<input type="date" name="mName" style="width: 150px;">
		                               	<br>
		                               	<label class="col-form-label">전화번호</label>${ member.phone }
		                               	<br>
		                               	<label class="col-form-label">주소</label>${ member.address }
		                               	<br>
		                               	<div class="form-group row">
                                             <label class="form-col col-form-label">자기소개</label>
                                             <div class="col-lg-6">
                                                 <textarea rows="3" class="form-control" style="resize: none; width: 400px;" disabled>${ member.profile }</textarea>
                                             </div>
                                        </div>
                                        <label class="col-form-label">부서</label>
                                        <select>
                                        	<option>경영지원팀</option>
                                        	<option>개발팀</option>
                                        </select>
                                        <br>
                                        <label class="col-form-label">직위/직책</label>
                                        <select>
                                        	<option>사원</option>
                                        	<option>주임</option>
                                        	<option>대리</option>
                                        	<option>과장</option>
                                        	<option>차장</option>
                                        	<option>부장</option>
                                        	<option>이사</option>
                                        	<option>상무</option>
                                        	<option>전무</option>
                                        	<option>사장</option>
                                        </select>
                                        <br>
                                        <label class="col-form-label">입사일</label>
                                        <br>                                        
                                        <label class="col-form-label">퇴사일</label>
                                        <br>
                                    </form>
                                </div>
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