<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회의실 예약 - 예약 조회 </title>
    <!-- Custom Stylesheet -->
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">

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
                        <div class="welcome-text">
                            <h4>예약 조회</h4>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">회의실 예약</li>
                            <li class="breadcrumb-item active"><a href="mrlist.mr">예약 목록</a></li>
                            <li class="breadcrumb-item active"><a href="javascript:void(0)">예약 조회</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">예약 정보 입력</h4>
                            </div>
                            <div class="card-body">
                                <div class="form-validation">
                                    <form class="form-valide" action="#" method="post">
                                        <div class="row">
                                            <div class="col-xl-6">
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="username">사원명</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="username" name="username" value="${ loginUser.mName != NULL ? loginUser.mName : '-' }" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="email">이메일</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="email" name="email" value="${ loginUser.email != NULL ? loginUser.email : '-' }" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="jobName">직위</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="jobName" name="jobName" value="${ loginUser.jobName != NULL ? loginUser.jobName : '-' }" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="deptName">부서</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="deptName" name="deptName" value="${ loginUser.deptName != NULL ? loginUser.deptName : '-' }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6">
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="room">예약할 회의실
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6">
                                                        <select class="form-control" id="rooml" name="room">
                                                            <option value="">회의실을 선택해주세요.</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="date">예약날짜
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6">
                                                        <input name="datepicker" class="datepicker-default form-control" id="date">
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="start">시작시간
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6 input-group clockpicker">
                                                        <input type="text" class="form-control" value="09:00" id="start"> <span class="input-group-append"><span class="input-group-text"><i
                                                                    class="fa fa-clock-o"></i></span></span>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="end">종료시간
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6 input-group clockpicker">
                                                        <input type="text" class="form-control" value="10:00" id="end"> <span class="input-group-append"><span class="input-group-text"><i
                                                                    class="fa fa-clock-o"></i></span></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-12">
                                                <div class="form-group row">
                                                    <label class="col-lg-2 col-form-label" for="content">예약목적
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-10 form-group">
                                                        <textarea class="form-control" rows="6" id="content" placeholder="예약목적을 작성해주세요.."></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <div class="col-lg-1 ml-auto">
                                                        <button type="submit" class="btn btn-primary">신청하기</button>
                                                    </div>
                                                </div>
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
    
    
	    <!--**********************************
	        Scripts
	    ***********************************-->
    <!-- Required vendors -->
    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>

</body>

</html>