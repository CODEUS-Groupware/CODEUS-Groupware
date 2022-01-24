<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회의실 예약 - 조회 하기 </title>
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
                            <h4>예약 정보</h4>
                        </div>
                    </div>
                    <c:url var="mrlist" value="mrlist.mr">
                        <c:param name="page1" value="${ page1 }"/>
                    </c:url>
                    <c:url var="mrdetail" value="mrdetail.mr">
                        <c:param name="rNo" value="${ mr.rev_no }"/>
                        <c:param name="page1" value="${ page1 }"/>
                    </c:url>
                    <c:url var="mrcal" value="mrcalview.mr"/>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">회의실 예약</li>
                            <li class="breadcrumb-item active"><a href="${ mrlist }">예약 목록</a></li>
                            <li class="breadcrumb-item active"><a href="${ mrdetail }">예약 정보</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">예약 정보 조회</h4>
                            </div>
                            <div class="card-body">
                                <div class="form-validation">
                                    <div class="row">
                                        <div class="col-xl-6">
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="mName">사원명</label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="mName" name="mName" value="${ mr.mName != NULL ? mr.mName : '-' }" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="email">이메일</label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="email" name="email" value="${ mr.email != NULL ? mr.email : '-' }" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="jobName">직위</label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="jobName" name="jobName" value="${ mr.jobName != NULL ? mr.jobName : '-' }" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="deptName">부서</label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="deptName" name="deptName" value="${ mr.deptName != NULL ? mr.deptName : '-' }" readonly>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6">
                                            <div class="form-group row">
                                                <label class="col-lg-2 col-form-label" for="r_no">예약번호
                                                </label>
                                                <div class="col-lg-3">
                                                    <input type="text" class="form-control" id="r_no" name="r_no" value="${ mr.rev_no }" readonly>
                                                </div>
                                                <label class="col-lg-2 col-form-label" for="r_status">예약상태
                                                </label>
                                                <div class="col-lg-3">
                                                    <c:choose>
                                                        <c:when test="${ mr.rev_status eq 0 }">
                                                            <span class="badge badge-xl badge-success">예약 완료</span>
                                                        </c:when>
                                                        <c:when test="${ mr.rev_status eq 1 }">
                                                            <span class="badge badge-xl badge-secondary">사용 완료</span>
                                                        </c:when>
                                                        <c:when test="${ mr.rev_status eq 2 }">
                                                            <span class="badge badge-xl badge-warning">예약 취소</span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-2 col-form-label" for="r_date">예약날짜
                                                </label>
                                                <div class="col-lg-8">
                                                    <input type="text" class="form-control" id="r_date" name="r_date" value="${ mr.rev_date }" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-2 col-form-label" for="r_start_time">시작시간
                                                </label>
                                                <div class="col-lg-3">
                                                    <input type="text" class="form-control" id="r_start_time" name="r_start_time" value="${ mr.rev_start_time.getHours() == 9 ? '09' : mr.rev_start_time.getHours() }:${ mr.rev_start_time.getMinutes() == 0 ? '00' : '30' }" readonly>
                                                </div>
                                                <label class="col-lg-2 col-form-label" for="r_end_time">종료시간
                                                </label>
                                                <div class="col-lg-3">
                                                    <input type="text" class="form-control" id="r_end_time" name="r_end_time" value="${ mr.rev_end_time.getHours() == 9 ? '09' : mr.rev_end_time.getHours() }:${ mr.rev_end_time.getMinutes() == 0 ? '00' : '30' }" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-2 col-form-label" for="r_room">회의실
                                                </label>
                                                <div class="col-lg-8">
                                                    <input type="text" class="form-control" id="r_room" name="r_room" value="${ mr.meet_name }" readonly>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6">
                                            <div class="form-group row">
                                                <label class="col-lg-2 col-form-label" for="r_content">예약목적
                                                </label>
                                                <div class="col-lg-10 form-group">
                                                    <textarea class="form-control" rows="8" id="r_content" name="r_content" readonly>${ mr.rev_content }</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6">
                                            <div class="form-group row">
                                                <div class="col-lg-4">
                                                    <c:if test="${ mInfo.img_change_name eq null }">
                                                        <img class="img-fluid" id="room_img" src="${contextPath}/resources/assets/images/empty-photo.jpg" alt="회의실 사진">
                                                    </c:if>
                                                    <c:if test="${ mInfo.img_change_name ne null }">
                                                        <img class="img-fluid" id="room_img" src="${contextPath}/resources/uploadFiles/${ mInfo.img_change_name }" alt="회의실 사진">
                                                    </c:if>
                                                </div>
                                                <div class="col-lg-6">
                                                    <textarea class="form-control" rows="8" id="room_info" readonly>${ mInfo.meet_info }</textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-12">
                                            <div class="d-flex justify-content-end">
                                                <c:if test="${ cal == 0 }">
                                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='${ mrlist }'">돌아가기</button>
                                                </c:if>
                                                <c:if test="${ cal == 1 }">
                                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='${ mrcal }'">돌아가기</button>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
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