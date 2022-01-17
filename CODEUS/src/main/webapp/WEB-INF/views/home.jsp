<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>main page-dashboard</title>
    <link href="${contextPath}/resources/assets/vendor/pg-calendar/css/pignose.calendar.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/vendor/chartist/css/chartist.min.css" rel="stylesheet">
</head>
<style>
#comTimeBtn, #offTimeBtn, #addAnnualLeave{

 border-radius: 25px;
 width: 100px;
 height: 40px;
 background: none;
 border: 1px solid #593BDB;
 color:#593BDB;
 }
</style>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

		<c:import url="common/menubar.jsp"/>

        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                        <div class="welcome-text">
                            <h4>Hi, welcome back!</h4>
                            <p class="mb-0">Your business dashboard template</p>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="javascript:void(0)">Layout</a></li>
                            <li class="breadcrumb-item active"><a href="javascript:void(0)">Blank</a></li>
                        </ol>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-one card-body">
                                <div class="stat-icon d-inline-block">
                                    <i class="ti-money text-success border-success"></i>
                                </div>
                                <div class="stat-content d-inline-block">
                                    <div class="stat-text">Profit</div>
                                    <div class="stat-digit">1,012</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-one card-body">
                                <div class="stat-icon d-inline-block">
                                    <i class="ti-user text-primary border-primary"></i>
                                </div>
                                <div class="stat-content d-inline-block">
                                    <div class="stat-text">Customer</div>
                                    <div class="stat-digit">961</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-one card-body">
                                <div class="stat-icon d-inline-block">
                                    <i class="ti-layout-grid2 text-pink border-pink"></i>
                                </div>
                                <div class="stat-content d-inline-block">
                                    <div class="stat-text">Projects</div>
                                    <div class="stat-digit">770</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <div class="card">
                            <div class="stat-widget-one card-body">
                                <div class="stat-icon d-inline-block">
                                    <i class="ti-link text-danger border-danger"></i>
                                </div>
                                <div class="stat-content d-inline-block">
                                    <div class="stat-text">Referral</div>
                                    <div class="stat-digit">2,781</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Fee Collections and Expenses</h4>
                            </div>
                            <div class="card-body">
                                <div class="ct-bar-chart mt-5"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="ct-pie-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All Exam Result</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20">
                                        <thead>
                                            <tr>
                                                <th>Subject</th>
                                                <th>Grade Point</th>
                                                <th>Percent Form</th>
                                                <th>Percent Upto</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>Mathmatics</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>Mathmatics</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>English</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>Bangla</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>Mathmatics</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>English</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                            <tr>
                                                <td>Class Test</td>
                                                <td>Mathmatics</td>
                                                <td>
                                                    4.00
                                                </td>
                                                <td>
                                                    95.00
                                                </td>
                                                <td>
                                                    100
                                                </td>
                                                <td>20/04/2017</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xl-4 col-xxl-6 col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Timeline</h4>
                            </div>
                            <div class="card-body">
                                <div class="widget-timeline">
                                    <ul class="timeline">
                                        <li>
                                            <div class="timeline-badge primary"></div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>10 minutes ago</span>
                                                <h6 class="m-t-5">Youtube, a video-sharing website, goes live.</h6>
                                            </a>
                                        </li>

                                        <li>
                                            <div class="timeline-badge warning">
                                            </div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>20 minutes ago</span>
                                                <h6 class="m-t-5">Mashable, a news website and blog, goes live.</h6>
                                            </a>
                                        </li>

                                        <li>
                                            <div class="timeline-badge danger">
                                            </div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>30 minutes ago</span>
                                                <h6 class="m-t-5">Google acquires Youtube.</h6>
                                            </a>
                                        </li>

                                        <li>
                                            <div class="timeline-badge success">
                                            </div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>15 minutes ago</span>
                                                <h6 class="m-t-5">StumbleUpon is acquired by eBay. </h6>
                                            </a>
                                        </li>

                                        <li>
                                            <div class="timeline-badge warning">
                                            </div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>20 minutes ago</span>
                                                <h6 class="m-t-5">Mashable, a news website and blog, goes live.</h6>
                                            </a>
                                        </li>

                                        <li>
                                            <div class="timeline-badge dark">
                                            </div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>20 minutes ago</span>
                                                <h6 class="m-t-5">Mashable, a news website and blog, goes live.</h6>
                                            </a>
                                        </li>

                                        <li>
                                            <div class="timeline-badge info">
                                            </div>
                                            <a class="timeline-panel text-muted" href="#">
                                                <span>30 minutes ago</span>
                                                <h6 class="m-t-5">Google acquires Youtube.</h6>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-6 col-xxl-6 col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Notice Board</h4>
                            </div>
                            <div class="card-body">
                                <div class="recent-comment m-t-15">
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"><img class="media-object mr-3" src="${contextPath}/resources/assets/images/avatar/4.png" alt="..."></a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading text-primary">john doe</h4>
                                            <p>Cras sit amet nibh libero, in gravida nulla.</p>
                                            <p class="comment-date">10 min ago</p>
                                        </div>
                                    </div>
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"><img class="media-object mr-3" src="${contextPath}/resources/assets/images/avatar/2.png" alt="..."></a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading text-success">Mr. John</h4>
                                            <p>Cras sit amet nibh libero, in gravida nulla.</p>
                                            <p class="comment-date">1 hour ago</p>
                                        </div>
                                    </div>
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"><img class="media-object mr-3" src="${contextPath}/resources/assets/images/avatar/3.png" alt="..."></a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading text-danger">Mr. John</h4>
                                            <p>Cras sit amet nibh libero, in gravida nulla.</p>
                                            <div class="comment-date">Yesterday</div>
                                        </div>
                                    </div>
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"><img class="media-object mr-3" src="${contextPath}/resources/assets/images/avatar/4.png" alt="..."></a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading text-primary">john doe</h4>
                                            <p>Cras sit amet nibh libero, in gravida nulla.</p>
                                            <p class="comment-date">10 min ago</p>
                                        </div>
                                    </div>
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"><img class="media-object mr-3" src="${contextPath}/resources/assets/images/avatar/2.png" alt="..."></a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading text-success">Mr. John</h4>
                                            <p>Cras sit amet nibh libero, in gravida nulla.</p>
                                            <p class="comment-date">1 hour ago</p>
                                        </div>
                                    </div>
                                    <div class="media no-border">
                                        <div class="media-left">
                                            <a href="#"><img class="media-object mr-3" src="${contextPath}/resources/assets/images/avatar/3.png" alt="..."></a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading text-info">Mr. John</h4>
                                            <p>Cras sit amet nibh libero, in gravida nulla.</p>
                                            <div class="comment-date">Yesterday</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-xxl-6 col-lg-6 col-md-12 col-sm-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Todo</h4>
                            </div>
                            <div class="card-body px-0">
                                <div class="todo-list">
                                    <div class="tdl-holder">
                                        <div class="tdl-content widget-todo2 mr-4">
                                            <ul id="todo_list">
                                                <li><label><input type="checkbox"><i></i><span>Get up</span><a href='#'
                                                            class="ti-trash"></a></label></li>
                                                <li><label><input type="checkbox" checked><i></i><span>Stand up</span><a
                                                            href='#' class="ti-trash"></a></label></li>
                                                <li><label><input type="checkbox"><i></i><span>Don't give up the
                                                            fight.</span><a href='#' class="ti-trash"></a></label></li>
                                                <li><label><input type="checkbox" checked><i></i><span>Do something
                                                            else</span><a href='#' class="ti-trash"></a></label></li>
                                                <li><label><input type="checkbox" checked><i></i><span>Stand up</span><a
                                                            href='#' class="ti-trash"></a></label></li>
                                                <li><label><input type="checkbox"><i></i><span>Don't give up the
                                                            fight.</span><a href='#' class="ti-trash"></a></label></li>
                                            </ul>
                                        </div>
                                        <div class="px-4">
                                            <input type="text" class="tdl-new form-control" placeholder="Write new item and hit 'Enter'...">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-12 col-xxl-6 col-lg-6 col-md-12">
                        <div class="row">
                            <div class="col-xl-3 col-lg-6 col-sm-6 col-xxl-6 col-md-6">
                                <div class="card">
                                    <div class="social-graph-wrapper widget-facebook">
                                        <span class="s-icon"><i class="fa fa-facebook"></i></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-6 border-right">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">89</span> k</h4>
                                                <p class="m-0">Friends</p>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">119</span> k</h4>
                                                <p class="m-0">Followers</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-6 col-sm-6 col-xxl-6 col-md-6">
                                <div class="card">
                                    <div class="social-graph-wrapper widget-linkedin">
                                        <span class="s-icon"><i class="fa fa-linkedin"></i></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-6 border-right">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">89</span> k</h4>
                                                <p class="m-0">Friends</p>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">119</span> k</h4>
                                                <p class="m-0">Followers</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-6 col-sm-6 col-xxl-6 col-md-6">
                                <div class="card">
                                    <div class="social-graph-wrapper widget-googleplus">
                                        <span class="s-icon"><i class="fa fa-google-plus"></i></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-6 border-right">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">89</span> k</h4>
                                                <p class="m-0">Friends</p>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">119</span> k</h4>
                                                <p class="m-0">Followers</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-6 col-sm-6 col-xxl-6 col-md-6">
                                <div class="card">
                                    <div class="social-graph-wrapper widget-twitter">
                                        <span class="s-icon"><i class="fa fa-twitter"></i></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-6 border-right">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">89</span> k</h4>
                                                <p class="m-0">Friends</p>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="pt-3 pb-3 pl-0 pr-0 text-center">
                                                <h4 class="m-1"><span class="counter">119</span> k</h4>
                                                <p class="m-0">Followers</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div id="nowDateArea">
	                        	<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E) hh:mm:ss" /></c:set>
									 <c:out value="${date}" />
									<div id="clock"></div>
								<c:choose>
									<c:when test="${! empty empStatus1.getEmpOnTime() && ! empty sessionScope.empStatus1}">
	                            		<input type="button" id="comTimeBtn" onclick="comTime();" value="출근시간" disabled="disabled" style="border: 1px solid gray; color: gray;">
	                            	</c:when>	
	                            	<c:otherwise>
	                            		<input type="button" id="comTimeBtn" onclick="comTime();" value="출근시간" >
	                            	</c:otherwise>
                       			</c:choose>	
                       			<c:choose>
									<c:when test="${! empty empStatus1.getEmpOffTime() && ! empty sessionScope.empStatus1}">
	                            		<input type="button" id="offTimeBtn" onclick="offTime();" value="퇴근시간" disabled="disabled" style="border: 1px solid gray; color: gray;">
	                            	</c:when>
	                            	<c:otherwise>
	                            		<input type="button" id="offTimeBtn" onclick="offTime();" value="퇴근시간" >
	                            	</c:otherwise>		
	                            </c:choose>				
                        </div>
                        
                            </div>
                        </div>
                        <!-- /# card -->
                    </div>
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All Expense</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20">
                                        <thead>
                                            <tr>
                                                <th>Expense Type</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Email</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-warning">Pending</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-danger">Due</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
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

        <!--**********************************
           Support ticket button start
        ***********************************-->

        <!--**********************************
           Support ticket button end
        ***********************************-->


    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <script src="${contextPath}/resources/assets/vendor/chartist/js/chartist.min.js"></script>

    <script src="${contextPath}/resources/assets/vendor/moment/moment.min.js"></script>
    <script src="${contextPath}/resources/assets/vendor/pg-calendar/js/pignose.calendar.min.js"></script>


    <script src="${contextPath}/resources/assets/js/dashboard/dashboard-2.js"></script>
    <!-- Circle progress -->

</body>
 <script>
    function printTime() {
    	
		
	    var now = new Date();// 현재시간
	    var nowTime =  now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
	
	    clock.innerHTML = nowTime;// 현재시간을 출력
	    setTimeout("printTime()",1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	}
    
    
	  //출근시간 출력
		function comTime(){
			
			var now = new Date();
			var nowDate =  now.getFullYear() + "/" + (now.getMonth()+1)+"/"+now.getDate();
			var nowTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() ;//현재시간
			var day = new Date();
			console.log(day);
			
			console.log(nowTime);			
			
			$.ajax({
				url:'comTime.em',
				data:{day:day, nowTime:nowTime},
				dataType: 'json',
				success:function(data){
					
					var onTime = data.empOntime;
					var offTime = data.empOffTime;
					
					if(onTime != ''){
						$('#comTimeBtn').attr("disabled","disabled");
						$('#comTimeBtn').css('color','gray');
						$('#comTimeBtn').css('border-color','gray');
					}else if(offTime != ''){
						$('#offTimeBtn').attr("disabled","disabled");
						$('#offTimeBtn').css('color','gray');
						$('#offTimeBtn').css('border-color','gray');
					}
					 
				},
				error:function(data){
					console.log(data);
				}
			});

		}

	  function offTime(){
			
			var now = new Date();
			var nowDate =  now.getFullYear() + "/" + (now.getMonth()+1)+"/"+now.getDate();
			var offTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() ;//현재시간
			var off = new Date();
			var status = "업무종료";
			$.ajax({
				url:'offTime.em',
				data:{off:off, 
					offTime:offTime,
					status:status
					},
				dataType: 'json',
				success:function(data){
					console.log(data);
					
					if(offTime != ''){
						$('#offTimeBtn').attr("disabled","disabled");
						$('#offTimeBtn').css('color','gray');
						$('#offTimeBtn').css('border-color','gray');
					}
					 
				},
				error:function(data){
					console.log(data);
				}
			});

		}
	  
	  //연차자동생성
	  function addAnnualLeave(){
		  $.ajax({
			  url:'addAnnualLeave.al',
			  success:function(data){
					console.log(data);
					alert(data); 
				},
				error:function(data){
					console.log(data);
					alert(data); 
				}
		  });
	  }
    
    </script>

</html>